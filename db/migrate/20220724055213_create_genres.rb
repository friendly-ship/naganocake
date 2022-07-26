class CreateGenres < ActiveRecord::Migration[6.1]
  def change
    create_table :genres do |t|
      t.string :name
      t.boolean :is_genres_status,default: true
      t.timestamps
    end
    #:boolean, :default: fales, null: fales
  end
end
