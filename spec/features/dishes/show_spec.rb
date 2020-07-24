require 'rails_helper'

RSpec.describe 'Dish show page' do
  it 'displays list of ingredients and chef name' do
    jackie = Chef.create!(name: "Jackie Casas")
    ravioli = jackie.dishes.create!(name: "Ravioli", description: "Spinach and cheese ravioli.")
    cheese = Ingredient.create!(name: "Cheese", calories: 85)
    spinach = Ingredient.create!(name: "Spinach", calories: 30)
    pasta = Ingredient.create!(name: "Pasta", calories: 120)

    DishIngredient.create!(dish: ravioli, ingredient: cheese)
    DishIngredient.create!(dish: ravioli, ingredient: spinach)
    DishIngredient.create!(dish: ravioli, ingredient: pasta)

    visit "dishes/#{ravioli.id}"

    expect(page).to have_content("Cheese")
    expect(page).to have_content("Spinach")
    expect(page).to have_content("Pasta")
    expect(page).to have_content("Jackie Casas")
  end

  it 'displays total calorie count for dish' do
    jackie = Chef.create!(name: "Jackie Casas")
    ravioli = jackie.dishes.create!(name: "Ravioli", description: "Spinach and cheese ravioli.")
    cheese = Ingredient.create!(name: "Cheese", calories: 85)
    spinach = Ingredient.create!(name: "Spinach", calories: 30)
    pasta = Ingredient.create!(name: "Pasta", calories: 120)

    DishIngredient.create!(dish: ravioli, ingredient: cheese)
    DishIngredient.create!(dish: ravioli, ingredient: spinach)
    DishIngredient.create!(dish: ravioli, ingredient: pasta)

    visit "dishes/#{ravioli.id}"

    expect(page).to have_content("Total Calories: 235")
  end
end
