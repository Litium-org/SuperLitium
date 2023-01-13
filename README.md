![](https://raw.githubusercontent.com/Litium-org/SuperLitium/master/assets/SuperLitiumBanner.png)

# SuperLitium
Improved version from the original [Litium](https://github.com/Litium-org/Litium).
A cool imaginary and retro styled game console and game framework

## Features
- [ :fa-wifi: ] Version checking system
- [ :fa-laptop: ] Better OS with improved UI
- [ :fa-folder: ] Save system 
- [ :fa-paint-brush: ] Customizable OS with colors
- [ :fa-tint: ] - Support to 25 colors (+1 as transparent)
- and much more

### STATBILITY WARNING:
> This project is constantly development, so scripts and functions can be added, removed, renamed  or moved to other parts.
> please check for the most recently version of source to not have compatibility issues.

#### Supported plataforms
- :fa-windows: : :tw-2705: (Supported)
- :fa-android: : :tw-274c: (Not supported)
- :fa-linux: : :tw-26a0: (Unstable)
- :fa-apple: : :tw-274c: (Not supported)

# Building Windows
- [ :tw-31-20e3: ] - Make sure you have Love2D 11.4 Mysterious Mysteries installed and setup with %path%, to see if you have set up correclty open your terminal and type "love" if it open a screen with no game means it all working correctly.

- [ :tw-32-20e3: ] - on your terminal run boot.cmd or click 2 times on .cmd file to run the current version of the project.
---


## Building Linux
### you can just download a pre-builded version on "realeases"
<p> Install <strong>love ^11.4 </strong>
and <Strong>SuperLitium</strong> dependencies </p>
<ul>
  <li>Love</li>
  <li>lua51</li>
  <li>lua</li>
  <li>luajit</li>
  <li>cmake</li>
</ul>

### Arch based
```
sudo pacman -S love lua51 lua cmake luajit
```
### Debian
```
sudo apt-get install love lua5.1 lua cmake luajit
```
<sub>* Not tested</sub>
### Fedora, CentOs, RPM package based
```
sudo dnf install love lua5.1 lua-devel lua5.1-devel libcurl-devel cmake luajit
```
<p> <h3> How to execute </h3> 
Change shell script file permission

```
sudo chmod u+x build.sh setup.sh 
```
<sub>* u+x args make the file executable only for the user</sub>
<br>
<br>
Then run setup.sh
```
./setup.sh
```
</p>
---

# Contributions
You can contribute with the development of engine by clonning this repository with the most recent version of code and make your changes.

---
Everyone who helps will be credited here (social media or Github page)

[Here the list of eveyone who contribute with engine development](./CONTRIBUTORS.MD)
---
# Used Libraries
- ### [Lualzw - Rochet2](https://github.com/Rochet2/lualzw)
- ### [Json - actboy168](https://github.com/actboy168/json.lua)
- ### [Basexx - aiq](https://github.com/aiq/basexx)
- ### [lua-https - Love2D](https://github.com/love2d/lua-https)

---
## External links
### [Discord server](https://discord.gg/gcscYemUeY)
### [Install VSCode Extention](https://marketplace.visualstudio.com/items?itemName=Sloow001.superlitium-snippets&ssr=false#review-details)
