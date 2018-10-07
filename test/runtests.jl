using NamedTupleUtilities
using Test

@testset "NamedTupleUtilities" begin

@test remove((a = 1, b = 2, c = 3),Val(:c)) == (a = 1, b = 2)
@test remove((a = 1, b = 2),Val(:c)) == (a = 1, b = 2)
@inferred remove((a = 1, b = 2),Val(:c))

@test range((a = 1, b = 2, c = 3),Val(:a),Val(:b)) == (a = 1, b = 2)
@test range((a = 1, b = 2, c = 3),Val(:b),Val(:d)) == (b = 2, c = 3)
@test range((a = 1, b = 2, c = 3),Val(:d),Val(:c)) == NamedTuple()
@inferred range((a = 1, b = 2, c = 3),Val(:a),Val(:b))

@test rename((a = 1, b = 2, c = 3),Val(:a),Val(:d)) == (d = 1, b = 2, c = 3)
@test rename((a = 1, b = 2, c = 3),Val(:m),Val(:d)) == (a = 1, b = 2, c = 3)
@test_throws ErrorException rename((a = 1, b = 2, c = 3),Val(:a),Val(:c))
@inferred rename((a = 1, b = 2, c = 3),Val(:a),Val(:d))

@test startswith((abc=1,bcd=2,cde=3),Val(:a)) == (abc = 1,)
@test endswith((abc=1,bcd=2,cde=3),Val(:d)) == (bcd = 2,)
@test occursin((abc=1,bcd=2,cde=3),Val(:d)) == (bcd = 2, cde = 3)
@inferred startswith((abc=1,bcd=2,cde=3),Val(:a)) == (abc = 1,)
@inferred endswith((abc=1,bcd=2,cde=3),Val(:d)) == (bcd = 2,)
@inferred occursin((abc=1,bcd=2,cde=3),Val(:d)) == (bcd = 2, cde = 3)

end
