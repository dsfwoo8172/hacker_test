class CreateVotes < ActiveRecord::Migration[7.0]
  def change
    create_table :votes do |t|
      t.belongs_to :voteable, polymorphic: true
      t.references :user, null: false, foreign_key: true
      t.boolean :upvote, default: false

      t.timestamps
    end
  end
end
