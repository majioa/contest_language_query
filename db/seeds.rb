# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'json'

data = JSON.parse( IO.read( 'db/seeds/data.json' ) )
data.each do |h|
   language = Language.create name: h[ 'Name' ]
   h[ 'Type' ].split( /,\s+/ ).each do |type_name|
      language.language_types << LanguageType.find_or_create_by( name: type_name )
   end
   h[ 'Designed by' ].split( /,\s+/ ).each do |author_name|
      language.authors << Author.find_or_create_by( name: author_name )
   end
end
