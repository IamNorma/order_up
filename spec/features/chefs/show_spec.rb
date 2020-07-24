require 'rails_helper'

RSpec.describe 'Chef show page' do
  it 'displays chef name, link for each ingredient' do
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

    visit "chefs/#{jackie.id}"

    expect(page).to have_content("Jackie Casas")
    expect(page).to have_link("All ingredients used by #{jackie.name}")

    click_on "All ingredients used by #{jackie.name}"

    expect(current_path).to eq("/chefs/#{jackie.id}/ingredients")

    expect(page).to have_content("Cheese")
    expect(page).to have_content("Spinach")
    expect(page).to have_content("Pasta")
    expect(page).to have_content("Tortilla")
  end
end
