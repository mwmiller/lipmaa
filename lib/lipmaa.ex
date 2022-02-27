defmodule Lipmaa do
  @moduledoc """
  Compute Lipmaa backlinks
  """
  @maxseq Integer.pow(2, 64) - 1
  @powk Enum.map(0..41, fn n -> Integer.pow(3, n) end)
  @divk Enum.map(@powk, fn p -> div(p - 1, 2) end)

  @doc """
  Compute the sequence number to which to link from a provided sequence number

  Provided sequence in the range [1, 2⁶⁴ - 1]
  Returns in the range [0, 2⁶⁴ - 2]

  ## Examples

      iex> Lipmaa.linkseq(1)               
      0

      iex> Lipmaa.linkseq(40)               
      13
  """
  @spec linkseq(pos_integer) :: non_neg_integer | :error
  def linkseq(n) when not is_integer(n) or n <= 0 or n > @maxseq, do: :error
  def linkseq(n) when n in @divk, do: n - val_for_k(@powk, index_for(@divk, n) - 1)
  def linkseq(n), do: n - val_for_k(@divk, g(n))

  defp g(n) when n in @divk, do: index_for(@divk, n)
  defp g(n), do: g(n - val_for_k(@divk, index_for(@divk, n) - 1))

  # This returns where `n` does or would appear in the sorted list
  def index_for(set, n) do
    set
    |> Enum.take_while(fn i -> i < n end)
    |> Enum.count()
  end

  defp val_for_k(set, k), do: Enum.at(set, k)
end
