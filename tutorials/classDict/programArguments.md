---
layout: page
title: Program arguments
---

# Summary #

This tutorial explains how the program arguments are processed.

Supplementary material:
 * [tutorial folder (TODO)](https://github.com/schreiberx/sweet/tree/master/tutorials/classDict/programArguments)
 * [tutorial main source file (TODO)](https://github.com/schreiberx/sweet/tree/master/tutorials/classDict/programArguments)


# Examples

Let our program be ```./build/some_program```.
The implemented program argument parser allows the following kinds of arguments:

```
./build/some_program -a 123
./build/some_program --build=123
./build/some_program --foo "hello world"
```


# Starting Program Argument parsing

Program arguments in SWEET are processed in a centralized manner with the class ```ProgramArguments```.
We can set it up by using, e.g.,
```c++
sweet::ProgramArguments pa;
if (!pa.setup(i_argc, i_argv))
{
	std::cout << "Error: " << pa.error.errorGet() << std::endl;
	return 1;
}
```


# Processing Program Arguments

Arguments can then be parsed by calling the ```getArgumentValueByKey``` (or ```getArgumentValueBy2Keys``` and similar functions).

```c++
if (!pa.getArgumentValueByKey("--pde-sphere-f0", sphere_fsphere_f0))
{
	if (error.errorForward(i_pa.error))
		return false;
}

if (!pa.getArgumentValueBy2Keys("--pde-sphere-radius", "-a", sphere_radius))
{
	if (error.errorForward(i_pa.error))
		return false;
}

if (!pa.getArgumentValueBy2Keys("--pde-use-fsphere", "-F", sphere_use_fsphere))
{
	if (error.errorForward(i_pa.error))
		return false;
}
```


# Debugging features

## Single key

It might happen that the same argument key is processed by different ```getArgumentValueByKey``` calls.

This class has a feature included which ensures that an error is triggered if a key was processed twice.

## All arguments processed?

We like to avoid any bugs in our program and in particular want to make sure that all arguments have been also processed.

The following example shows this.


```c++
if (!pa.checkAllArgumentsProcessed())
{
	std::cerr << pa.error.errorGet() << std::endl;
	return EXIT_FAILURE;
}
```