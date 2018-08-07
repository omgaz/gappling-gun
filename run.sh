# #!/bin/bash

typora='https://typora.io/download/Typora.dmg'
licecap='https://www.cockos.com/licecap/licecap128.dmg'
chrome='https://dl.google.com/chrome/mac/stable/GGRO/googlechrome.dmg'
st3='https://download.sublimetext.com/Sublime%20Text%20Build%203176.dmg'
firefox='https://download-installer.cdn.mozilla.net/pub/firefox/releases/61.0.1/mac/en-GB/Firefox%2061.0.1.dmg'
postbox='https://d3nx85trn0lqsg.cloudfront.net/mac/postbox-6.1.1-mac64.dmg'
vbox='https://download.virtualbox.org/virtualbox/5.2.16/VirtualBox-5.2.16-123759-OSX.dmg'

githubdesktop='https://desktop.githubusercontent.com/releases/1.3.2-ed5395e6/GitHubDesktop.zip'
beyondcompare='https://www.scootersoftware.com/BCompareOSX-4.2.6.23150.zip'
mater='https://github.com/jasonlong/mater/releases/download/v1.0.3/Mater-darwin-x64.zip'
ubar='https://brawersoftware.com/downloads/ubar/ubar.zip'
appcleaner='https://freemacsoft.net/downloads/AppCleaner_3.4.zip'
gitup='https://s3-us-west-2.amazonaws.com/gitup-builds/stable/GitUp.zip'
vscode='https://az764295.vo.msecnd.net/stable/1dfc5e557209371715f655691b1235b6b26a06be/VSCode-darwin-stable.zip'

imageoptim='https://imageoptim.com/ImageOptim.tbz2'
imagealpha='https://pngmini.com/ImageAlpha1.5.1.tar.bz2'


declare -a apps=($vbox $ubar $appcleaner $vscode $gitup $typora $st3 $postbox $licecap $imageoptim $imagealpha $hyper $githubdesktop $firefox $chrome $beyondcompare $mater)

echo "→ Installing Homebrew Packages…"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew update
brew install git graphicsmagick
brew cask install hyper font-hack font-montserrat font-roboto font-roboto-mono

echo "↓ Downloading…"
for appurl in "${apps[@]}"; do
  echo $appurl
  if ! curl -# -O $appurl; then
    printf 'Curl failed with error code "%d" (check the manual)\n' "$?" >&2
  fi
done

echo "→ Installing Zips…"

# ubar, mater, beyond-compare, github desktop, app cleaner, gitup, vscode
unzip -q *.zip

# imageoptim, imagealpha
tar jxf  *.tbz2
tar jxf  *.bz2
mv *.app /Applications

echo "→ Mounting Archives…"
# chrome, licecap, typora, firefox, sublime text
for dmg in *.dmg; do
  hdiutil attach -quiet "$dmg"
done

echo "→ Installing Apps…"
for app in /Volumes/*/*.app; do
  appdirname="$(dirname "$app")"
  cp -n -R "${app}" /Applications
  hdiutil unmount -quiet "$appdirname"
done

echo "→ Installing Packages…"
# virtualbox
for pkg in /Volumes/*/*.pkg; do
  pkgdirname="$(dirname "$pkg")"
  echo $pkgdirname
  sudo installer -package $pkg -target "/Volumes/Macintosh HD"
  hdiutil unmount -quiet "$pkgdirname"
done

echo "→ Installing NodeJS…"
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
echo "write-good\nalex\nproselint\npure-prompt\nserve\nsvgo\nfast-cli" >> $NVM_DIR/default-packages
nvm install --lts=carbon
nvm use --lts=carbon

echo "→ Installing Oh My Zsh…"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo "✓ Complete."
