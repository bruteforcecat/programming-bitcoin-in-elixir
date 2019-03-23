defmodule ProgrammingBitcoin.Point do
  @moduledoc """
  Point in 2-dimention
  """

  @enforce_keys [:x, :y]
  defstruct [:x, :y]

  @type t() :: %__MODULE__{
          x: float(),
          y: float()
        }
end
