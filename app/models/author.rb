class Author < ActiveRecord::Base
  extend App::TokenSupport

  has_and_belongs_to_many :languages, join_table: :languages_authors

  scope :by_tokens, ->( tokens ) { find_by_tokens( tokens ) }

  scope :ids_by_tokens, ->( tokens ) {
    arel_table.project( arel_table[:id] )
              .where( by_tokens( tokens ).where_values )
  }
end
