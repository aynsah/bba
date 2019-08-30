class Doa < ApplicationRecord
  belongs_to :user
  belongs_to :doa_status  

  validates :title, presence: {message: "tidak boleh kosong"}
  validates :doa, presence: {message: "tidak boleh kosong"}

  def self.update_status(current_status, id_doa, user_id)
    doa = Doa.find(id_doa)
    doa.update(current_status)

    return Doa.where("user_id = ?", user_id).order(created_at: :desc)
  end

  def self.filter(doa_filter)
    if doa_filter
      return where('doa_status_id = ?', doa_filter)
    else
      return all
    end
  end
end
