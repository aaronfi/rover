class CreateInitialSchemas < ActiveRecord::Migration
    def change
        enable_extension 'hstore'

        ## Here are all the Rails 4 (ActiveRecord migration) datatypes:
        #
        # :binary
        # :boolean
        # :date
        # :datetime
        # :decimal
        # :float
        # :integer
        # :primary_key
        # :references
        # :string
        # :text
        # :time
        # :timestamp
        #
        # If you use PostgreSQL, you can also take advantage of these:
        #
        # :hstore
        # :json
        # :array
        # :cidr_address
        # :ip_address
        # :mac_address
        #
        # Source: http://api.rubyonrails.org/classes/ActiveRecord/ConnectionAdapters/TableDefinition.html#method-i-column

        # Because you've been manually editing this initial migrations file by hand, instead of creating a new migration
        # file for each change you want to try out, here are the steps you need to take to get your schema changes
        # in this file to actually be applied to the database:  (Rails, by default, doesn't replay all migrations, it just
        # uses the latest snapshot in schema.rb)
        #
        # (1) rm ~/code/gobblebreak/rails/db/schema.rb
        # (2) rake db:reset
        #
        # See http://stackoverflow.com/questions/10301794/difference-between-rake-dbmigrate-dbreset-and-dbschemaload

        create_table :users do |t|
            t.string :name
            t.string :email
            t.string :phone_number
            t.string :image_url

            t.timestamps
        end

        create_table :dogs do |t|
            t.string :name
            t.integer :owner_id, index: true, foreign_key: true

            t.timestamps
        end
        add_foreign_key :dogs, :users, column: :owner_id

        create_table :sittings do |t|
            t.string :start_date  # NOTE(aaronfi@) should be t.datetime, but your sample datetime data is unclear to me.
            t.string :end_date
            t.integer :sitter_id, index: true, foreign_key: true
            t.integer :owner_id, index: true, foreign_key: true

            t.timestamps
        end
        add_foreign_key :sittings, :users, column: :sitter_id
        add_foreign_key :sittings, :users, column: :owner_id

        create_join_table :sittings, :dogs

        create_table :reviews do |t|
            t.references :sitting, index: true
            t.text :review_text
            t.integer :review_rating

            t.timestamps
        end

        add_index :users, :email, :unique => true
    end
end

