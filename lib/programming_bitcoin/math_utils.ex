defmodule ProgrammingBitcoin.MathUtils do
  @moduledoc """
  Math Utils
  """

  # modulo operation for always returning the same sign as the denominator
  def mod(x, n) do
    rem(rem(x, n) + n, n)
  end

  # currently only supoort decimal ^ integer
  @spec math_pow(Decimal.t() | integer(), integer()) :: Decimal.t() | number()
  def math_pow(%Decimal{} = d, exp) when is_integer(exp) do
    Enum.reduce(1..exp, 1, fn _, result ->
      Decimal.mult(d, result)
    end)
  end

  def math_pow(d, exp) when is_integer(exp) and is_integer(d) do
    Enum.reduce(1..exp, 1, fn _, result ->
      d * result
    end)
  end
end
