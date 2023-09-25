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
  def linkseq(n) when n in @divk, do: n - Enum.at(@powk, index_for(@divk, n) - 1)
  def linkseq(n), do: n - Enum.at(@divk, g(n))

  defp g(n) when n in @divk, do: index_for(@divk, n)
  defp g(n), do: g(n - Enum.at(@divk, index_for(@divk, n) - 1))

  # This returns where `n` does or would appear in the sorted list
  defp index_for(set, n), do: set |> Enum.find_index(fn i -> i >= n end)

  @doc """
  A list of the seqeunce numbers to be verified to ensure a consistent
  forward-looking structure using sequence members.

  ## Examples

      iex> Lipmaa.cert_pool(1)
      [1]

      iex> Lipmaa.cert_pool(23)
      [40, 39, 26, 25, 24, 23, 22, 21, 17, 13, 4, 1]
  """
  @spec cert_pool(pos_integer) :: [pos_integer]
  def cert_pool(n) do
    start = Enum.at(@divk, index_for(@divk, n))
    back_to_one(start, n, [start])
  end

  defp back_to_one(1, _, acc), do: Enum.reverse(acc)

  defp back_to_one(pos, via, acc) do
    ll = Lipmaa.linkseq(pos)

    next =
      case pos > via and ll < via do
        true -> pos - 1
        false -> ll
      end

    back_to_one(next, via, [next | acc])
  end
end
