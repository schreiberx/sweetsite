---
layout: page
title: LibPFASST x SWEET Programs
permalink: tutorials/libpfasst_swe_sphere.html
---


This tutorial describes how to run the SWEET programs making use of [LibPFASST](https://github.com/libpfasst/LibPFASST).
The example uses `libpfasst_swe_sphere_imex_sdc` but is equivalent to using `libpfasst_swe_sphere_expl_sdc`.


**Note**: The program `libpfasst_swe_sphere_mlsdc_sdc` is available as well but **not** ready for use!

## Compilation

We start by loading the SWEET environment:

```bash
$ source ./activate.sh
```

Remove existing binaries

```bash
$ make clean
```

Compile `libpfasst_swe_sphere_imex_sdc` program for the shallow-water equations on the sphere using the PFASST algorithm and an IMEX sweeper.

```bash
$ scons --program=libpfasst_swe_sphere_imex_sdc --quadmath=disable --libpfasst=enable --sweet-mpi=enable --libsph=enable --plane-spectral-space=disable --sphere-spectral-space=enable --threading=off --libfft=enable --sphere-spectral-dealiasing=enable
```

To compile in debug mode, add the flag `--mode=debug`.
For the pure explicit SDC program, replace `libpfasst_swe_sphere_imex_sdc` with `libpfasst_swe_sphere_expl_sdc`.

## Running the program

Execute the program with the following parameters:

```
$ ./build/libpfasst_*_release --dt=180 -t 1800 -M 128 --benchmark-name=galewsky --libpfasst-nodes-type=SDC_GAUSS_LOBATTO --libpfasst-nnodes 3 --libpfasst-niters 5 --output-file-mode=bin -o 1800 -v 2
```

These are all the parameters you usually have to touch when running one of these programs.

Note: `timestepping-method` and `timestepping-order` do not affect the LibPFASST program! 
Use the `libpfasst-*` parameters to adjust the convergence order as needed. (see below)

* Meaning of the parameters:

    * ```dt=100 -t 1800```

		time step size of 100 seconds, run for 1800 simulation seconds

    * ```-M 128```

		Spectral resolution of 128

    * ```--benchmark-name=galewsky```

		Choose Galewsky benchmark

    * ```--libpfasst-nodes-type=SDC_GAUSS_LOBATTO --libpfasst-nnodes 3 --libpfasst-niters 5```

		Use three Gauss-Lobatto nodes per time step and do five iterations per time step.
        This yields a fourth order method (min(2·3 - 2, 5) = 4).
        Alternatively, using SDC_GAUSS_LEGENDRE: min(2·(3 - 2), 5) = 2.
        See [the documentation](https://github.com/schreiberx/sweet/tree/master/doc/libpfasst) for an explanation.

    * ```--output-file-mode=bin -o 1800```

		Use binary files for the output - **CSV output is not supported!**
        Do output every 1800 simulation seconds, i.e., only at the end.

    * ```-v 2```

		Be a little bit more verbose


## Using the output

* The programs generate a bunch of .sweet binary output files:

    * ```output_prog_vrt_*.sweet```

        Prognostic vorticity field

    * ```output_prog_div_*.sweet```

        Prognostic divergence field
        
    * ```output_prog_phi_pert_*.sweet```

        Prognostic phi perturbation field

You can work with the files using the existing Python scripts for spectral sphere data, e.g.:

```bash
$ ./mule_local/python/mule_local/postprocessing/SphereDataSpectralDiff.py file1.sweet file2.sweet
```

or, for plotting

```bash
$ ./mule_local/python/mule_local/postprocessing/plot_SphereDataSpectral.py file1.sweet output.png
```


For more information about all of this, see the [documentation](https://github.com/schreiberx/sweet/tree/master/doc/libpfasst)