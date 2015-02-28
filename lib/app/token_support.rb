module App::TokenSupport
  def scope_by_token tokens
    tokens_pos = tokens.select {|t| t =~ /^[^-]/ }
    tokens_neg = ( tokens - tokens_pos ).map {|t| t[1..-1] }

    # selector for positive and negative tokens
    if tokens.empty?
      all
    elsif tokens_neg.empty?
      where( name: tokens_pos )
    elsif tokens_pos.empty?
      where.not( name: tokens_neg )
    else
      where( arel_table[ :name ].in( tokens_pos )
        .or( arel_table[ :name ].not_in( tokens_neg ) ) )
    end
  end
end
