---
layout: page
title: Program arguments
---

# Summary #

Depending on the particular program, different configuration data needs to be accessed and we like to avoid any kind of duplication.

Such data can originate from, e.g.,

 * the program arguments (e.g., activating verbosity ```-v 1```)
 * some online computed values (e.g., diagnostics)
 * some debugging data (e.g., list of errors over time).
 
We assume that this configuration data is structured in different classes which we will call **configuration classes** in the remainder of this text.

The obvious solutions would be:
 * Use one **main class** and inherit other **configuration classes**
 * Use one **main class** and use member variables for other **configuration classes**
 
However, this would lead to the severe disadvantage that the **main class** would need to know everything about **configuration classes**.

To overcome this, we use some alternative: A class dictionary can store all kinds of information.
It allows to register other **configuration classes** during runtime and later on get access to them again.
From the users perspective, this is made by a special dictionary which uses **classes as keys** and a particular way to keep things efficient.


Remark: A commonly used solution is to use Singletons, but this is now option for us since we want to have multiple instances of same classes, but with different configurations. A singleton would not allow this, therefore we **do not allow singleton classes** of any kind in SWEET!


Supplementary material:
 * [tutorial folder (TODO)](https://github.com/schreiberx/sweet/tree/master/tutorials/classDict/classDict)
 * [tutorial main source file (TODO)](https://github.com/schreiberx/sweet/tree/master/tutorials/classDict/classDict)




# Start a new dictionary

Allocate a new empty dictionary:

```c++
ClassInstanceDictionary varClassDict;
```


# Prepare classes to add to the dictionary

We require each class to implement some functions in order to support at least the program argument parsing.

```c++

class PDESWEParametersSphere	:
	public PDESWEParametersCommon,
	public ClassDictionaryInterface
{
	[...]

	void outputVariables(std::string i_prefix = "")
	{
		[...]
	}
	
	bool processProgramArguments(sweet::ProgramArguments &i_pa)
	{
		[...]
	}
};
```

A full description of the required interfaces are given in the class ```ClassDictionaryInterface```.



# Registering classes

Once supporting the required interfaces we can simply register a new class to this dictionary by calling ```registerClassInstance```:


```c++
varClassDict.registerClassInstance<PDESWEParametersSphere>();
```

This will create an instance of ```PDESWEParametersSphere``` and store it in the dictionary.

Similarly, we can also add other classes:
```c++
varClassDict.registerClassInstance<PDESWEParametersSphere>();
```

# Finishing registration

After all kinds of classes are registered, we want to make sure that no further entries can be added by calling:
```c++
varClassDict.registrationOfClassInstancesFinished();
```
This looks like some overheads to do, but it makes sure that this class is used in the proper way!


# Getting class instance from dictionary

We can now simply access the instance of this class by using
```c++
PDESWEParametersSphere *sweParametersSphere = varClassDict.getClassInstance<PDESWEParametersSphere>();
if (sweParametersSphere == nullptr)
{
	std::cerr << "Not a SWEET error: " << varClassDict.error.errorGet() << std::endl;
	return EXIT_FAILURE;
}
```


# Finishing getter phase


This before mentioned getter method can turn out to be quite expensive with respect to the computation time.
Hence, once the entire simulation is ready to run, we might like to ensure that the getter feature is really not used anymore.
We can do this by calling

```c++
varClassDict.getClassInstancesFinished();
```
