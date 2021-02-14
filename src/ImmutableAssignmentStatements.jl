module ImmutableAssignmentStatements

export @def

"""
The def macro binds a variable to a value. Subsequent attempts to bind to the
same variable throws an error.

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
"""
macro def(ex::Expr) 
    f = typeof(ex.args[1]) == Symbol ? [esc(ex.args[1])] : esc.(ex.args[1].args)
    err = "cannot assign variable(s) $(ex.args[1]); it already has a value"
    assignit = Meta.parse("$(ex.args[1]) = $(ex.args[2])") 
    defined = Expr(:call, (|), map(x -> Expr(:call, :eval, Expr(:isdefined, x)), f)...)
    quote 
        if $(defined)
            throw($err) 
        else 
            :($$assignit) 
        end 
    end 
end

end

