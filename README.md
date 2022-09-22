# LitiumVM
> Codename : lunaris, mini os and game engine made with love2D.

[![Lua language](./images/lua-badge.png)](https://www.lua.org)

# About Project
LitiumVM (codename lunaris) is a fantasy console and game framework inspired by Atari 2600.
Is 100% written in lua and has his own API to make your own games.
Has a graphic handler, sound writter, and json reader.

This engine is in development, started at 13/04/2022.

You can download this source code and build it on your machine.

### STATBILITY WARNING:
> This project is constantly development, so scripts and functions can be added, removed, renamed or moved to other parts, please check for the most recently version of source to not have compatibility issues.
	
## Building Windows
- [ 1 ] - Make sure you have Love2D 11.4 Mysterious Mysteries installed and setup with %path%, to see if you have set up correclty open your terminal and type "love" if it open a screen with no game means it all working correctly.

- [ 2 ] - on your terminal run boot.cmd or click 2 times on .cmd file to run the current version of the project.

## Building Linux
<p> Install <strong>love ^11.4 </strong>  
dependency </p>

### Arch based
```
sudo pacman -S love lua5.1
```
### Debian
```
sudo apt-get install love lua5.1
```
<sub>* Not tested</sub>
### Fedora, CentOs, RPM package based
```
sudo dnf install love lua5.1 lua-devel lua5.1-devel libcurl-devel
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

# Contributions
You can contribute with the development of engine by clonning this repository with the most recent version of code and make your changes.

Everyone who helps will be credited here (social media or Github page)

[Here the list of eveyone who contribute with engine development](./CONTRIBUTORS.MD)

# Library credits
This engine use some third party libraries, here the credits for they amazing work :D
> ### [HUMP - vrld](https://github.com/vrld/hump)
> ### [Json.lua - rxi](https://github.com/rxi/json.lua)
> ### [Penlight lib - lunarmodules](https://github.com/lunarmodules/Penlight)
> ### [Json.lua (New Implementation) - Actboy168](https://github.com/actboy168/json.lua)
> ### [Chrono - a327ex](https://github.com/a327ex/chrono/blob/master/Timer.lua)
> ### [lBase64 - iskolbin](https://github.com/iskolbin/lbase64)
