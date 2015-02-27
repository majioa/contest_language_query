class Language < ActiveRecord::Base
  has_and_belongs_to_many :authors, join_table: :languages_authors
  has_and_belongs_to_many :language_types, join_table: :languages_language_types

  scope :by_tokens, ->(tokens) {
    permuted = tokens.map do |t|
      t.split( /\s+/ ).permutation.map {|tt| tt.join( ' ' ) }
    end.flatten
    where name: permuted
  }

  scope :by_author_tokens, ->( tokens ) {
    joins(:authors).merge(Author.by_tokens( tokens ) )
  }

  scope :by_language_type_tokens, ->( tokens ) {
    joins(:language_types).merge(LanguageType.by_tokens( tokens ) )
  }
end
