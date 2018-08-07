## Gappling Gun :gun:

Gappling Gun is an automated app installer for MacOS.

It bootstraps a fresh Mac install with basic apps and utils via brew, npm, github, and app installs.

A bash script that takes in an array of URLs, downloads the `.dmg`, `.zip`, `.tbz2`, or `.bz2` files, and then installs their `.app`/`.pkg`.

## Automate :robot:

via `curl`

```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/omgaz/gappling-gun/master/run.sh)"
```

If you have git clone the repo, and run the gappling gun:

```shell
git clone https://github.com/omgaz/gappling-gun
cd gappling-gun
chmod +x ./run.sh
./run.sh
```

## Relax :coffee:

> Go grab a coffee

Don't worry if a bunch of windows appear, let it do its thing, it'll unmount when its done

## What's included

* Typora
* LiceCap
* Chrome
* Sublime Text 3
* Firefox
* Postbox
* Virtual Box
* GitHub Desktop
* Beyond Compare
* Mater
* uBar
* Image Optim
* Image Alpha
* Graphics Magick
* Hyper
* font-hack
* font-montserrat
* font-roboto
* font-roboto-mono
* NodeJS
* NPM
* NVM
* Oh My Zsh

## Known Issues :bug:

Sometimes Google Chrome asks to accept T&C on install, you can just `:q` and `Y` to accept

I don't delete any of the install files (in case they fail you can install them manually), but you may need to clean-up when you're done.

Install URLs are recent as at commit. This should probably be extracted for easier updating and maintenance.
