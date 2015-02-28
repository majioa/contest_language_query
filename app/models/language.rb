class Language < ActiveRecord::Base
  extend App::TokenSupport

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

  scope :by_tokens_with_relations, ->( tokens ) {
    # we get the complex query of relations
    ext = by_author_tokens( tokens ).merge( by_language_type_tokens( tokens ))
    # collect wheres from relation, and add ORed from `self.by_tokens`
    wheres = ext.where_values.reduce {|s,v| s.and(v) }
            .or( by_tokens( tokens ).where_values.reduce {|s,v| s.and(v) } )
    # convert inner joins to outer
    join = ext.arel.join_sources.reduce( arel_table ) do |s,v|
      s.join( v.entries[ 1 ], Arel::Nodes::OuterJoin ).on( v.right.expr )
    end
    # convert managed query to ActiveRecord::Relation
    joins( join.join_sources ).where( wheres ).uniq
  }

end
