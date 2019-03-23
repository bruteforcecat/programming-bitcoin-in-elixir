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
  def new(num, prime) when num > 0 and num < prime,
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
    raise "Cannot add two numbers in different Fields"
  end

  # modulo operation for always returning the same sign as the denominator
  defp mod(x, n) do
    rem(rem(x, n) + n, n)
  end
end
