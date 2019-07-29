class Doa < ApplicationRecord
  belongs_to :user
  belongs_to :doa_status  

  def self.update_status(current_status, id_doa, user_id)
    doa = Doa.find(id_doa)
    doa.update(current_status)

    return Doa.where("user_id = ?", user_id).order(created_at: :desc)
  end

end
