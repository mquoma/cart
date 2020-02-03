defmodule Cart do
  @moduledoc """
  Documentation for Cart.
  """

  defstruct products: [], tax_rate_percent: 12.5

  @doc """
    Adds a given quantity of products to cart
  """
  def add(%Cart{} = cart, product, quantity) do
    1..quantity
    |> Enum.reduce(cart, fn _, acc ->
      add_product_to_cart(acc, product)
    end)
  end

  @doc """
  Adds products to cart
  """
  defp add_product_to_cart(%Cart{products: current_products}, new_products) do
    %Cart{products: current_products ++ [new_products]}
  end
end
