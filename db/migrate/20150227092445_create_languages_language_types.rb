class CreateLanguagesLanguageTypes < ActiveRecord::Migration
  def change
    create_table :languages_language_types, id: false do |t|
      t.belongs_to :language, index: true
      t.belongs_to :language_type,  index: true
    end
    add_index :languages_language_types, [ :language_id, :language_type_id ],
       name: :languages_language_types_index,
       unique: true
  end
end
