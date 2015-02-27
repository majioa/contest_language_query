class CreateLanguagesAuthors < ActiveRecord::Migration
  def change
    create_table :languages_authors, id: false do |t|
      t.belongs_to :language, index: true
      t.belongs_to :author, index: true
    end
    add_index :languages_authors, [ :language_id, :author_id ],
       name: :languages_authors_index,
       unique: true
  end
end
