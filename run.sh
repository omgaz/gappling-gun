# #!/bin/bash
echo "For git setup what's your name:"
read name
echo "… and your email address?"
read email
echo "Cool, and your password for those sudo commands:"
sudo -v
echo "Awesome, let's go!"

sudo chown -R $(whoami) /usr/local

sudo xcode-select --reset

echo "→ Installing Homebrew Packages…"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew update
brew tap homebrew/cask-fonts
brew install git graphicsmagick node
brew cask install github virtualbox gitup ubar typora appcleaner sublime-text slack licecap postbox google-chrome firefox beyond-compare hyper font-hack font-montserrat font-roboto font-roboto-mono visual-studio-code imageoptim imagealpha vlc java

echo "→ Configuring Git…"
git config --global user.name $name
git config --global user.email $email
git config --global credential.helper osxkeychain

echo "→ Installing Oh My Zsh…"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
curl -fsSL https://gist.githubusercontent.com/omgaz/61819cd3f8e9c19cdee8cffdfb794cac/raw/81f5e0268814bcefc66b26e3011d5d39b278d2a9/.zshrc >> ~/.zshrc
zsh

echo "→ Installing NodeJS/NPM stuff…"
mkdir ~/.npm-global
npm config set prefix '~/.npm-global'
npm i -g n npm@latest
n lts
rm -rf ~/n/bin/npm
ln -s ~/.npm-global/bin/npm ~/n/bin/npm
npm i -g write-good alex eslint pure-prompt serve svgo fast-cli

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

echo "✓ Complete."
