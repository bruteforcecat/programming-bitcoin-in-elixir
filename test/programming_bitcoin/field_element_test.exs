defmodule ProgrammingBitcoin.FiniteField.IntegerModuloPrimeTest do
  use ExUnit.Case
  doctest ProgrammingBitcoin.FiniteField.IntegerModuloPrime

  alias ProgrammingBitcoin.FiniteField.IntegerModuloPrime
  alias ProgrammingBitcoin.FiniteField

  test "new/2 constructor work for proper num and prime" do
    assert IntegerModuloPrime.new(1, 3) == %IntegerModuloPrime{num: 1, prime: 3}
  end

  test "new/2 raise exception when num >= prime" do
    assert_raise(FunctionClauseError, fn -> IntegerModuloPrime.new(4, 3) end)
    assert_raise(FunctionClauseError, fn -> IntegerModuloPrime.new(3, 3) end)
  end

  test "add/2 return field element after adding them and return remainder after modulo operation with prime" do
    assert FiniteField.add(IntegerModuloPrime.new(5, 7), IntegerModuloPrime.new(6, 7)) ==
             IntegerModuloPrime.new(4, 7)
  end

  test "add/2 raise exception when two prime are not equal" do
    assert_raise RuntimeError, fn ->
      FiniteField.add(IntegerModuloPrime.new(5, 7), IntegerModuloPrime.new(6, 13))
    end
  end

  test "sub/2 return field element after subtracting them and return remainder after modulo operation with prime" do
    assert FiniteField.sub(IntegerModuloPrime.new(11, 19), IntegerModuloPrime.new(9, 19)) ==
             IntegerModuloPrime.new(2, 19)

    assert FiniteField.sub(IntegerModuloPrime.new(6, 19), IntegerModuloPrime.new(13, 19)) ==
             IntegerModuloPrime.new(12, 19)
  end

  test "sub/2 raise exception when two prime are not equal" do
    assert_raise RuntimeError, fn ->
      FiniteField.sub(IntegerModuloPrime.new(5, 7), IntegerModuloPrime.new(6, 13))
    end
  end

  test "mul/2 return field element after subtracting them and return remainder after modulo operation with prime" do
    assert FiniteField.mul(IntegerModuloPrime.new(3, 13), IntegerModuloPrime.new(12, 13)) ==
             IntegerModuloPrime.new(10, 13)
  end

  test "mul/2 raise exception when two prime are not equal" do
    assert_raise RuntimeError, fn ->
      FiniteField.mul(IntegerModuloPrime.new(3, 13), IntegerModuloPrime.new(3, 19))
    end
  end

  test "pow/2 return field element after subtracting them and return remainder after modulo operation with prime" do
    assert FiniteField.pow(IntegerModuloPrime.new(3, 13), 3) ==
             IntegerModuloPrime.new(1, 13)
  end

  test "pow/2 can handle negative exponent" do
    assert FiniteField.pow(IntegerModuloPrime.new(7, 13), -3) ==
             IntegerModuloPrime.new(8, 13)
  end

  test "div/2 return field element after subtracting them and return remainder after modulo operation with prime" do
    assert FiniteField.div(IntegerModuloPrime.new(2, 19), IntegerModuloPrime.new(7, 19)) ==
             IntegerModuloPrime.new(3, 19)
  end
end
