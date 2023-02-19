---
layout: page
title: Error handling
---


We disencourage using C++ exceptions for various reasons (in particular performance!).

The alternative is to check for errors in a standardized way and SWEET offers a special class for this.

We show this by different examples:

# Instantiate error class

We recommend to always use a **public** member variable ```error```:

```c++
#include <sweet/ErrorBase.hpp>

class ProgramArguments
{
public:
	sweet::ErrorBase error;
```


# Triggering an error

An error can be simply set by using

```c++
error.errorSet("Some error occured for '"+i_key+"'");
```


# Testing for an error

Testing for an error is made by calling

```c++
if (someClass.error.errorExists())
{
	[...]
}
```



# Processing an error

There's no other way than processing the error (see below).
The error is assumed to be processed if it's retreived by

```c++
std::cerr <<  someClass.error.errorGet() << std::endl;
```


# Forwarding error

Rather than processing the error by the current class, we might like to forward the error just to our class and leave it up to some other class to process it.
This can be done by forwarding the error:

```c++
error.errorForward(someClass.error)
```


# More features

There are more features included and we like to refer to the respective class.



# Debugging

We try to enforce the development of bug-free code.
Therefore, each error has to be taken care of (even if just calling ```.errorReset()``` which will wipe this error).

If an error has not been processed by retreiving it with ```.errorGet()```, the deconstructor will detect this and abort the program with a respective error message.

