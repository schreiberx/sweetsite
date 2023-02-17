---
layout: page
title: Basic SWEET utilization from command line
---

## From the SWEET's root directory, call
```bash
$ . ./activate.sh
```

## Cleanup
```bash
$ make clean
```

## Compile

Compile ```swe_sphere``` program
```bash
$ scons --program=swe_sphere
```


## Run

Run the program using
```bash
$ ./build/swe_sphere_COMP_plspec_pldeal_spspec_spdeal_fft_thomp_release  -M 128 --timestepping-method=ln_erk --timestepping-order=4 --dt=300 --benchmark-name=three_gaussian_bumps -t 129600 -o 129600 -v 2
```
Here, the meaning of the parameters is as follows:

* ```--timestepping-method=ln_erk --timestepping-order=4 --dt=300```

	4th order (classical) Runge-Kutta explicit time integrator

* ```-M 128```

	Spectral resolution of 128

* ```--benchmark-name=three_gaussian_bumps```

	Choose benchmark with three gaussian bumps


* ```-t 129600```

	Simulation time in seconds. Run for 1.5 days.


* ```-o 129600```

	Output simulation data each 1.5 days (Here, at end of time step).


* ```-v 2```

	Be a little bit more verbose


## Plotting

You can plot the results by using, e.g.,
```bash
$ mule.postprocessing.plot.sphere.physical output_prog_phi_pert_t00000000036.00000000.sweet
```

This will render the results using matplotlib.

All ```mule.*``` commands are part of the MULE feature within SWEET. There's a separate tutorial about this.
