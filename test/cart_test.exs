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

    num_products =
      actual
      |> Cart.get_num_products()

    total_cost =
      actual
      |> Cart.get_total_cost()

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
      actual
      |> Cart.get_num_products()

    total_cost =
      actual
      |> Cart.get_total_cost()

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
      actual
      |> Cart.get_num_products("Dove")

    num_axe =
      actual
      |> Cart.get_num_products("Axe")

    total_cost_with_tax =
      actual
      |> Cart.get_total_cost_with_tax()

    assert num_dove == 2
    assert num_axe == 2

    assert total_cost_with_tax == 314.96
  end
end
