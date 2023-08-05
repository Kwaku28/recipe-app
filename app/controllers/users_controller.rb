class UsersController < ApplicationController
  def shopping_list
    @recipes = current_user.recipes.includes(recipe_foods: :food)
    @all_recipe_foods = @recipes.map(&:recipe_foods).flatten

    @recipe_foods = []
    food_quantities = Hash.new(0)  # Hash to store cumulative quantities by food name

    @all_recipe_foods.each do |recipe|
      if recipe.quantity > recipe.food.quantity
        food_name = recipe.food.name
        food_quantities[food_name] += recipe.quantity - recipe.food.quantity
      end
    end

    food_quantities.each do |food_name, total_quantity|
      @recipe_foods << { food_name: food_name, total_quantity: total_quantity }
    end
  end
end
