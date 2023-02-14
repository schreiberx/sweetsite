---
layout: page
title: Installation basics
permalink: tutorials/installation_basics.html
---

Whatever we do with SWEET, we **always** first have to load the environment.

* From the SWEET's root directory, call
```
$ . ./activate.sh
```
This loads the environment variables for a particular platform.
Platforms describe, e.g., how SWEET can be compiled and executed on computers which have specific requirements (e.g., super computers).
If the platform is not detected, a default platform is activated (typically ```default_gcc``` for the default GNU compiler collection)

* Go to the software management folder.
```
$ cd local_software
```

* There's a default softare installer available which installs the most commonly used software packages
```
$ ./setup_local_software.sh
```
This might take a while to download all packages and compile them!


* If you like to use the GUI (Graphical User Interface) of SWEET, you also need to install libSDL.
```
$ ./install_sdl2.sh
```

* SWEET is now ready. You can test it by trying to compile the first program (see next tutorial)

