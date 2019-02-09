defmodule Example2Test do
  use ExUnit.Case
  doctest Example2

  test "greets the world" do
    assert Example2.hello() == :world
  end
end
