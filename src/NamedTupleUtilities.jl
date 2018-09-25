module NamedTupleUtilities
export remove
"""
    remove(a::NamedTuple, v::Val{n})

Remove a field `n` from the `a` if it is in `a`.

```jldoctest
julia>remove((a=1,b=2,c=3),Val(:c))
(a = 1, b = 2)
```
"""
@generated function remove(a::NamedTuple{an}, ::Val{bn}) where {an, bn}
    names = (filter(item -> item != bn, [n for n in an])...,)
    types = Tuple{Any[ fieldtype(a, n) for n in names ]...}
    vals = Any[ :(getfield(a, $(QuoteNode(n)))) for n in names ]
    :( NamedTuple{$names,$types}(($(vals...),)) )
end

end # module
