defmodule ProgrammingBitcoin.EllipticCurveTest do
  use ExUnit.Case
  doctest ProgrammingBitcoin.EllipticCurve

  alias ProgrammingBitcoin.EllipticCurve
  alias ProgrammingBitcoin.EllipticCurvePoint

  test "add/2 return the point itself when adding it to identity" do
    a = 5
    b = 7
    point = EllipticCurvePoint.new(-1, 1, a, b)
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
end
