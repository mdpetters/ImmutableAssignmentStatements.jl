# ImmutableAssignmentStatements.jl

*A simple Julia package to enforce pseudo-immutablity.*


# Installation

The package can be installed from the Julia package prompt with

```julia
julia> ]add  https://github.com/mdpetters/ImmutableAssignmentStatements.jl.git
```

The closing square bracket switches to the package manager interface and the ```add``` command installs the package and any missing dependencies. To return to the Julia REPL hit the ```delete``` key.

To load the package run

```julia
julia> using ImmutableAssignmentStatements
```

# Documentation

Immutable variables help with reasoning about the program. Variable mutation is an important source of errors. The ```@def``` macro is used to support self-discipline to minimize or eliminate mutation. 

## The @def macro

This package provides the ```@def``` macro. The def macro binds a variable to a value. Subsequent attempts to bind to the same variable throws an error.

    @def variable = value

Example Usage
```julia
@def y = [1,3,4]
```

assigns the array

```
3-element Array{Int64,1}:
 1
 3
 4
```

attempt to reassign

```julia
@def y = 4

ERROR: "cannot assign variable y; it already has a value"
```

Using ```@def``` with modifiers, e.g.

```julia
@def global x = 2
```

is currently not supported.

## Intended Usage

Prefacing all assignment statements with @def will provide pseudo immutability. Note that the all standard julia operations are still allowed. That is, the statements

```julia
push!(y, 5)
```

or 
```julia
y = 10
```

remain valid and will mutate y.  