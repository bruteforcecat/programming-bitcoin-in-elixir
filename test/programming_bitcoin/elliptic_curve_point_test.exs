defmodule ProgrammingBitcoin.EllipticCurvePointTest do
  use ExUnit.Case
  doctest ProgrammingBitcoin.EllipticCurvePoint

  alias ProgrammingBitcoin.EllipticCurvePoint
  alias ProgrammingBitcoin.FiniteField.IntegerModuloPrime

  test "new/2 constructor work for proper num and prime" do
    assert EllipticCurvePoint.new(Decimal.new(-1), Decimal.new(1), Decimal.new(5), Decimal.new(7)) == %EllipticCurvePoint{
             point: %{
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

  test "new/2 constructor work for finite field integer modulo prime" do
    prime = 223
    a = IntegerModuloPrime.new(0, 223)
    b = IntegerModuloPrime.new(7, 223)
    x = IntegerModuloPrime.new(192, 223)
    y = IntegerModuloPrime.new(105, 223)
    assert EllipticCurvePoint.new(x, y, a, b) == %EllipticCurvePoint{
             point: %{
               x: IntegerModuloPrime.new(192, 223),
               y: IntegerModuloPrime.new(105, 223),
             },
             a: a,
             b: b
           }
  end

end
