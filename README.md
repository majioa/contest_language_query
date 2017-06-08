## Language searcher

The project uses ruby 2.2.3, so compile it woth openssl, and libz libraries. Also the libv8 be required on bundle.

1. bundle the project

        bundle

1. Run tests:

        RAILS_ENV=test rake db:create db:migrate db:seed

        rake spec

1. Create db and seed seed the data:

        RAILS_ENV=production rake db:create db:migrate db:seed

1. Rub the server:

        RAILS_ENV=production rails s

1. Visit main page, and try.
