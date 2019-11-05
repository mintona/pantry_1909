require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/recipe'
require_relative '../lib/ingredient'

class RecipeTest < Minitest::Test

  def setup
    @mac_and_cheese = Recipe.new("Mac and Cheese")

    @cheese = Ingredient.new("Cheese", "C", 100)
    @mac = Ingredient.new("Macaroni", "oz", 30)
  end

  def test_it_exists
    assert_instance_of Recipe, @mac_and_cheese
  end

  def test_it_has_attributes
    assert_equal "Mac and Cheese", @mac_and_cheese.name
    assert_equal ({}), @mac_and_cheese.ingredients_required
  end

  def test_it_can_add_ingredients
    assert_equal ({}), @mac_and_cheese.ingredients_required

    @mac_and_cheese.add_ingredient(@cheese, 2)
    @mac_and_cheese.add_ingredient(@mac, 8)

    expected = {@cheese => 2, @mac => 8}

    assert_equal expected, @mac_and_cheese.ingredients_required
  end

  def test_it_can_get_the_amount_required_by_ingredient
    butter = Ingredient.new("Butter", "tbsp", 60)

    @mac_and_cheese.add_ingredient(@cheese, 2)
    @mac_and_cheese.add_ingredient(@mac, 8)

    assert_equal 2, @mac_and_cheese.amount_required(@cheese)
    assert_equal 8, @mac_and_cheese.amount_required(@mac)
    assert_equal 0, @mac_and_cheese.amount_required(butter)
  end

  def test_it_can_list_all_ingredients
    @mac_and_cheese.add_ingredient(@cheese, 2)
    @mac_and_cheese.add_ingredient(@mac, 8)

    assert_equal [@cheese, @mac], @mac_and_cheese.ingredients
  end

  def test_it_can_calculate_total_calories
    @mac_and_cheese.add_ingredient(@cheese, 2)
    @mac_and_cheese.add_ingredient(@mac, 8)

    assert_equal 440, @mac_and_cheese.total_calories
  end

end
