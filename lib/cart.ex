defmodule Cart do
  @moduledoc """
    Cart
    A shopping cart comprised of a list of Products and a tax rate percentage.
    If this were more than an exercise, we would persist state in a process (Genserver, etc)
  """

  defstruct products: [], tax_rate_percent: 12.5

  @doc """
    Adds a given quantity of products to cart
  """
  def add(%Cart{} = cart, %Product{} = product, quantity)
      when is_integer(quantity) do
    1..quantity
    |> Enum.reduce(cart, fn _, acc ->
      add_product_to_cart(acc, product)
    end)
  end

  def add(_, _, _), do: :invalid_input

  @doc """
    Gets total number of products from cart
  """
  def get_num_products(%Cart{} = cart) do
    cart.products
    |> Enum.count()
  end

  def get_num_products(_), do: :invalid_input

  def get_num_products(%Cart{} = cart, product_name) do
    cart.products
    |> Enum.filter(fn p -> p.name == product_name end)
    |> Enum.count()
  end

  def get_num_products(_, _), do: :invalid_input

  @doc """
    Gets total cost of products
  """
  def get_total_cost(%Cart{} = cart) do
    cart.products
    |> Enum.map(& &1.price)
    |> Enum.sum()
    |> round(2)
  end

  def get_total_cost(_), do: :invalid_input

  def get_total_cost_with_tax(%Cart{} = cart) do
    total_cost = get_total_cost(cart)

    total_tax = total_cost * cart.tax_rate_percent / 100

    (total_cost + total_tax) |> round(2)
  end

  def get_total_cost_with_tax(_), do: :invalid_input

  # Adds product to cart
  defp add_product_to_cart(%Cart{products: current_products}, new_product) do
    %Cart{products: current_products ++ [new_product]}
  end

  # Rounds a float to a given number of decimal places.
  # Uses Decimal library for floating point inconsistencies
  defp round(num, places) do
    Decimal.from_float(num) |> Decimal.round(places) |> Decimal.to_float()
  end
end
