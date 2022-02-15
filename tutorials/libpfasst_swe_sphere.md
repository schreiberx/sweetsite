---
layout: page
title: LibPFASST x SWEET Programs
permalink: tutorials/libpfasst_swe_sphere.html
---


This tutorial describes how to run the SWEET programs making use of [LibPFASST](https://github.com/libpfasst/LibPFASST).
The example uses `libpfasst_swe_sphere_imex_sdc` but is equivalent to using `libpfasst_swe_sphere_expl_sdc`.

For the MLSDC program `libpfasst_swe_sphere_mlsdc`, additional flags are available. Those are explained in section 2.

## 1. Compilation

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
For the MLSDC program, use `libpfasst_swe_sphere_mlsdc` instead.

## 2. Running the program

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

### Additional flags for MLSDC

* Meaning of the parameters:

    * ```--libpfasst-nlevels```

		The number of levels. Currently, 1 or 2 levels are supported. If you plan to use one level, consider using the SDC programs.

    * ```--libpfasst-nsweeps-coarse```

		Number of sweeps on the coarsest level.

    * ```--libpfasst-coarsening-multiplier```

		This is used to compute the amount of modes on the coarser level(s), by repeatedly applying the factor to `-M`

    * ```--libpfasst-u2```, ```--libpfasst-u4```, ```--libpfasst-u6```, ```--libpfasst-u8```

		Set artificial viscosity (hyperviscosity) of order 2, 4, 6, 8. When supplying one value, it is used for all levels. Otherwise, supply as many values
        as there are levels, separated by a comma. E.g., `--libpfasst-u2 0.3 --libpfasst-u4 0.1,0.05` on two levels.

    * ```--libpfasst-u-fields```

		Which fields to apply artificial viscosity on: can be `all`, `none`, or a (comma-separated) combination of `phi_pert`, `div`, `vrt`.

**Note:** The flags `-u` and `-U` must not be used for setting viscosity of the MLSDC program! 

## 3. Using the output

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