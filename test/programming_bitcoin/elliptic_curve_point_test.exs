defmodule ProgrammingBitcoin.EllipticCurvePointTest do
  use ExUnit.Case
  doctest ProgrammingBitcoin.EllipticCurvePoint

  alias ProgrammingBitcoin.EllipticCurvePoint
  alias ProgrammingBitcoin.Point

  test "new/2 constructor work for proper num and prime" do
    assert EllipticCurvePoint.new(Decimal.new(-1), Decimal.new(1), Decimal.new(5), Decimal.new(7)) == %EllipticCurvePoint{
             point: %Point{
               x: Decimal.new(-1),
               y: Decimal.new(1)
             },
             a: Decimal.new(5),
             b: Decimal.new(7)
           }
  end

  test "new/2 raise exception when num >= prime" do
    assert_raise(RuntimeError, fn -> EllipticCurvePoint.new(-1, 5, 5, 7) end)
  end
end
