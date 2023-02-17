---
layout: page
title: Plan generation example for SWE sphere wallclock time studies
---

This tutorial covers the reutilization of **plans* by providing an example for the SWE on the sphere.
**Plans** refer to the particular algorithm to compute the spherical harmonics (SH) transformations in the best performing way.
Each time the SH transformations are initialized, some performance studies are executed for different variants of SH transformations and the best one is chosen.
This means that running multiple performance studies could result in different plans being used, hence, the performance results would not be comparable due to a potentially low-performing plan being chosen.

This tutorial covers how to **precompute** these plans and how to reuse them for all performance studies.
Again, we will use MULE for that.


Supplementary material: [corresponding tutorial folder](https://github.com/schreiberx/sweet/tree/master/tutorials/basics/swe_sphere_benchmark_with_reference_job)


## Boilerplate code

We assume the following boilerplate code:

```python
jg = jobgeneration()

[...]
```


## Creating plans

First of all, we need to create plans which can be used later on. For this, we create a special job which is doing 

```python
jg.runtime.reuse_plans = "save"
    
for tsm in ts_methods[1]:

    # Set simtime to 0
    jg.runtime.max_simulation_time = 0

    # No output
    jg.runtime.output_timestep_size = -1
    jg.runtime.output_filename = "-"

    jobdir = 'job_plan'+jg.getUniqueID()
    jg.gen_jobscript_directory(jobdir)
```

Using this option also means that the files with the plans will be stored to the current job directory but will be copied to the ```../``` directory.
This is (as usual) all taken care of by MULE.


## Reusing plans

During the regular job generation, we specify that we require the plans to be loaded from their default location.
(The default location is ```shtns_cfg``` and ```shtns_cfg_fftw``` in the current execution folder)

```python
jg.runtime.reuse_plans = "require_load"
```

This means that in case that the plans are not available in the current folder, the program will stop.

Using this option also means that the files with the plans have to be copied into the job directory.
This is (as usual) all taken care of by MULE by copying the plans from the upper directory ```../``` into the current directory.


