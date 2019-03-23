defmodule ProgrammingBitcoin.FieldElement do
  @moduledoc """
  Finite Field
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

  @spec add(t(), t()) :: t()
  def add(%__MODULE__{num: num1, prime: prime}, %__MODULE__{num: num2, prime: prime}) do
    new(mod(num1 + num2, prime), prime)
  end

  def add(%__MODULE__{prime: prime1}, %__MODULE__{prime: prime2}) when prime1 != prime2 do
    # TODO using exception struct
    raise "Cannot add two numbers in different Fields"
  end

  @spec sub(t(), t()) :: t()
  def sub(%__MODULE__{num: num1, prime: prime}, %__MODULE__{num: num2, prime: prime}) do
    new(mod(num1 - num2, prime), prime)
  end

  def sub(%__MODULE__{prime: prime1}, %__MODULE__{prime: prime2}) when prime1 != prime2 do
    # TODO using exception struct
    raise "Cannot sub two numbers in different Fields"
  end

  @spec mul(t(), t()) :: t()
  def mul(%__MODULE__{num: num1, prime: prime}, %__MODULE__{num: num2, prime: prime}) do
    new(mod(num1 * num2, prime), prime)
  end

  def mul(%__MODULE__{prime: prime1}, %__MODULE__{prime: prime2}) when prime1 != prime2 do
    # TODO using exception struct
    raise "Cannot mul two numbers in different Fields"
  end

  @spec pow(t(), integer()) :: t()
  def pow(%__MODULE__{num: num, prime: prime}, exponent) when is_integer(exponent) do
    # mod(exponent, prime - 1) to force a number out of negative
    # Make the exponent into something within the 0 to p–2 range, inclusive.
    new(mod(Kernel.trunc(math_pow(num, mod(exponent, prime - 1))), prime), prime)
  end

  # def pow(%__MODULE__{num: num, prime: prime} = x, exponent) when is_integer(exponent) and exponent < 0 do
  #   # from Fermat's little theorem:
  #   new(mod(Kernel.trunc(math_pow(num, num + prime - 1)), prime), prime)
  # end

  @spec truediv(t(), t()) :: t()
  def truediv(%__MODULE__{num: num1, prime: prime}, %__MODULE__{num: num2, prime: prime}) do
    # from Fermat's little theorem:
    # n^(p-1) mod p = 1
    # this implies:
    # 1/n == n^(p - 2) mod p
    # we return an element of the same class
    # naive implemtation using math_pow as it's very computational heavy
    # TODO
    new(mod(num1 * math_pow(num2, prime - 2), prime), prime)
  end

  # modulo operation for always returning the same sign as the denominator
  defp mod(x, n) do
    rem(rem(x, n) + n, n)
  end

  defp math_pow(x, y) when is_integer(x) and is_integer(y) do
    Kernel.trunc(:math.pow(x, y))
  end

  defp math_pow(x, y), do: :math.pow(x, y)
end
