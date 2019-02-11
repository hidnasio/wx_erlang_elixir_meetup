defmodule SquareTest do
  use ExUnit.Case
  doctest Square

  test "greets the world" do
    assert Square.hello() == :world
  end
end
