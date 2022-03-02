# #!/bin/bash

################################################################################################

echo "For git setup what's your name:"
read name
echo "… and your email address?"
read email
echo "Cool, and your password for those sudo commands:"
sudo -v
echo "Awesome, let's go!"

################################################################################################

echo "→ Installing XCode CLI…"

xcode-select --install
sudo xcode-select --reset

################################################################################################

# Required so vscode can install extensions
echo "→ Allowing apps to be installed from anywhere…"

sudo spctl --master-disable

################################################################################################

echo "→ Installing HomeBrew…"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew update
brew tap homebrew/cask-fonts

################################################################################################

echo "→ Homebrewing important stuff…"

mkdir $HOME/.n
export N_PREFIX=$HOME/.n

brew install \
  gh \
  git \
  n

brew install --cask \
  firefox \
  font-cascadia \
  font-hack \
  font-montserrat \
  font-roboto \
  font-roboto-mono \
  github \
  google-chrome slack \
  iterm2 \
  visual-studio-code

################################################################################################

echo "→ Configuring Git…"

git config --global user.name $name
git config --global user.email $email # "<username>@users.noreply.github.com"
git config --global credential.helper osxkeychain
git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
touch ~/.gitignore_global
git config --global core.excludesfile ~/.gitignore_global

################################################################################################

echo "Installing VSCode extensions"

code --install-extension \
  aaron-bond.better-comments \
  aeschli.vscode-css-formatter \
  akamud.vscode-javascript-snippet-pack \
  akamud.vscode-theme-onedark \
  akamud.vscode-theme-onelight \
  amazonwebservices.aws-toolkit-vscode \
  ardenivanov.svelte-intellisense \
  atlassian.atlascode \
  bengreenier.vscode-node-readme \
  bierner.markdown-emoji \
  bierner.markdown-preview-github-styles \
  BogdanIonita.cxx-light-theme \
  brianruizy.material-kai \
  christian-kohler.npm-intellisense \
  christian-kohler.path-intellisense \
  codezombiech.gitignore \
  DavidAnson.vscode-markdownlint \
  dbaeumer.vscode-eslint \
  DotJoshJohnson.xml \
  dsznajder.es7-react-js-snippets \
  ducfilan.pug-formatter \
  eamodio.gitlens \
  eg2.vscode-npm-script \
  emilast.LogFileHighlighter \
  esbenp.prettier-vscode \
  felipe-mendes.slack-theme \
  firefox-devtools.vscode-firefox-debug \
  formulahendry.auto-close-tag \
  formulahendry.auto-rename-tag \
  foxundermoon.next-js \
  foxundermoon.shell-format \
  GitHub.github-vscode-theme \
  GitHub.vscode-pull-request-github \
  glen-84.sass-lint \
  golang.go \
  GraphQL.vscode-graphql \
  Gruntfuggly.todo-tree \
  hashicorp.terraform \
  IBM.output-colorizer \
  imagio.vscode-dimmer-block \
  inu1255.easy-snippet \
  ionutvmi.path-autocomplete \
  jkjustjoshing.vscode-text-pastry \
  joaomoreno.github-sharp-theme \
  jock.svg \
  kisstkondoros.csstriggers \
  kisstkondoros.vscode-codemetrics \
  kisstkondoros.vscode-gutter-preview \
  lostintangent.vsls-whiteboard \
  luqimin.tiny-light \
  Luxcium.pop-n-lock-theme-vscode \
  markis.code-coverage \
  MaxvanderSchee.web-accessibility \
  ms-azuretools.vscode-docker \
  ms-python.python \
  ms-python.vscode-pylance \
  ms-toolsai.jupyter \
  ms-toolsai.jupyter-keymap \
  ms-toolsai.jupyter-renderers \
  ms-vscode-remote.remote-containers \
  ms-vscode.sublime-keybindings \
  ms-vscode.vscode-typescript-tslint-plugin \
  ms-vsliveshare.vsliveshare \
  ms-vsliveshare.vsliveshare-audio \
  msjsdiag.debugger-for-edge \
  msjsdiag.vscode-react-native \
  naco-siren.gradle-language \
  nhoizey.gremlins \
  NuclleaR.vscode-extension-auto-import \
  oderwat.indent-rainbow \
  oliversturm.fix-json \
  PKief.material-icon-theme \
  rafamel.subtle-brackets \
  redhat.vscode-commons \
  redhat.vscode-xml \
  redhat.vscode-yaml \
  richie5um2.vscode-sort-json \
  rickynormandeau.mariana-pro \
  RobbOwen.synthwave-vscode \
  samundrak.esdoc-mdn \
  Semgrep.semgrep \
  sirmspencer.vscode-autohide \
  streetsidesoftware.code-spell-checker \
  svelte.svelte-vscode \
  syler.sass-indented \
  ThreadHeap.serverless-ide-vscode \
  tht13.html-preview-vscode \
  tinaciousdesign.theme-tinaciousdesign \
  tomoki1207.pdf \
  travisthetechie.write-good-linter \
  usernamehw.errorlens \
  VisualStudioExptTeam.vscodeintellicode \
  wix.vscode-import-cost \
  wmaurer.change-case \
  yzhang.markdown-all-in-one \
  zaaack.markdown-editor

echo ".vscode" >>~/.gitignore_global

################################################################################################

echo "→ Installing NodeJS/NPM stuff…"
n 14
mkdir ~/.npm-global
npm config set prefix '~/.npm-global'
export PATH=$N_PREFIX/bin:$HOME/.npm-global/bin:$PATH
rm -rf ~/n/bin/npm
ln -s ~/.npm-global/bin/npm ~/n/bin/npm
# set `--no-optional` globally for `npm install`
npm set optional false

################################################################################################

echo "→ Homebrewing less important stuff…"

brew tap homebrew/cask-versions
brew install --cask \
  appcleaner \
  beyond-compare \
  docker \
  font-hack-nerd-font \
  imagealpha \
  imageoptim \
  joplin \
  postman \
  react-native-debugger \
  signal \
  slack \
  sublime-text \
  temurin8 # openjdk

brew install \
  graphicsmagick \
  redis \
  jq \
  watchman \
  zsh-completions \
  zsh-syntax-highlighting

################################################################################################

# install an app from a github repo e.g. `ghInstall jasonlong/mater`
function ghInstall() {
  echo "→ Installing $1 from GitHub…"
  BASE_URL=https://api.github.com/repos/$1/releases/latest
  DOWNLOAD_URL=$(curl $URL -s |
    grep browser_download_url |
    head -1 |
    sed 's/[", ]//g' |
    sed 's/browser_download_url://g')

  mkdir gh-temp
  cd gh-temp
  curl -# -L -O $DOWNLOAD_URL
  unzip -q *.zip
  ls -lah
  mv */*.app /Applications
  ls -lah
  cd ..
  rm -rf gh-temp
}

ghInstall jasonlong/mater

################################################################################################

# show hidden files
defaults write com.apple.finder AppleShowAllFiles YES

# show path bar
defaults write com.apple.finder ShowPathbar -bool true

# show status bar
defaults write com.apple.finder ShowStatusBar -bool true

killall Finder

################################################################################################

brew services start redis
brew services start watchman

# Re-enable gatekeeper for mac
sudo spctl --master-enable

################################################################################################

echo "→ Installing Oh My Zsh…"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Manually, after:
# git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
