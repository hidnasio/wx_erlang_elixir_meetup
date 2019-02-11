defmodule Example3Test do
  use ExUnit.Case
  doctest Example3

  test "greets the world" do
    assert Example3.hello() == :world
  end
end
