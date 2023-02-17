---
layout: page
title: Running SWE sphere convergence studies with reference jobs
---

Brief description:
 * Generation of reference data (with reference job)
 * Generation of other data by other time stepping methods / time step sizes
 * Computing the difference
 * Plotting the results

Supplementary material: [corresponding tutorial folder](https://github.com/schreiberx/sweet/tree/master/tutorials/swe_sphere_benchmark_with_reference_job)


## Benchmark job generation script

We skip some boilerplate code symbolized by this code (see tutorial folder for full code)

```python
jg = JobGeneration()

[...]
```

To generate the reference data, we

 * tag this job as a reference job
 * create the job directory for it
 * untag this job as a reference job (to reuse the 'jg' also for other jobs)

```python
# Set this to true to say that this is one of the reference jobs
jg.reference_job = True

# Create job with reference data
jg.gen_jobscript_directory('job_benchref_'+jg.getUniqueID())

# Deactivate tagging this to be a reference job
jg.reference_job = False

[...]
```

To let the other jobs know to which data to compare to, we can set the referene job id in the other jobs:
```python
# We now reuse the unique job ID of the reference solution to tell the other jobs about their reference solution!
jg.reference_job_unique_id = jg.job_unique_id
```

Then, we can create all jobs

```python
for tsm in ts_methods:
[...]	# all benchamrks created here

```

## Run jobs

We can run all benchmarks by just calling

```bash
$ mule.benchmark.jobs_run_directly_nonstop
```

## Postprocessing

To compute the error norms we can simply call

```bash
$ mule.postprocessing.pickle.alljobs.sphere_data_norms_physical_space
```


## Plotting

To plot the results, we can call 
```bash
$ ./postprocessing_plot.py
```

The plots are generated as .pdf files in the current folder.


## WARNING

The generated plots are only useful if they show time step size vs. error.

The wallcock time results shouldn't be used for performance discussions since many things could have gone wrong.

This is discussed in the following HPC benchmark tutorial.

