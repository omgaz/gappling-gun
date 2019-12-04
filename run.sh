# #!/bin/bash
echo "For git setup what's your name:"
read name
echo "… and your email address?"
read email
echo "Cool, and your password for those sudo commands:"
sudo -v
echo "Awesome, let's go!"
echo "Copy and paste your .zshrc url from gist"
echo "Enter your .zshrc gist url [https://gist.githubusercontent.com/omgaz/61819cd3f8e9c19cdee8cffdfb794cac/raw/7e91ee2d67830abcad28f1ddce0a36f3d0ba7652/.zshrc]: "
read zshrcraw
zshrcraw=${zshrcraw:-https://gist.githubusercontent.com/omgaz/61819cd3f8e9c19cdee8cffdfb794cac/raw/7e91ee2d67830abcad28f1ddce0a36f3d0ba7652/.zshrc}
echo "Copy and paste your vscode settings url from gist [https://gist.githubusercontent.com/omgaz/759a7100095c2a3001d6ccc541b1e50e/raw/d6bfb2aa2a3ea2d4f3c88c24abf08e8b42a2f7ac/settings.json]: "
read vscodesettings
vscodesettings=${vscodesettings:-https://gist.githubusercontent.com/omgaz/759a7100095c2a3001d6ccc541b1e50e/raw/d6bfb2aa2a3ea2d4f3c88c24abf08e8b42a2f7ac/settings.json}

sudo chown -R $(whoami) /usr/local

sudo xcode-select --reset

echo "→ Installing Homebrew Packages…"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew update
brew tap homebrew/cask-fonts
brew install git graphicsmagick node
brew cask install appcleaner beyond-compare docker firefox font-cascadia font-hack font-montserrat font-roboto font-roboto-mono github gitup google-chrome imagealpha imageoptim java licecap postbox slack typora ubar virtualbox visual-studio-code

curl -fsSL $vscodesettings >>~/Library/Application Support/Code/User/settings.json

code --install-extension aaron-bond.better-comments
code --install-extension aeschli.vscode-css-formatter
code --install-extension dbaeumer.vscode-eslint
code --install-extension dotjoshjohnson.xml
code --install-extension eamodio.gitlens
code --install-extension emmanuelbeziat.vscode-great-icons
code --install-extension esbenp.prettier-vscode
code --install-extension formulahendry.auto-close-tag
code --install-extension formulahendry.auto-rename-tag
code --install-extension foxundermoon.shell-format
code --install-extension hookyqr.beautify
code --install-extension jkjustjoshing.vscode-text-pastry
code --install-extension kenhowardpdx.vscode-gist
code --install-extension kisstkondoros.vscode-codemetrics
code --install-extension MaxvanderSchee.web-accessibility
code --install-extension ms-vscode.sublime-keybindings
code --install-extension oliversturm.fix-json
code --install-extension ritwickdey.LiveServer
code --install-extension shinnn.alex
code --install-extension streetsidesoftware.code-spell-checker
code --install-extension travisthetechie.write-good-linter
code --install-extension trongthanh.theme-boxythemekit
code --install-extension yzhang.markdown-all-in-one

echo "→ Configuring Git…"
git config --global user.name $name
git config --global user.email $email
git config --global credential.helper osxkeychain

echo "→ Installing NodeJS/NPM stuff…"
mkdir ~/.npm-global
npm config set prefix '~/.npm-global'
npm i -g n npm@latest
n lts
rm -rf ~/n/bin/npm
ln -s ~/.npm-global/bin/npm ~/n/bin/npm
npm i -g write-good alex eslint pure-prompt serve prettier svgo fast-cli

materVer=$(curl https://api.github.com/repos/jasonlong/mater/releases/latest -s \
  | grep tag_name \
  | head -1 \
  | awk -F: '{ print $2 }' \
  | sed 's/[",]//g' \
  | tr -d '[[:space:]]')

echo "→ Installing Mater $materVer…"
curl -# -L -O https://github.com/jasonlong/mater/releases/download/$materVer/Mater-darwin-x64.zip
unzip -q *.zip
mv *.app /Applications
rm -rf Mater-darwin-x64.zip

echo "→ Installing Oh My Zsh…"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

curl -fsSL $zshrcraw >>~/.zshrc
zsh

echo "✓ Complete."
