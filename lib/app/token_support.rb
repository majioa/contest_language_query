module App::TokenSupport
  def ids_by_token token
    ( neg, plain ) = observe_token( token )
    ids = where( arel_table[ :name ].matches( "%#{plain}%" ) ).map( &:id )
    [ neg, ids ]
  end

  def model_symbol_id model
    "#{model}".underscore << '_id'
  end

  def observe_token token
    token =~ /^-/ && [ true, token[1..-1] ] || [ nil, token ]
  end

  def separate_tokens tokens
    tokens_pos = tokens.select {|t| t =~ /^[^-]/ }
    [ tokens_pos, tokens - tokens_pos ]
  end

  def find_by_token token
    ( neg, plain ) = observe_token( token )

    # selector for positive and negative masks
    if neg
      where.not( arel_table[ :name ].matches( "%#{plain}%" ) )
    else
      where( arel_table[ :name ].matches( "%#{plain}%" ) )
    end
  end

  def cross_find_by_token token, model, cross_model, cross_table_name
    ( neg, tids ) = cross_model.ids_by_token( token )

    # open cross table, and define require ids '..._id'
    cross_t = Arel::Table.new( cross_table_name )
    cross_model_id_symbol = model_symbol_id cross_model
    model_id_symbol = model_symbol_id model

    # generate SQL from cross ids
    sql = cross_t.where( cross_t[ cross_model_id_symbol ].in( tids ) )
                 .project( cross_t[ model_id_symbol ]).to_sql
    ids = ActiveRecord::Base.connection.execute( sql ).map do |x|
      x[ model_id_symbol ]
    end

    # create Active Relation object, with calling negated of positive version
    # of id selectors
    model.where( model.arel_table[ :id ].send( neg && :not_in || :in, ids ) )
  end

  def wheres_any *scopes
    init = scopes.shift.where_values.reduce {|s,v| s.and(v) }
    scopes.reduce( init ) do |s,v|
      s.or( v.where_values.reduce {|s,v| s.and(v) } )
    end
  end

  def catch_query symbols, tokens
    symbols.reduce( {} ) do |queries, query_sym|
      next if queries.key?( query_sym )
      tokens = tokens.reject do |t|
        q = send( query_sym, t )
        queries[ query_sym ] = q if q.count > 0 
      end
      queries
    end
  end

end
