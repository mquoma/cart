defmodule Cart do
  @moduledoc """
    Cart: a shopping cart.
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
    Gets total number of products from cart
  """
  def get_num_products(%Cart{} = cart) do
    cart.products
    |> Enum.count()
  end

  def get_num_products(%Cart{} = cart, product_name) do
    cart.products
    |> Enum.filter(fn p -> p.name == product_name end)
    |> Enum.count()
  end

  @doc """
    Gets total cost of products
  """
  def get_total_cost(%Cart{} = cart) do
    cart.products
    |> Enum.map(& &1.price)
    |> Enum.sum()
    |> round(2)
  end

  def get_total_cost_with_tax(%Cart{} = cart) do
    total_cost = get_total_cost(cart)

    total_tax = total_cost * cart.tax_rate_percent / 100

    (total_cost + total_tax) |> round(2)
  end

  @doc """
    Adds product to cart
  """
  defp add_product_to_cart(%Cart{products: current_products}, new_product) do
    %Cart{products: current_products ++ [new_product]}
  end

  @doc """
    Rounds a float to a given number of decimal places
  """
  defp round(num, places) do
    Decimal.from_float(num) |> Decimal.round(places) |> Decimal.to_float()
  end
end
