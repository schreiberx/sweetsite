---
layout: page
title: Burgers
---


This tutorial describes how to run the Burgers program on the example of a Gaussian bump as seen in [the gallery](../gallery/burgers_gauss.html).

* We start by loading the SWEET environment:
```
$ . ./local/env_vars.sh
```

* Remove existing binaries
```
$ make clean
```

* Compile burgers program to be able to compute solutions to the Burgers equation. In addition, enable the fft library, which is needed for the spectral methods.
```
$ scons --program=burgers --libfft=enable
```

* Execute program with the following parameters:
```
$ ./build/burgers_*_release --timestepping-method=ln_erk --timestepping-order=4 -C -0.00001 -t 0.1 -N 256 -s 0 -u 0.1 -o 0.05 -v 2 -r 0.3
```
Here, the meaning of the parameters is as follows:
	* ```--timestepping-method=ln_erk --timestepping-order=4 -C -0.00001```

		Runge-Kutta order 4 time stepping method for the Burgers equation and a time step size of 0.00001

	* ```-t 0.1```

		Run for 0.1 simulation seconds

	* ```-N 256```

		Physical resolution of 256x256

	* ```-s 0 -r 0.3```

		Choose gaussian bump benchmark with a radius of 0.3 for the bump

	* ```-u 0.1```

		Set a viscosity of 0.1 for the simulation

	* ```-o 0.05```

		Do output every 0.05 simulation seconds

	* ```-v 2```

		Be a little bit more verbose


* Output files

	* This generates the ```output_prog_u_*.csv``` output file containing the prognostic velocity in x direction

	* We can render the field using plotting scripts:

		```
		./scripts/pp_plot_plane_csv.py output_prog_u_t*csv
		```

		This will generate *.png files

	* Finally, we can also generate a video:

		```
		./scripts/pp_create_mp4.sh output_prog_u output_prog_u.mp4
		```

		which generates a video file in ```output_prog_u.mp4```.
