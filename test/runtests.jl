using NamedTupleUtilities
using Test

@testset "NamedTupleUtilities" begin

@test remove((a = 1, b = 2, c = 3),Val(:c)) == (a = 1, b = 2)
@test remove((a = 1, b = 2),Val(:c)) == (a = 1, b = 2)
@inferred remove((a = 1, b = 2),Val(:c))

end
