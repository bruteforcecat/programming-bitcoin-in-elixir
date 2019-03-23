defmodule ProgrammingBitcoinTest do
  use ExUnit.Case
  doctest ProgrammingBitcoin

  test "greets the world" do
    assert ProgrammingBitcoin.hello() == :world
  end
end
