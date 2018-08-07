Gappling Gun is an automated app installer for MacOS.

It bootstraps a fresh Mac install with basic apps and utils via brew, npm, github, and app installs.

For a new machine install homebrew and git:

```bash
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew update
brew install git
```

```bash
git clone https://github.com/omgaz/gappling-gun
cd gappling-gun
chmod +x ./run.sh
./run.sh
```

Otherwise feel free to modify the files to customise the apps you're after.

