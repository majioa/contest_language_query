class CreateLanguageTypes < ActiveRecord::Migration
  def change
    create_table :language_types do |t|

      t.timestamps
    end
  end
end
