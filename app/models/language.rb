class Language < ActiveRecord::Base
  has_and_belongs_to_many :authors, join_table: :languages_authors
  has_and_belongs_to_many :language_types, join_table: :languages_language_types

  scope :by_tokens, ->(tokens) {
    permuted = tokens.map do |t|
      t.split( /\s+/ ).permutation.map {|tt| tt.join( ' ' ) }
    end.flatten
    where name: permuted
  }
end
