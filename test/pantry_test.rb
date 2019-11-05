require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/recipe'
require_relative '../lib/ingredient'
require_relative '../lib/pantry'

class PantryTest < Minitest::Test

  def setup
    @pantry = Pantry.new
    @cheese = Ingredient.new("Cheese", "C", 50)
    @mac = Ingredient.new("Macaroni", "oz", 200)
    @mac_and_cheese = Recipe.new("Mac and Cheese")
    @mac_and_cheese.add_ingredient(@cheese, 2)
    @mac_and_cheese.add_ingredient(@mac, 8)
  end

  def test_it_exists
    assert_instance_of Pantry, @pantry
  end

  def test_it_has_attributes
    assert_equal ({}), @pantry.stock
  end

  def test_it_can_stock_check_by_ingredient
    assert_equal 0, @pantry.stock_check(@cheese)
  end

  def test_it_can_restock_by_ingredient
    assert_equal 0, @pantry.stock_check(@cheese)

    @pantry.restock(@cheese, 5)
    assert_equal 5, @pantry.stock_check(@cheese)

    @pantry.restock(@cheese, 10)
    assert_equal 15, @pantry.stock_check(@cheese)
    assert_equal 0, @pantry.stock_check(@mac)
  end

  def test_it_can_check_if_it_has_enough_ingredients_for_recipe
    @pantry.restock(@cheese, 15)
    assert_equal false, @pantry.enough_ingredients_for?(@mac_and_cheese)

    @pantry.restock(@mac, 7)
    assert_equal false, @pantry.enough_ingredients_for?(@mac_and_cheese)

    @pantry.restock(@mac, 1)
    assert_equal true, @pantry.enough_ingredients_for?(@mac_and_cheese)

    butter = Ingredient.new("Butter", "tbsp", 60)
    @mac_and_cheese.add_ingredient(butter, 4)
    assert_equal false, @pantry.enough_ingredients_for?(@mac_and_cheese)
  end
end
