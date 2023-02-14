---
layout: page
title: Bugs reporting
permalink: /bugs/index.html
---

If you encounter any bugs, we appreciate feedback about this.

## For runtime bugs

It's important to get a reproducer of this bug.

To do so, please provide:

 * The scons command line options, e.g.,
```bash
$ scons --program=swe_sphere
```

 * The runtime options, e.g., 
```bash
$ ./build/swe_sphere_COMP_plspec_pldeal_spspec_spdeal_fft_thomp_release  -M 128 --timestepping-method=ln_erk --timestepping-order=4 --dt=300 --benchmark-name=three_gaussian_bumps -t 691200
```
 * Information about the expected and unexpected behavior.


You can post this information either in the [Discord channel](../community/) or by getting in touch with one of the developers.

