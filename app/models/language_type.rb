class LanguageType < ActiveRecord::Base
  has_and_belongs_to_many :languages, join_table: :languages_language_types
end
