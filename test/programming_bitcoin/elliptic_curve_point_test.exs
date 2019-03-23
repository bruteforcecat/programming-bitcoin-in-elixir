defmodule ProgrammingBitcoin.EllipticCurvePointTest do
  use ExUnit.Case
  doctest ProgrammingBitcoin.EllipticCurvePoint

  alias ProgrammingBitcoin.EllipticCurvePoint
  alias ProgrammingBitcoin.Point

  test "new/2 constructor work for proper num and prime" do
    assert EllipticCurvePoint.new(-1, 1, 5, 7) == %EllipticCurvePoint{
             point: %Point{
               x: -1,
               y: 1
             },
             a: 5,
             b: 7
           }
  end

  test "new/2 raise exception when num >= prime" do
    assert_raise(RuntimeError, fn -> EllipticCurvePoint.new(-1, 5, 5, 7) end)
  end
end
