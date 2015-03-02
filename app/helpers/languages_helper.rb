module LanguagesHelper
  def tokenize string
    # open quotes
    unquoted = string.strip.split( /\s*"\s*/ )
    # split each unquoted token by a space (each odd)
    unquoted.map.with_index do |u, i|
      ( i % 2 == 0 ) && u.split( /\s+/ ) || u
    end.flatten.delete_if {|t| t.empty? }
  end

  def types language
    language.language_types.map( &:name ).join( ', ' )
  end

  def authors language
    language.authors.map( &:name ).join( ', ' )
  end
end
