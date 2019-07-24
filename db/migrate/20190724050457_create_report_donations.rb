class CreateReportDonations < ActiveRecord::Migration[5.2]
  def change
    create_table :report_donations do |t|

      t.timestamps
    end
  end
end
