defmodule ProgrammingBitcoin.MathUtils do
  @moduledoc """
  Math Utils
  """

  # modulo operation for always returning the same sign as the denominator
  def mod(x, n) do
    rem(rem(x, n) + n, n)
  end

  def math_pow(x, y) when is_integer(x) and is_integer(y) do
    Kernel.trunc(:math.pow(x, y))
  end

  def math_pow(x, y), do: :math.pow(x, y)
end
