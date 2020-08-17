# #!/bin/bash

echo "For git setup what's your name:"
read name
echo "… and your email address?"
read email
echo "Cool, and your password for those sudo commands:"
sudo -v
echo "Awesome, let's go!"

sudo xcode-select --reset

# Allow apps to be installed from anywhere, this is required so vscode can install extensions
sudo spctl --master-disable

echo "→ Homebrewing important stuff…"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
brew update
brew tap homebrew/cask-fonts
mkdir $HOME/.n
export N_PREFIX=$HOME/.n
brew install n git
brew cask install firefox font-cascadia font-hack font-montserrat font-roboto font-roboto-mono github google-chrome slack
brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlimagesize qlvideo webpquicklook

echo "  … visual studio code"
brew cask install visual-studio-code

code --install-extension aaron-bond.better-comments
code --install-extension christian-kohler.npm-intellisense
code --install-extension dbaeumer.vscode-eslint
code --install-extension eamodio.gitlens
code --install-extension editorconfig.editorconfig
code --install-extension eg2.vscode-npm-script
code --install-extension esbenp.prettier-vscode
code --install-extension firefox-devtools.vscode-firefox-debug
code --install-extension formulahendry.auto-close-tag
code --install-extension formulahendry.auto-rename-tag
code --install-extension foxundermoon.shell-format
code --install-extension jkjustjoshing.vscode-text-pastry
code --install-extension kisstkondoros.vscode-codemetrics
code --install-extension MaxvanderSchee.web-accessibility
code --install-extension ms-vscode.sublime-keybindings
code --install-extension oliversturm.fix-json
code --install-extension shinnn.alex
code --install-extension streetsidesoftware.code-spell-checker
code --install-extension syler.sass-indented
code --install-extension travisthetechie.write-good-linter
code --install-extension yzhang.markdown-all-in-one

echo "→ Configuring Git…"
git config --global user.name $name
git config --global user.email $email # "<username>@users.noreply.github.com"
git config --global credential.helper osxkeychain
touch ~/.gitignore_global
git config --global core.excludesfile ~/.gitignore_global
echo ".vscode" >>~/.gitignore_global

echo "→ Installing NodeJS/NPM stuff…"
n 8
mkdir ~/.npm-global
npm config set prefix '~/.npm-global'
export PATH=$N_PREFIX/bin:$HOME/.npm-global/bin:$PATH
npm i -g npm@latest
rm -rf ~/n/bin/npm
ln -s ~/.npm-global/bin/npm ~/n/bin/npm
# set `--no-optional` globally for `npm install`
npm set optional false

npm i -g write-good alex serve prettier svgo fast-cli nodemon

echo "→ Homebrewing less important stuff…"

brew cask install appcleaner beyond-compare docker imagealpha imageoptim joplin
brew tap AdoptOpenJDK/openjdk
brew cask install adoptopenjdk8 react-native-debugger
brew install watchman redis graphicsmagick

materVer=$(curl https://api.github.com/repos/jasonlong/mater/releases/latest -s |
  grep tag_name |
  head -1 |
  awk -F: '{ print $2 }' |
  sed 's/[",]//g' |
  tr -d '[[:space:]]')

echo "→ Installing Mater $materVer…"
curl -# -L -O https://github.com/jasonlong/mater/releases/download/$materVer/Mater-darwin-x64.zip
unzip -q *.zip
mv *.app /Applications
rm -rf Mater-darwin-x64.zip
rm -rf Mater-darwin-x64
rm -rf __MACOSX

brew services start redis

# Re-enable gatekeeper for mac
sudo spctl --master-enable

echo "→ Installing Oh My Zsh…"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
