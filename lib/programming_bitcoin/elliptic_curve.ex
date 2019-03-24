defmodule ProgrammingBitcoin.EllipticCurve do
  @moduledoc """
  Elliptic Curve Point
  """

  alias ProgrammingBitcoin.EllipticCurvePoint
  import ProgrammingBitcoin.MathUtils, only: [math_pow: 2]

  @spec add(EllipticCurvePoint.t(), EllipticCurvePoint.t()) :: EllipticCurvePoint.t()
  def add(
        %EllipticCurvePoint{point: nil, a: a1, b: b1} = p1,
        %EllipticCurvePoint{
          a: a2,
          b: b2
        } = p2
      )
      when a1 != a2 or b1 != b2 do
    raise "#{p1} and #{p2} not in the save curve"
  end

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

  # inverse addition
  def add(
        %EllipticCurvePoint{
          point: %{
            x: x,
            y: y1
          },
          a: a,
          b: b
        },
        %EllipticCurvePoint{
          point: %{
            x: x,
            y: y2
          }
        }
      )
      when y1 == -y2 do
    EllipticCurvePoint.get_infinity(a, b)
  end

  # tanget. both point are the same
  def add(
        %EllipticCurvePoint{
          point: %{
            x: x,
            y: y
          },
          a: a,
          b: b
        },
        %EllipticCurvePoint{
          point: %{
            x: x,
            y: y
          }
        }
      ) do
    EllipticCurvePoint.get_infinity(a, b)
  end

  # normal addition
  def add(
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
    s = (y1 - y2) / (x1 - x2)
    x3 = math_pow(s, 2) - x1 - x2
    y3 = s * (x1 - x3) - y1
    EllipticCurvePoint.new(x3, y3, a, b)
  end
end
