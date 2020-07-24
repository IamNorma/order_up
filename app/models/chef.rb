class Chef <ApplicationRecord
  validates_presence_of :name
  has_many :dishes

  def unique_ingredients
    ingredients = dishes.select('ingredients.name').joins(:ingredients).distinct
    #should not be using ruby here. Need to use pluck somehow
    unique = ingredients.map do |ingredient|
      ingredient.name
    end
    unique
  end
end
