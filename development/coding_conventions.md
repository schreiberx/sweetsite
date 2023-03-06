---
layout: page
title: Coding conventions
---



Different developers working together have usually different coding conventions.
There are different coding styles and a nice discussion and terminology can be found [on this webpage](https://web.archive.org/web/20230217100359/https://khalilstemmler.com/blogs/camel-case-snake-case-pascal-case/#Comparison-of-naming-conventions-in-other-programming-languages).

An agreement to coding conventions has to be achieved when working together on one project for several reasons.
One of the main reasons is to keep the code clean and thus to maintain a better code structure.

We give some hints about these coding guidelines in the SWEET development


## 1. For C++ programming

|-----------------------|-----------------------|
| Type			| Format		|
|-----------------------|-----------------------|
| Functions	| camelCase()	|	
| Classes	| PascalCase	|	
| Interfaces	| PascalCase	|	
| Namespaces	| pascalCase	|	
| Constants	| SCREAMING_SNAKE_CASE	|	
|-----------------------|-----------------------|


Example:
```c++
#define FOO_BAR_YEAH 456

class SomeClass {
	const int FOO_BAR = 123;
	void functionInClass() {}
};
```

### Functions

#### Function parameters

Parameters of methods are prefixed by `i_`, `o_` or `io_`.

 * `i_` means that this parameter is accessed read/only (const).
 * `o_` is used to declare this parameter as being an output reference to write some output values.
 * `io_` is used to declare an input/output pointer or reference which is read and written.

|-----------------------|-----------------------|
| Type			| Format		|
|-----------------------|-----------------------|
| Input		| i_variableName	|	
| Output	| o_variableName	|	
| Input/Output	| io_variableName	|	
|-----------------------|-----------------------|


Output parameters always have to be of type pointer.
No references should ever be used for output parameters!
Return values handed back to the calling method are still allowed and have so far no convention.

Example:

```c++
void funFunction(
	int i_inputValue,
	const int &i_inputValue2,
	int &o_output_Value
)
```

#### Functions themselves

Private functions should be prefixed with an `_`

Example:

```c++
class Foo {
private:
	void _funFunction() {};
}
```

### Class attributes

Attributes should be prefixed by `_` if they are private attributes.

 * `_` means that this attribute is private.
 * no `_` means that this attribute is public.

|-----------------------|-----------------------|
| Type			| Format		|
|-----------------------|-----------------------|
| Input		| i_variableName	|	
| Output	| o_variableName	|	
| Input/Output	| io_variableName	|	
|-----------------------|-----------------------|


Output parameters always have to be of type pointer.
No references should ever be used for output parameters!
Return values handed back to the calling method are still allowed and have so far no convention.

Example:

```c++
void funFunction(
	int i_inputValue,
	const int &i_inputValue2,
	int &o_output_Value
)
```

### Identation
Blocks and scopes have to be indented by using a single TAB for each identation.

### Eclipse configuration
Eclipse supports features for automatic formattation of code via `[Source] -> [Format]`.
The style which is used by SWEET is programmed is closely related to "GNU/Allman" and a profile file [`SWEET_eclipse_formattation.xml`](https://github.com/schreiberx/sweet/blob/parallel_sdc/doc/sweet/coding_conventions/SWEET_eclipse_formattation.xml) is available in the source repository.
This can be loaded via `[Project] -> [Properties] -> [C/C++ General] -> [Formatter]`.
Make sure to tick the box `Enable project specific settings` and `[Import]` the SWEET profile.


## 2. Coding conventions for Python

The entire workflow to compile and execute code written in SWEET as well as the postprocessing is mainly written in Python.
We use Python 3 without any exceptions!

### Overview

|-----------------------|-----------------------|
| Type			| Format		|
|-----------------------|-----------------------|
| Functions	| pascalCase()	|	
| classes	| PascalCase	|	
| interfaces	| -	|	
| namespaces	| -	|	
| constants	| SCREAMING_SNAKE_CASE	|	
|-----------------------|-----------------------|


Example:

```python
class SomeClass:
	SOME_CONSTANT = 123
	def thisIsAFunction(self):
		pass


someClass = SomeClass()
```


### PEP8 guidelines

Generally, please try to follow PEP8 guidelines which can be found at [https://www.python.org/dev/peps/pep-0008](https://www.python.org/dev/peps/pep-0008) 
with the following exceptions:

 * Use tab indentation with tabs configures to take 4 spaces
   In VIM, this can be configured with
   `autocmd Filetype python setlocal tabstop=4 shiftwidth=4`
 * Use Unix encoded python source code files



## 4. Commenting

```c++
/**
 * some comment
 *
 * \return description of return value 
 */
char fooBar(
    const int i_bar_var,     
                  ///< this is a totally useless variable
    const SomeClass &i_someClass,    
                  ///< input via referenced parameter
    SomeClass *o_someOutputClass
                  ///< output via pointer parameter
) {
    while (true) {
        ...
    }
    return 42;
}
```

Comments are one of the most important thing in writing code.
Therefore as much comments as are necessary or being requested by other developers have to be written.

Equations in comments can be e.g. written with `{\textbackslash}f\$ f(x):=1+2x {\textbackslash}f\$`.
See [this website](https://www.stack.nl/~dimitri/doxygen/manual/formulas.html) for examples.


```c++
/**
 * comments preceeding functions should
 * follow the doxygen (www.doxygen.org)
 * code-style
 *
 * \return description of return value 
 */
void foo(
    const int i_bar_var, ///< this is totally useless
    void *io_foo_var     ///< this variable is not
                         ///< able to drink beer
) {
    while (true) {
        ...
    }
}

constructor(
    int i_val,	///< index
) :
  some_variable(i_val)
{
	...
}
```

