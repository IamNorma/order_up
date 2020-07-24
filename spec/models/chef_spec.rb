require 'rails_helper'

RSpec.describe Chef, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
  end
  describe "relationships" do
    it {should have_many :dishes}
  end
  describe "methods" do
    it '#unique_ingredients' do
      jackie = Chef.create!(name: "Jackie Casas")
      ravioli = jackie.dishes.create!(name: "Ravioli", description: "Spinach and cheese ravioli.")
      quesadillia = jackie.dishes.create!(name: "Quesadilla", description: "Best thing ever.")
      cheese = Ingredient.create!(name: "Cheese", calories: 85)
      spinach = Ingredient.create!(name: "Spinach", calories: 30)
      pasta = Ingredient.create!(name: "Pasta", calories: 120)
      tortilla = Ingredient.create!(name: "Tortilla", calories: 80)

      DishIngredient.create!(dish: ravioli, ingredient: cheese)
      DishIngredient.create!(dish: ravioli, ingredient: spinach)
      DishIngredient.create!(dish: ravioli, ingredient: pasta)
      DishIngredient.create!(dish: quesadillia, ingredient: cheese)
      DishIngredient.create!(dish: quesadillia, ingredient: tortilla)

      expect(jackie.unique_ingredients).to eq(["Cheese", "Pasta", "Spinach", "Tortilla"])
    end
  end
end
