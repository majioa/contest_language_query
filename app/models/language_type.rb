class LanguageType < ActiveRecord::Base
  extend App::TokenSupport

  has_and_belongs_to_many :languages, join_table: :languages_language_types

  scope :by_tokens, ->( tokens ) { scope_by_token( tokens ) }
end
