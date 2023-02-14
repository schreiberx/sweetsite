---
layout: page
title: Running SWE on the rotating sphere with a GUI
permalink: tutorials/basic_swe_sphere_with_gui.html
---

Run SWE on the sphere with Graphical User Interface (GUI).

## Activate environment

From the SWEET's root directory, call
```bash
$ . ./activate.sh
```


## Install libSDL

Install libSDL which is required for the GUI (if not yet done):

Go to the software management folder.
```bash
$ cd local_software
```

Install libSDL
```bash
$ ./install_sdl2.sh
```

## Cleanup
```bash
$ make clean
```

## Compile

Compile swe_sphere program for the shallow-water equations on the sphere including the visualization
```bash
$ scons --program=swe_sphere --gui=enable
```

## Run

Execute program with the following parameters:
```bash
$ ./build/swe_sphere_COMP_plspec_pldeal_spspec_spdeal_gui_fft_thomp_release  -M 128 --timestepping-method=ln_erk --timestepping-order=4 --dt=300 --benchmark-name=three_gaussian_bumps
```

The GUI is automatically enables if compiled with GUI enables.

The other program options are explained in a previous tutorial.

## How to use the GUI?

* ```[b]```/```[B]``` Cycle to next/previous visualization style (plane / sphere)

* ```[v]```/```[V]``` Cycle to next/previous field for visualization

* ```[1]```-```[9]``` Render only each ```[number]^2``` frame

* ```[space]``` Pause the simulation

* ```[j]``` Run single time step

* ```[q]``` Quit simulation

