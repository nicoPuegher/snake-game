# Snake Game

### Recreation of the classic snake game in LÖVE with Lua.

This is my recreation of one the old classics, the snake game. The game can easily be edited to make the map bigger or increase the speed of the snake by changing the corresponding constant variables inside `main.lua`.

For those who do not know how to play this game, the objective is pretty simple, eat the apples to make the snake grow in size and you lose if you collide with your own body. You can teleport to the opposite side of the screen to get out of difficult situations.

[CS50](https://pll.harvard.edu/course/cs50-introduction-computer-science) is an on-campus and online introductory course on computer science taught at Harvard University and all students are given a couple of options to choose for their final project.

I chose to build my own game with the technologies they suggested because I wanted to learn something new and have some fun with the final project.

## Table of contents

- [Overview](#overview)
  - [The features](#the-features)
  - [How to play](#how-to-play)
- [My process](#my-process)
  - [The stack](#the-stack)
  - [What I learned](#what-i-learned)

## Overview

### The features

- [x] Dynamic map size
- [x] Dynamic speed
- [x] The snake can teleport to the opposite side
- [x] The game uses an queue to avoid input drops

### How to play

There are two options, one is to run the `Snake.love` file but LÖVE has to ve installed in your system, this option is the most suitable if you are interested in editing and test the game files. Download the version for your operating system at [LÖVE](https://love2d.org/), extract it  and just drag and drop the `Snake.love` file onto it.

If you only want to play the game, I provided an executable inside `Snake.zip` but it only works in macOS, I do not have a Windows machine at the moment so I cannot provide one for it.

## My process

### The stack

![Lua](https://img.shields.io/badge/Lua-2C2D72?style=for-the-badge&logo=lua&logoColor=white)
![LÖVE](http://ForTheBadge.com/images/badges/built-with-love.svg)

### What I learned

- Setup and deploy a **_LÖVE_** game.
- The programming language **_Lua_**.
- How to setup **_Stylua_** for formatting.
- How to setup **_Selene_** for linting.
- Create a **_macOS_** executable.
- Use a queue to avoid input drops.
- Run the game at the same frame rate on all computers using delta time.
