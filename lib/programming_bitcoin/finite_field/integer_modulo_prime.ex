defmodule ProgrammingBitcoin.FiniteField.IntegerModuloPrime do
  @moduledoc """
  One of Finite Field: Interger modulo prime
  """

  @enforce_keys [:num, :prime]
  defstruct [:num, :prime]

  @type t() :: %__MODULE__{
          num: integer(),
          prime: integer()
        }

  @spec new(integer, integer) :: t()
  def new(num, prime) when num >= 0 and num < prime,
    do: %__MODULE__{num: num, prime: prime}
end

defimpl ProgrammingBitcoin.FiniteField, for: ProgrammingBitcoin.FiniteField.IntegerModuloPrime do
  alias ProgrammingBitcoin.FiniteField.IntegerModuloPrime
  import ProgrammingBitcoin.MathUtils, only: [mod: 2, math_pow: 2]

  def add(%IntegerModuloPrime{num: num1, prime: prime}, %IntegerModuloPrime{
        num: num2,
        prime: prime
      }) do
    IntegerModuloPrime.new(mod(num1 + num2, prime), prime)
  end

  def add(%IntegerModuloPrime{prime: prime1}, %IntegerModuloPrime{prime: prime2})
      when prime1 != prime2 do
    # TODO using exception struct
    raise "Cannot add two numbers in different Fields"
  end

  def sub(%IntegerModuloPrime{num: num1, prime: prime}, %IntegerModuloPrime{
        num: num2,
        prime: prime
      }) do
    IntegerModuloPrime.new(mod(num1 - num2, prime), prime)
  end

  def sub(%IntegerModuloPrime{prime: prime1}, %IntegerModuloPrime{prime: prime2})
      when prime1 != prime2 do
    # TODO using exception struct
    raise "Cannot sub two numbers in different Fields"
  end

  def mul(%IntegerModuloPrime{num: num1, prime: prime}, %IntegerModuloPrime{
        num: num2,
        prime: prime
      }) do
    IntegerModuloPrime.new(mod(num1 * num2, prime), prime)
  end

  def mul(%IntegerModuloPrime{prime: prime1}, %IntegerModuloPrime{prime: prime2})
      when prime1 != prime2 do
    # TODO using exception struct
    raise "Cannot mul two numbers in different Fields"
  end

  def div(%IntegerModuloPrime{num: num1, prime: prime}, %IntegerModuloPrime{
        num: num2,
        prime: prime
      }) do
    # from Fermat's little theorem:
    # n^(p-1) mod p = 1
    # this implies:
    # 1/n == n^(p - 2) mod p
    # we return an element of the same class
    # naive implemtation using math_pow as it's very computational heavy
    # TODO
    IntegerModuloPrime.new(mod(num1 * math_pow(num2, prime - 2), prime), prime)
  end

  def pow(%IntegerModuloPrime{num: num, prime: prime}, exponent) when is_integer(exponent) do
    # mod(exponent, prime - 1) to force a number out of negative
    # Make the exponent into something within the 0 to p–2 range, inclusive.
    IntegerModuloPrime.new(
      mod(Kernel.trunc(math_pow(num, mod(exponent, prime - 1))), prime),
      prime
    )
  end
end
