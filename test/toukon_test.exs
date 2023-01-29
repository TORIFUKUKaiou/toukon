defmodule ToukonTest do
  use ExUnit.Case
  doctest Toukon

  test "binta" do
    Toukon.binta(Enum, add_args: ["\"燃える闘魂\"", "\"元氣ですかーーーーッ！！！\""], namespace: "Inoki.Kanji")
    assert Inoki.Kanji.Enum.map(0..2, &(&1 + 1), "燃える闘魂", "元氣ですかーーーーッ！！！") == [1, 2, 3]
  end
end
