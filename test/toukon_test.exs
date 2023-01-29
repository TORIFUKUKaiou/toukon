defmodule ToukonTest do
  use ExUnit.Case
  doctest Toukon

  test "greets the world" do
    assert Toukon.hello() == :world
  end
end
