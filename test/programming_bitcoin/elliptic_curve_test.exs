defmodule ProgrammingBitcoin.EllipticCurveTest do
  use ExUnit.Case
  doctest ProgrammingBitcoin.EllipticCurve

  alias ProgrammingBitcoin.EllipticCurve
  alias ProgrammingBitcoin.FiniteField.IntegerModuloPrime
  alias ProgrammingBitcoin.EllipticCurvePoint

  test "add/2 return the point itself when adding it to identity" do
    a = Decimal.new(5)
    b = Decimal.new(7)
    point = EllipticCurvePoint.new(Decimal.new(-1), Decimal.new(1), a, b)
    assert EllipticCurve.add(point, EllipticCurvePoint.get_infinity(a, b)) == point
    assert EllipticCurve.add(EllipticCurvePoint.get_infinity(a, b), point) == point
  end

  test "add/2 return the infinity point when two point are inverse" do
    a = 5
    b = 7
    point1 = EllipticCurvePoint.new(-1, -1, a, b)
    point2 = EllipticCurvePoint.new(-1, 1, a, b)
    assert EllipticCurve.add(point1, point2) == EllipticCurvePoint.get_infinity(a, b)
  end

  test "add/2 return the infinity point when two points are the same" do
    a = 5
    b = 7
    point1 = EllipticCurvePoint.new(-1, -1, a, b)
    assert EllipticCurve.add(point1, point1) == EllipticCurvePoint.get_infinity(a, b)
  end

  test "add/2 return the correct point given two point are not inverse" do
    a = 5
    b = 7
    point1 = EllipticCurvePoint.new(2, 5, a, b)
    point2 = EllipticCurvePoint.new(-1, -1, a, b)
    assert EllipticCurve.add(point1, point2) == EllipticCurvePoint.new(3, -7, a, b)
  end

  test "add/2 also work for finite field point return the correct point given two point are not inverse" do
    prime = 223
    a = IntegerModuloPrime.new(0, prime)
    b = IntegerModuloPrime.new(7, prime)

    point1 =
      EllipticCurvePoint.new(
        IntegerModuloPrime.new(192, prime),
        IntegerModuloPrime.new(105, prime),
        a,
        b
      )

    point2 =
      EllipticCurvePoint.new(
        IntegerModuloPrime.new(17, prime),
        IntegerModuloPrime.new(56, prime),
        a,
        b
      )

    assert EllipticCurve.add(point1, point2) ==
             EllipticCurvePoint.new(
               IntegerModuloPrime.new(170, prime),
               IntegerModuloPrime.new(142, prime),
               a,
               b
             )
  end
end
