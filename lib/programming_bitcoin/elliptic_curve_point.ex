defmodule ProgrammingBitcoin.EllipticCurvePoint do
  @moduledoc """
  Elliptic Curve Point
  """

  @enforce_keys [:point, :a, :b]
  defstruct [:point, :a, :b]

  alias ProgrammingBitcoin.FiniteField
  import ProgrammingBitcoin.MathUtils, only: [math_pow: 2]

  @type real_num :: Decimal.t() | float() | integer
  @type num :: Decimal.t() | FiniteField.t()
  @type num_for_new :: real_num | num
  # For simplicity, assume only for integer
  @type t() :: %__MODULE__{
          point:
            %{
              x: num,
              y: num
            }
            | nil,
          a: num,
          b: num
        }
  @spec new(num_for_new(), num_for_new(), num_for_new(), num_for_new()) :: t()
  def new(%Decimal{} = x, %Decimal{} = y, %Decimal{} = a, %Decimal{} = b) do
    if Decimal.equal?(
         math_pow(y, 2),
         Decimal.add(Decimal.add(math_pow(x, 3), Decimal.mult(a, x)), b)
       ) do
      %__MODULE__{
        point: %{
          x: x,
          y: y
        },
        a: a,
        b: b
      }
    else
      raise "(#{x}, #{y}) is not on the curve"
    end
  end

  def new(x, y, a, b) do
    if Enum.all?([x, y, a, b], &FiniteField.impl_for/1) do
      if FiniteField.pow(y, 2) ==
           FiniteField.add(FiniteField.add(FiniteField.pow(x, 3), FiniteField.mul(a, x)), b) do
        %__MODULE__{
          point: %{
            x: x,
            y: y
          },
          a: a,
          b: b
        }
      else
        raise "(#{x}, #{y}) is not on the curve"
      end
    else
      new(to_decimal(x), to_decimal(y), to_decimal(a), to_decimal(b))
    end
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
