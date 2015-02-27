class Author < ActiveRecord::Base
  has_and_belongs_to_many :languages, join_table: :languages_authors

  scope :by_tokens, ->(tokens) { where name: tokens }
end
