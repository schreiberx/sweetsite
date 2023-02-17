---
layout: page
title: Postprocessing
---

There are three different sources of data for postprocessing:

 1. Based on the console output

 2. Based on the job generation information

 3. Based on file output


There's one **very important rule**: Whatever you do,

 * Never try to process any data output file on your own.
 * Never try to process the job directories and extract names from them.
 * Never try to parse any text output files from std::cout on your own.

To summarize:  **Never write your own output format and parse it on your own**.

Whenever you do this, this will brake with things very likely later on. Please always use the MULE tools for caring about data processing.

If you ever think that there's something which can't be coped with in SWEET, please talk to the developers.


## 1. Console output

SWEET uses MULE to postprocess also the program output.

As part of this, you can write to the console in a particular format:

```
[MULE] some_variable_name.and.some_dot: value 1234
```

This requires a prefix ```[MULE]``` followed by a space ``` ```, then a string which represents a key, followed by ```: ``` (including space!) and then the value of this key.

For benchmarks, you'll using MULE to generate job directories and each of these directories stores the output of the program.

MULE is then able to automatically parse this output and extract the key and value into a dictionary.



### Example (don't try to use this for long-term solutions)

* Compile SWEET program 
```
$ make clean
$ scons --program=swe_sphere
```

* Run program and redirect output
```bash
./build/swe_sphere_COMP_plspec_pldeal_spspec_spdeal_fft_thomp_release --timestepping-method=ln_erk --timestepping-order=4 --dt=300 --benchmark-name=galewsky -M 128 -t 43200 > output.out
```
* After running this program, have a look to the file ```./output.out``` and note all lines prefixed with ```[MULE]```.

* Get job data by executing a mule script which gathers data from various sources (explained in the MULE tutorial)
```bash
$ mule.jobdata ./
```
This will search the current folder for the file ```output.out```, generate a dictionary out of all information prefixed with ```[MULE]``` and prints this information



### How about lists?

One can also output lists by enumerating the output, e.g.

```bash
[MULE] cool_info.timestep.0: a
[MULE] cool_info.timestep.1: b
[MULE] cool_info.timestep.2: c
...
```

## 2. Accessing compile, runtime and parallelization parameters

Whenever you run benchmarks or other studies which require executing multiple times a program, you should do this with MULE's job features.


Copy this into content into a file ```test_create_jobs.py```:

```
#! /usr/bin/env python3

from mule.JobGeneration import *

jg = JobGeneration()

# Compile parameters
jg.compile.mode = 'release'
jg.compile.threading = 'omp'
jg.compile.program = 'swe_sphere'
jg.compile.sphere_spectral_space = 'enable'

# Runtime parameters
jg.runtime.space_res_spectral = 128                  # 128 modes
jg.runtime.benchmark_name = "three_gaussian_bumps"   # Galewsky benchmark
jg.runtime.max_simulation_time = 60*60*24            # 1 days

jg.runtime.output_timestep_size = 60*60  # Generate output every 1 hour
jg.runtime.output_file_mode = 'bin'      # Use binary file format as output

jg.runtime.timestepping_method = "ln_erk"    # Use expolicit Euler for linear and nonlinear terms
jg.runtime.timestepping_order = 4            # Use 4-th order RK

jg.runtime.timestep_size  = 300              # Use timestep size of 300

# Create job directories
jg.gen_jobscript_directory()

```

After you execute it with ```./test_create_jobs.py``` (before that, make it executable!), you will have a folder starting with ```job_bench_*''' in your current directory.

The job generation creates a unique folder for each test case you write and will also store all information about compilation, runtime and also parallelization in a separate ```jobgeneration.pickle``` file in this directory.

We can already have a look at this information by calling
```bash
$ mule.jobdata job_bench_*
```
which will print out plenty of information.

* ```compile.*```: Compile parameters

* ```runtime.*```: Runtime parameters of the program

* ```parallelization.*```: Configuration how the program should be parallelized


We can now execute the program itself by running
```bash
mule.benchmark.jobs_run_directly
```
which will search for folders starting with ```./job_*``` and run all run.sh scripts in them.

It will also redirect the output to ```output.out```.

Besides the regular output files which we can visualize with ```mule.postprocessing.plot.sphere.physical```, there are now also further entires in the job data. We can have a look at it by running

```bash
$ mule.jobdata ./job_*
```

Now, we find some additional entries with the prefix ```output.*``` created for the ```[MULE]``` information in ```output.out```.



## 3. File output

There are standardized SWEET output files which should be used for larger outputs.

We can visualize the standard SWEET output files by calling, e.g., ```mule.postprocessing.plot.sphere.physical [filename.sweet/.csv]```.


