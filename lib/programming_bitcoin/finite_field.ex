defprotocol ProgrammingBitcoin.FiniteField do
  @moduledoc """
  A Finite field is a set on which the operations of multiplication, addition, subtraction and division are defined and satisfy certain basic rules
  """

  @doc "Calculates the size (and not the length!) of a data structure"
  @spec add(t, t) :: t
  def add(field, field)

  @spec sub(t, t) :: t
  def sub(field, field)

  @spec mul(t, t) :: t
  def mul(field, field)

  @spec div(t, t) :: t
  def div(field, field)

  @spec pow(t, integer) :: t
  def pow(field, exp)

  # @spec additive_identity() :: t
  # def additive_identity()

  # @spec multiplicative_identity() :: t
  # def multiplicative_identity()
end
