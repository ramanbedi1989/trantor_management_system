class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table(:users) do |t|
      t.string :username, null: false
      t.string :ecode
      t.string :name
      t.integer :emp_type_id
      t.integer :designation_id
      t.integer :grade_id
      t.datetime :date_of_joining
      t.integer :manager_id
      t.integer :project_id
      t.string :bu
      t.string :total_exp
      t.string :trantor_exp
      t.string :prior_exp
      t.string :email
      t.integer :confirmation_id
      t.integer :status_id
      t.integer :location_id
      t.string :current_contact
      t.string :emergency_contact_no
      t.datetime :date_of_birth
      t.integer :gender_id
      t.string :blood_group
      t.string :marital_status_id
      t.datetime :marriage_anniv_date
      t.string :pan
      t.string :bank_name
      t.string :bank_ac_no
      t.string :ifsc
      t.string :bank_address
      t.integer :lta_option_id
      t.integer :med_reimb_option_id
      t.string :pf_no
      t.string :esi_no
      t.integer :card_no
      t.boolean :day_shift
      t.boolean :active, default: true
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      t.timestamps
    end

    add_index :users, :username,                unique: true
  end
end
