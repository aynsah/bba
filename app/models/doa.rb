class Doa < ApplicationRecord
  belongs_to :user
  belongs_to :doa_status  

  def self.update_status(current_status, id_doa)
    puts current_status
    doa = Doa.find(id_doa)
    doa.update(current_status)

    return Doa.all.order(created_at: :desc)
  end

end
