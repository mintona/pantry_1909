class CookBook
  attr_reader :recipes

  def initialize
    @recipes = []
  end

  def add_recipe(recipe)
    @recipes << recipe
  end

  def sort_ingredients_by_calories(recipe)
    ingredients = recipe.ingredients_required
    sorted_ingredients = ingredients.sort_by { |ingredient, amt_needed| ingredient.calories * amt_needed }.reverse
  end

  def summary
    cookbook_summary = []

    @recipes.each do |recipe|
      name = recipe.name
      total_calories = recipe.total_calories
      sorted_ingredients = sort_ingredients_by_calories(recipe)

      summary = Hash.new(0)
      summary[:name] = name
      details_summary = Hash.new(0)
      details_summary[:ingredients] = []
      details_summary[:total_calories] = total_calories
      details_summary
      summary[:details] = details_summary
      summary

      sorted_ingredients.each do |ingredient|
        info = Hash.new(0)
        info[:ingredient] = ingredient.first.name
        info[:amount] = "#{ingredient.last} #{ingredient.first.unit}"
        details_summary[:ingredients] << info
      end
      cookbook_summary << summary
    end
    cookbook_summary
  end
end
