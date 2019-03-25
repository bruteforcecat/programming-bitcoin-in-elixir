defmodule ProgrammingBitcoin.EllipticCurve do
  @moduledoc """
  Elliptic Curve Point
  """

  alias ProgrammingBitcoin.EllipticCurvePoint
  alias ProgrammingBitcoin.FiniteField
  import ProgrammingBitcoin.MathUtils, only: [math_pow: 2]
  require ProgrammingBitcoin

  @spec add(EllipticCurvePoint.t(), EllipticCurvePoint.t()) :: EllipticCurvePoint.t()

  def add(
        %EllipticCurvePoint{point: nil},
        %EllipticCurvePoint{} = p2
      ) do
    p2
  end

  def add(
        %EllipticCurvePoint{} = p1,
        %EllipticCurvePoint{
          point: nil
        }
      ) do
    p1
  end

  # we are using Decimal. so we can only pattern matching inside function body instead in guard
  def add(
        p1,
        p2
      ) do
    case {p1, p2} do
      # tanget. both point are the same
      {%EllipticCurvePoint{
         a: a,
         b: b
       } = p, p} ->
        EllipticCurvePoint.get_infinity(a, b)

      {%EllipticCurvePoint{
         a: a,
         b: b
       } = p1, %EllipticCurvePoint{} = p2} ->
        # inverse
        if points_equal?(p1, p2) do
          EllipticCurvePoint.get_infinity(a, b)
        else
          do_add(p1, p2)
        end

      _ ->
        raise "#{p1} and #{p2} not in the save curve"
    end
  end

  defp do_add(
         %EllipticCurvePoint{
           point: %{
             x: x1,
             y: y1
           },
           a: %Decimal{} = a,
           b: %Decimal{} = b
         },
         %EllipticCurvePoint{
           point: %{
             x: x2,
             y: y2
           }
         }
       ) do
    s = Decimal.div(Decimal.sub(y1, y2), Decimal.sub(x1, x2))
    x3 = Decimal.sub(Decimal.sub(math_pow(s, 2), x1), x2)
    y3 = Decimal.sub(Decimal.mult(s, Decimal.sub(x1, x3)), y1)
    EllipticCurvePoint.new(x3, y3, a, b)
  end

  defp do_add(
         %EllipticCurvePoint{
           point: %{
             x: x1,
             y: y1
           },
           a: a,
           b: b
         },
         %EllipticCurvePoint{
           point: %{
             x: x2,
             y: y2
           }
         }
       ) do
    s = FiniteField.div(FiniteField.sub(y1, y2), FiniteField.sub(x1, x2))
    x3 = FiniteField.sub(FiniteField.sub(FiniteField.pow(s, 2), x1), x2)
    y3 = FiniteField.sub(FiniteField.mul(s, FiniteField.sub(x1, x3)), y1)
    EllipticCurvePoint.new(x3, y3, a, b)
  end

  defp points_equal?(
         %EllipticCurvePoint{
           a: %Decimal{},
           point: %{
             x: x1,
             y: y1
           }
         },
         %EllipticCurvePoint{
           a: %Decimal{},
           point: %{
             x: x2,
             y: y2
           }
         }
       ) do
    Decimal.equal?(x1, x2) and Decimal.equal?(y1, Decimal.minus(y2))
  end

  defp points_equal?(
         %EllipticCurvePoint{} = p1,
         %EllipticCurvePoint{} = p2
       ) do
    p1 == p2
  end
end
