defmodule ProgrammingBitcoin.EllipticCurvePoint do
  @moduledoc """
  Elliptic Curve Point
  """

  @enforce_keys [:point, :a, :b]
  defstruct [:point, :a, :b]

  alias ProgrammingBitcoin.Point
  import ProgrammingBitcoin.MathUtils, only: [math_pow: 2]

  @type num :: Decimal.t() | float() | integer
  # For simplicity, assume only for integer
  @type t() :: %__MODULE__{
          point: Point.t() | nil,
          a: Decimal.t(),
          b: Decimal.t()
        }
  @spec new(num(), num(), num(), num()) :: t()
  def new(%Decimal{} = x, %Decimal{} = y, %Decimal{} = a, %Decimal{} = b) do
    if Decimal.equal?(
         math_pow(y, 2),
         Decimal.add(Decimal.add(math_pow(x, 3), Decimal.mult(a, x)), b)
       ) do
      %__MODULE__{
        point: %Point{x: x, y: y},
        a: a,
        b: b
      }
    else
      raise "(#{x}, #{y}) is not on the curve"
    end
  end

  def new(x, y, a, b) do
    new(to_decimal(x), to_decimal(y), to_decimal(a), to_decimal(b))
  end

  defp to_decimal(x) when is_integer(x) do
    to_decimal(x / 1)
  end

  defp to_decimal(x) when is_float(x) do
    Decimal.from_float(x)
  end

  defp to_decimal(%Decimal{} = x) do
    x
  end

  @spec is_infinity?(t()) :: boolean
  def is_infinity?(%__MODULE__{point: nil}), do: true
  def is_infinity?(%__MODULE__{} = _), do: false

  @spec get_infinity(num(), num()) :: t()
  def get_infinity(%Decimal{} = a, %Decimal{} = b) do
    %__MODULE__{point: nil, a: a, b: b}
  end

  def get_infinity(a, b) do
    get_infinity(to_decimal(a), to_decimal(b))
  end
end
