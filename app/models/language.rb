class Language < ActiveRecord::Base
  extend App::TokenSupport

  has_and_belongs_to_many :authors, join_table: :languages_authors
  has_and_belongs_to_many :language_types, join_table: :languages_language_types

  scope :by_token, ->( token ) { find_by_token( token ) }

  scope :by_author_token, ->( token ) {
    cross_find_by_token( token, self, Author, :languages_authors )
  }

  scope :by_language_type_token, ->( token ) {
    cross_find_by_token( token, self, LanguageType, :languages_language_types )
  }

  scope :by_tokens_with_relations, ->( tokens ) {
    # enumerate method names to try search in
    symbols = [ :by_author_token, :by_language_type_token, :by_token ]

    # enumerate token list to check at first positive value, then negative
    # then merge resulted queries
    token_lists = separate_tokens( tokens ).reduce( {} ) do |q,tokens|
      q.merge( catch_query( symbols - q.keys, tokens ) )
    end.map {|(q,res)| res }.reduce( :& ).uniq
  }

end
