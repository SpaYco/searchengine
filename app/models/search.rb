class Search < ApplicationRecord
  validates :query, presence: true
  validates :query, length: { minimum: 3, maximum: 50 }

  def searched?(search)
    jarow = FuzzyStringMatch::JaroWinkler.create( :native )
    similarity_percentage = jarow.getDistance(search, self.query)
    return similarity_percentage > 0.8 ? true : false
  end


end
