defmodule CartTest do
  use ExUnit.Case
  doctest Cart

  test "adds five products" do
    # given an empty cart
    cart = %Cart{}

    # and a product
    product = %Product{name: "Dove", price: 39.99}

    # add five products
    actual =
      cart
      |> Cart.add(product, 5)
      |> IO.inspect()

    num_products =
      actual.products
      |> Enum.count()

    total_cost =
      actual.products
      |> Enum.map(& &1.price)
      |> Enum.sum()
      |> Float.round(2)

    assert num_products == 5
    assert total_cost == 199.95
  end

  test "adds five and three products" do
    # given an empty cart
    cart = %Cart{}

    # and a product
    product = %Product{name: "Dove", price: 39.99}

    # add five products
    actual =
      cart
      |> Cart.add(product, 5)
      |> Cart.add(product, 3)

    num_products =
      actual.products
      |> Enum.count()

    total_cost =
      actual.products
      |> Enum.map(& &1.price)
      |> Enum.sum()
      |> Float.round(2)

    assert num_products == 8
    assert total_cost == 319.92
  end

  test "adds two different products and calculates tax" do
    # given an empty cart
    cart = %Cart{}

    # and products
    dove = %Product{name: "Dove", price: 39.99}
    axe = %Product{name: "Axe", price: 99.99}

    # add five products
    actual =
      cart
      |> Cart.add(dove, 2)
      |> Cart.add(axe, 2)

    num_dove =
      actual.products
      |> Enum.filter(fn p -> p.name == "Dove" end)
      |> Enum.count()

    num_axe =
      actual.products
      |> Enum.filter(fn p -> p.name == "Axe" end)
      |> Enum.count()

    total_cost =
      actual.products
      |> Enum.map(& &1.price)
      |> Enum.sum()

    total_tax =
      (total_cost * cart.tax_rate_percent / 100)
      |> IO.inspect(label: "total_tax")

    grand_total = total_cost + total_tax

    assert num_dove == 2
    assert num_axe == 2

    assert grand_total == 314.96
  end
end
