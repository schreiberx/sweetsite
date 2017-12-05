---
layout: page
title: REXI
permalink: tutorials/rexi.html
---

This will be a short tutorial for using SWEET with REXI methods

Focus: Analyse errors of REXI methods with SWEET using the linearized SWE on the plane


We start by compiling SWEET:
scons --program=swe_plane --gui=enable<br />
<br />
The default options are to compile with spectral methods on the plane which is also what we want to have<br />
<br />
We also activate the GUI since I'd like to see the waves wobbling around<br />
<br />
If there's any software missing, this can be installed via the scripts in 'local_software'<br />
<br />
We can then run simulations by using<br />
./build/swe_plane_plspec_pldeal_gui_omp_fft_gnu_release  -M 128 -s 1  --timestepping-method=l_rexi --timestepping-order=1 --rexi-method=ci  -X 1 -f 1 -H 1 -g 1 --rexi-ci-sx=20 --rexi-ci-sy=20 --dt=0.01 --compute-errors=1 -o 0.1 -v 2<br />
<br />
Param -M: how many modes do we want to use? 128!<br />
<br />
-s chooses the simulation scenario<br />
<br />
--timestepping-method=l_rexi chooses the time stepper. Plenty of alternative methods are available. l_ means that we use the linear parts which include the gravity and Coriolis effect related modes<br />
<br />
--timestepping-order=1 is obsolete here<br />
<br />
--rexi-method=ci    This chooses the Cauchy Contour Integral method which is awesome!<br />
<br />
-X sets the scaling of the plane to a 1x1 square<br />
<br />
-f sets the Coriolis effect to 1<br />
<br />
-H 1 sets the average height to 1<br />
<br />
-g 1 sets the gravitational constant to 1<br />
<br />
--rexi-ci-sx and --rexi-ci-sy sets the radius of the cauchy contour integral to be 20<br />
<br />
--dt=0.01 sets the time step size<br />
<br />
--compute-errors=1 requests the errors to be computed (that's possible for the linear SWE on the plane)<br />
<br />
-o 0.1 requests an output every 0.1 simulation seconts<br />
<br />
-v 2 make the output a little bit more verbose<br />
<br />
We can now play around with it<br />
<br />
e.g. choosing a time step size which is larger with --dt=0.1<br />
<br />
We see that in the output, the errors are getting much larger<br />
<br />
That's because some EValues are not approximated correctly anymore<br />
<br />
The question is why<br />
<br />
Increasing the contour integral via "--rexi-ci-sx=40 --rexi-ci-sy=40" results in a reduction to the errors<br />
<br />
Here, we only use --rexi-ci-n=64 terms<br />
<br />
We can now switch to the "Terry" REXI method by adding "--rexi-method=terry --rexi-h=0.2 --rexi-m=64"<br />
<br />
The parameters which were specified later are overwriting the others<br />
<br />
We can see that the errors with Terry's REXI method are larger with the same number of terms. Increasing --rexi-h=0.6 improves it a little bit.<br />
<br />
However, Cauchy is still better
