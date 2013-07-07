class CreateTranslationCenterTranslations < ActiveRecord::Migration
  def change
    create_table :translation_center_translations do |t|
      t.integer :translation_key_id
      t.text :value
      t.string :lang
      t.references :translator, polymorphic: true
      t.string :status, default: 'pending'

      t.timestamps
    end

    add_index :translation_center_translations, :translation_key_id
  end
end
