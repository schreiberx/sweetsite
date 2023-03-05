---
layout: page
title: SWEET! Shallow Water Equation Environment for Tests, Awesome!
---

## What is SWEET?

This software allows a fast exploration / investigation / prototyping of time discretization methods for PDEs which can be solved with global spectral methods (Fourier & Spherical harmonics).

It's made to
 * accelerate research around the development of numerical time integration methods
 * investigate new ways to express parallelization
 * do some early investigations in scalability of novel time integration methods (e.g., parallel-in-time)

 > :scroll: Check-out the list [tutorials](./tutorials/index.md) for some usage examples ...


## What is SWEET NOT?

SWEET is not intended to be any production HPC code to replace any dynamical cores (yet :wink:).


# Example
{% include youtubePlayer.html id="bEJ8c26TFEk" %}

## Features

### Domains

SWEET supports periodic boundary conditions for
 * the bi-periodic plane (2D torus)
 * the sphere

### Space discretization

 * PLANE: Spectral methods based on Fourier space
 * PLANE: Finite differences (with convolution in spectral space)
 * SPHERE: Spherical Harmonics

### Time discretization

 * Explicit RK
 * Implicit RK
 * Leapfrog
 * Crank-Nicolson
 * Semi-Lagrangian
 * Parallel-in-time
   * Parareal
   * PFASST
   * Rational approximation of exponential integrators (REXI)
     * T-REXI (Terry's method)
     * CI-REXI (Cauchy Contour integral method)
     * B-REXI 
 * Spectral Deferred Corrections
 * ...and many more time steppers...


### Special features
 * Graphical user interface
 * Fast Helmholtz solver in spectral space
 * Easy-to-code in C++
 * ...

### Applications and benchmarks

There's support for various applications

 * Shallow-water equations on plane/sphere
 * Advection
 * Burgers'
 * ...

