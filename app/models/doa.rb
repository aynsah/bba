class Doa < ApplicationRecord
  belongs_to :user
  belongs_to :doa_status  

  def self.update_status(current_status, id_doa)
    doa = Doa.find(id_doa)
    doa.update(:doa_status_id => current_status)

    return Doa.all
  end

end
