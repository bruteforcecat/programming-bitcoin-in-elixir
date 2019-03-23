defmodule ProgrammingBitcoin.EllipticCurvePoint do
  @moduledoc """
  Elliptic Curve Point
  """

  @enforce_keys [:point, :a, :b]
  defstruct [:point, :a, :b]

  alias ProgrammingBitcoin.Point
  import ProgrammingBitcoin.MathUtils, only: [math_pow: 2]

  # For simplicity, assume only for integer
  @type t() :: %__MODULE__{
          point: Point.t() | nil,
          a: integer(),
          b: integer()
        }
  @spec new(integer, integer, integer(), integer()) :: t()
  def new(x, y, a, b) do
    if math_pow(y, 2) == math_pow(x, 3) + a * x + b do
      %__MODULE__{
        point: %Point{x: x, y: y},
        a: a,
        b: b
      }
    else
      raise "(#{x}, #{y}) is not on the curve"
    end
  end

  @spec is_infinity?(t()) :: boolean
  def is_infinity?(%__MODULE__{point: nil}), do: true
  def is_infinity?(%__MODULE__{} = _), do: false

  @spec get_infinity(integer, integer) :: t()
  def get_infinity(a, b) do
    %__MODULE__{point: nil, a: a, b: b}
  end
end
