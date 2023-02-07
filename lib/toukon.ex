defmodule Toukon do
  @moduledoc """
  Documentation for `Toukon`.
  """

  @doc """
  binta

  ## Options
    * `:add_args` (list of strings) - Defaults to `["\"闘魂\""]`.
    * `:namespace` (string) - Defaults to `"Inoki"`.

  ## Examples
      iex> Toukon.binta(Enum)
      iex> Inoki.Enum.map(0..2, & &1 + 1, "闘魂")
      [1, 2, 3]

      iex> Toukon.binta(Enum, namespace: "Inoki.Kanji")
      iex> Inoki.Kanji.Enum.map(0..2, & &1 + 1, "闘魂")
      [1, 2, 3]

  """
  @spec binta(atom, keyword) :: {any, [{any, any}]}
  def binta(mod, opts \\ []) do
    opts = Keyword.merge([add_args: ["\"闘魂\""], namespace: "Inoki"], opts)
    add_args = Keyword.get(opts, :add_args)
    namespace = Keyword.get(opts, :namespace)

    short_mod = "#{mod}" |> String.split(".") |> Enum.at(-1)

    funs = build_funs(mod, add_args)

    """
    defmodule #{namespace}.#{short_mod} do
      #{funs}
    end
    """
    |> Code.eval_string()
  end

  defp build_args(arity, add_args) do
    "#{1..arity//1 |> Enum.map(&"a#{&1}") |> Kernel.++(add_args) |> Enum.join(",")}"
  end

  defp build_funs(mod, add_args) do
    mod.__info__(:functions)
    |> Enum.reject(fn {name, _} ->
      name in [:+, :!=, :!==, :*, :**, :++, :-, :--, :/, :<, :<=, :==, :===, :=~, :>, :>=, :not]
    end)
    |> Enum.map(fn {name, arity} ->
      """
      def #{name}(#{build_args(arity, add_args)}), do: #{mod}.#{name}(#{build_args(arity, [])})
      """
    end)
    |> Enum.join("\n")
  end
end
