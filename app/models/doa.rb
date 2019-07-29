class Doa < ApplicationRecord
  belongs_to :user
  belongs_to :doa_status  

  def self.update_status(current_status, id_doa)
    doa = Doa.find(id_doa)
    doa.update(current_status)

    return Doa.where("user_id = ?", "#{current_user.id}").order(created_at: :desc)
  end

end
