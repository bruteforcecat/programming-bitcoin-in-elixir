defmodule ProgrammingBitcoin.FieldElementTest do
  use ExUnit.Case
  doctest ProgrammingBitcoin.FieldElement

  alias ProgrammingBitcoin.FieldElement

  test "new/2 constructor work for proper num and prime" do
    assert FieldElement.new(1, 3) == %FieldElement{num: 1, prime: 3}
  end

  test "new/2 raise exception when num >= prime" do
    assert_raise(FunctionClauseError, fn -> FieldElement.new(4, 3) end)
    assert_raise(FunctionClauseError, fn -> FieldElement.new(3, 3) end)
  end

  test "add/2 return field element after adding them and return remainder after modulo operation with prime" do
    assert FieldElement.add(FieldElement.new(5, 7), FieldElement.new(6, 7)) ==
             FieldElement.new(4, 7)
  end

  test "add/2 raise exception when two prime are not equal" do
    assert_raise RuntimeError, fn ->
      FieldElement.add(FieldElement.new(5, 7), FieldElement.new(6, 13))
    end
  end

  test "sub/2 return field element after subtracting them and return remainder after modulo operation with prime" do
    assert FieldElement.sub(FieldElement.new(11, 19), FieldElement.new(9, 19)) ==
             FieldElement.new(2, 19)

    assert FieldElement.sub(FieldElement.new(6, 19), FieldElement.new(13, 19)) ==
             FieldElement.new(12, 19)
  end

  test "sub/2 raise exception when two prime are not equal" do
    assert_raise RuntimeError, fn ->
      FieldElement.sub(FieldElement.new(5, 7), FieldElement.new(6, 13))
    end
  end

  test "mul/2 return field element after subtracting them and return remainder after modulo operation with prime" do
    assert FieldElement.mul(FieldElement.new(3, 13), FieldElement.new(12, 13)) ==
             FieldElement.new(10, 13)
  end

  test "mul/2 raise exception when two prime are not equal" do
    assert_raise RuntimeError, fn ->
      FieldElement.mul(FieldElement.new(3, 13), FieldElement.new(3, 19))
    end
  end

  test "pow/2 return field element after subtracting them and return remainder after modulo operation with prime" do
    assert FieldElement.pow(FieldElement.new(3, 13), 3) ==
             FieldElement.new(1, 13)
  end

  test "pow/2 can handle negative exponent" do
    assert FieldElement.pow(FieldElement.new(7, 13), -3) ==
             FieldElement.new(8, 13)
  end

  test "truediv/2 return field element after subtracting them and return remainder after modulo operation with prime" do
    assert FieldElement.truediv(FieldElement.new(2, 19), FieldElement.new(7, 19)) ==
             FieldElement.new(3, 19)
  end

end
