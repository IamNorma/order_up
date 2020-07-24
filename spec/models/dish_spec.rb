require 'rails_helper'

RSpec.describe Dish, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :description}
  end
  describe "relationships" do
    it {should belong_to :chef}
  end

  describe "methods" do
    it '#total_calories' do
      jackie = Chef.create!(name: "Jackie Casas")
      ravioli = jackie.dishes.create!(name: "Ravioli", description: "Spinach and cheese ravioli.")
      cheese = Ingredient.create!(name: "Cheese", calories: 85)
      spinach = Ingredient.create!(name: "Spinach", calories: 30)
      pasta = Ingredient.create!(name: "Pasta", calories: 120)

      DishIngredient.create!(dish: ravioli, ingredient: cheese)
      DishIngredient.create!(dish: ravioli, ingredient: spinach)
      DishIngredient.create!(dish: ravioli, ingredient: pasta)

      expect(ravioli.total_calories).to eq(235)
    end
  end
end
