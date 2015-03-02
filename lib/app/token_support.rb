module App::TokenSupport
  def find_by_masks tokens
    where( arel_table[ :name ].matches_any( tokens ) )
  end

  def find_by_not_masks tokens
    where.not( arel_table[ :name ].matches_all( tokens ) )
  end

  def find_by_tokens tokens, merge = false
    tokens_pos = tokens.select {|t| t =~ /^[^-]/ }
    masks_pos = tokens_pos.map {|t| "%#{t}%" }
    masks_neg = ( tokens - tokens_pos ).map {|t| "%#{t[1..-1]}%" }

    # selector for positive and negative masks
    if tokens.empty?
      all
    elsif masks_neg.empty?
      find_by_masks( masks_pos )
    elsif masks_pos.empty?
      find_by_not_masks( masks_neg )
    else
      if merge
        # join by method AND
        find_by_masks( masks_pos ).merge( find_by_not_masks( masks_neg ) )
      else
        # joins by method OR
        scopes = [ find_by_masks( masks_pos ), find_by_not_masks( masks_neg ) ]
        where( wheres_any( *scopes ) )
      end
    end
  end

  def wheres_any *scopes
    init = scopes.shift.where_values.reduce {|s,v| s.and(v) }
    scopes.reduce( init ) do |s,v|
      s.or( v.where_values.reduce {|s,v| s.and(v) } )
    end
  end
end
