defmodule CartTest do
  use ExUnit.Case
  doctest Cart

  test "step 1: adds five products" do
    # given an empty cart...
    cart = %Cart{}

    # and a product...
    product = %Product{name: "Dove Soap", price: 39.99}

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

    # verify number of products and total cost
    assert num_products == 5
    assert total_cost == 199.95
  end

  test "step 2: adds five and then three products" do
    # given an empty cart...
    cart = %Cart{}

    # and a product...
    product = %Product{name: "Dove Soap", price: 39.99}

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

    # verify number of products and total cost
    assert num_products == 8
    assert total_cost == 319.92
  end

  test "step 3: adds two different products and calculates tax" do
    # given an empty cart
    cart = %Cart{}

    # and products
    dove = %Product{name: "Dove Soap", price: 39.99}
    axe = %Product{name: "Axe Deo", price: 99.99}

    # add five products
    actual =
      cart
      |> Cart.add(dove, 2)
      |> Cart.add(axe, 2)

    num_dove =
      actual
      |> Cart.get_num_products("Dove Soap")

    num_axe =
      actual
      |> Cart.get_num_products("Axe Deo")

    total_cost_with_tax =
      actual
      |> Cart.get_total_cost_with_tax()

    # verify number of products and total cost with tax
    assert num_dove == 2
    assert num_axe == 2

    assert total_cost_with_tax == 314.96
  end
end
