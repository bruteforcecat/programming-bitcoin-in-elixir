defmodule ProgrammingBitcoin.EllipticCurve do
  @moduledoc """
  Elliptic Curve Point
  """

  alias ProgrammingBitcoin.EllipticCurvePoint

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
            y: y1
          },
          a: a,
          b: b
        },
        %EllipticCurvePoint{
          point: %{
            y: y2
          }
        }
      )
      when y1 == -y2 do
    EllipticCurvePoint.get_infinity(a, b)
  end
end
