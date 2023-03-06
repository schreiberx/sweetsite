---
layout: page
title: IMEX SDC for SWE on the sphere
usemathjax: true
---

This tutorial describes how to run the the IMEX Spectral Deferred Correction (SDC) time-stepping method implemented in SWEET.
For theoretical content on SDC, you can check [this project](https://github.com/Parallel-in-Time/sdc-wiki) (in construction) or any literature on the subject.
This tutorial suppose that the reader is aware of the algebraic formulation of SDC using $Q$ and $Q_\Delta$ matrices, and just present how to set those coefficients for the IMEX SDC solver in SWEET.

## 1. Compilation and basic run

The up-to-date IMEX-SDC implementation is currently only implemented in the [`parallel_sdc`](https://github.com/schreiberx/sweet/tree/parallel_sdc) branch, that you can obtain like this :

```bash
$ git checkout parallel_sdc
```

Then before compiling with `scons`, here is the list of libraries that should be installed locally from the `local_software` folder :

```bash
$ cd local_software
$ ./install_miniconda.sh
$ ./install_scons.sh
$ ./install_numactl.sh
$ ./install_fftw3.sh
$ ./install_shtns.sh
$ ./install_shtns_python.sh
$ ./install_lapack.sh
```

To run the SWEET program with GUI (recommended for first tests), those installations are required :

```bash
$ cd local_software
$ ./install_sdl2.sh
$ ./install_libfreetype.sh
$ # For Ubuntu systems :
$ sudo apt install pkg-config libgl-dev libxext-dev
```

Then you can compile the SWE Sphere program with

```bash
$ make clean
$ scons --program=swe_sphere --gui=enable
```

Finally, you can run the simulation with default settings for IMEX SDC using the following command : 

```bash
$ ./build/swe_sphere* --benchmark-name=galewsky -M 128 --dt=1200 --timestepping-method=ln_imex_sdc
```

This runs default IMEX-SDC, with Backward Euler (BE) for the linear terms and Forward Euler (FE) for the non-linear terms. In particular, it is stable with a time step $\Delta t=1200s$, which is four times larger that the maximum stable time step for ERK(4,4) with the same space discretization.

## 2. Changing SDC parameters

The simulation command shown in the previous section use IMEX SDC with the default settings implemented in SWEET, that is :

Current default settings for IMEX SDC are :

- 3 RADAU-RIGHT nodes
- 3 iterations (sweeps)
- initial sweep using COPY (of the initial time-step solution)
- no end update with the quadrature formula
- BE for implicit sweep
- FE for explicit sweep

You can change those parameters by providing a parameter file (SWEETFileDict format) with
the `--sdc-file=[...]` program argument.

Parameter files can be generated using the `mule.sdc.generateSetup` utility script.
For instance,

```bash
$ mule.sdc.generateSetup
```

generates a `params_SDC.sweet` file containing all the defaults parameters of IMEX SDC described above.

> :bell: Don't hesitate to use the `mule.displaySWEETFileDict` script to display all parameters contained in the SDC parameters file, _e.g_ :
> ```bash
> $ mule.displaySWEETFileDict params_SDC.sweet
> ```

You can change the SDC parameter to be used by providing arguments to `mule.sdc.generateSetup`, for instance

```bash
$ mule.sdc.generateSetup --nIter=4 --nNodes=4 --nodeType=LOBATTO --qDeltaExplicit=PIC --useEndUpdate=ouiiii
```

change the default configuration to 4 sweeps, 4 LOBATTO nodes and a Picard iteration for the explicit sweep, adding after all sweep the end update with collocation.

:warning: For boolean type arguments (like `--useEndUpdate`), you have to put an empty argument to set it to false, for instance

```bash
$ mule.sdc.generateSetup --useEndUpdate= --nIter=4  # ...
```

Don't hesitate to use the `-h` or `--help` option of the `mule.sdc.generateSetup` script.
In particular, you can find there some preset configuration for sdc, that you can use like this 

```bash
$ mule.sdc.generateSetup --preset=P1
```

Here the `P1` preset configuration use the following parameters :
```
P1 :
--nNodes 4
--nodeType RADAU-RIGHT
--nIter 3
--qDeltaImplicit BEPAR
--qDeltaExplicit PIC
--initSweepType QDELTA
--useEndUpdate False
--diagQDeltaInit BEPAR
--diagonal True
``` 

You can see all the registered preset configurations using

```bash
$ mule.sdc.generateSetup --showPreset
```

## 3. Parallel SDC

### Preliminary notes

> :scroll: This describe how to run diagonal SDC in parallel using OpenMP, combining eventually with space parallelization (also OpenMP).

:warning: Nested parallelization is not possible with `gcc`, you must use a compiler allowing nested openMP parallelism. For instance, if `llvm` compiler are installed, you can use a dedicated SWEET environment with :

```bash
$ source ./activate.sh default_llvm
```

### Installation and parallel run

First, compile the `swe_sphere` program using

```bash
$ scons --program=swe_sphere --parallel-sdc-par-model=omp
```

Then, generate the parameter file for diagonal SDC on 4 nodes :

```
$ mule.sdc.generateSetup --preset P1
```

And finally, program can be run on 100 time steps of size $\Delta{t}=300$ using :

```bash
OMP_NUM_THREADS=8 ./build/swe_sphere* --benchmark-name=galewsky -M 128 --dt=300 --timestepping-method=ln_imex_sdc --sdc-file=params_SDC.sweet -t $((300*100)) --num-threads-space=2
```

$\Rightarrow$ uses 8 processes in total, with 2 in space, and hopefully 4 in time :sweat_smile:

