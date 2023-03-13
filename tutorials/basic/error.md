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
if (someClass.error.exists())
{
	[...]
}
```

# Processing an error

There's no other way than processing the error (see below).
The error is assumed to be processed if it's retreived by

```c++
std::cerr <<  someClass.error.get() << std::endl;
```


# Forwarding error

Rather than processing the error by the current class, we might like to forward the error just to our class and leave it up to some other class to process it.
This can be done by forwarding the error:

```c++
error.forward(someClass.error)
```

There's also a convenience function ```forwardWithPositiveReturn``` which can be used for returning from functions:

```c++
return error.forwardWithPositiveReturn(someClass.error);
```
This function return ```true``` in case of **no error**.



# Convenience macros

There are also some convenience macros:

The following one shecks for an error in ```someClass``` and, if there is an error, the error will be forwarded and ```false``` is returned:

```c++
ERROR_CHECK_WITH_FORWARD_AND_COND_RETURN_BOOLEAN(someClass);
```

The next macro can be used in the ```main()``` function. It will check whether an error exists and, if there's an error, print it and return ```EXIT_FAILURE```:

```c++
ERROR_CHECK_WITH_PRINT_AND_COND_RETURN_EXIT(someClass);
```


# More features

There are more macros and features included and we like to refer to the respective class.



# Debugging

We try to enforce the development of bug-free code.
Therefore, each error has to be taken care of (even if just calling ```.reset()``` which will wipe out this error).

If an error has not been processed by retreiving it with ```.get()```, the deconstructor will detect this and abort the program with a respective error message.

There's an additional feature available:
If setting the environment variable ```SWEET_ERROR_WITH_STACKTRACE``` to an arbitrary value, SWEET appends a full stack trace to each error output.