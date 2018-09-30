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

"""
    range(a::NamedTuple, b::Val{n}, c::Val{n})

Return a NamedTuple which retains the fields from `b` to `c` in `a`. 
If `b` is not in `a`, then it will return empty NamedTuple. 
If `c` is not in `a`, then it will return everything started with `b`.

```jldoctest
julia>range((a=1,b=2,c=3),Val(:a),Val(:b))
(a = 1, b = 2)
```
"""
@generated function Base.range(a::NamedTuple{an}, ::Val{bn}, ::Val{cn}) where {an, bn, cn}
    rangeStarted = false
    names = ()
    for n in an
        if n == bn
            rangeStarted = true
        end
        if rangeStarted
            names = (names..., n)
        end
        if n == cn
            rangeStarted = false
        end
    end
    types = Tuple{Any[ fieldtype(a, n) for n in names ]...}
    vals = Any[ :(getfield(a, $(QuoteNode(n)))) for n in names ]
    :( NamedTuple{$names,$types}(($(vals...),)) )
end

end # module
