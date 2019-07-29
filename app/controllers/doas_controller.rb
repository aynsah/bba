class DoasController < ApplicationController
  before_action :find_doa, only: [:show, :edit, :update, :destroy]
  def index
    @statuses = DoaStatus.all
    @doas = Doa.where("user_id = ?", "#{current_user.id}").order(created_at: :desc)
  end
  
  def change_status()
    if @doas = Doa.update_status(params.require(change_status_path).permit(:doa_status_id), params[:id], current_user.id)
      @statuses = DoaStatus.all
      respond_to do |format|
        format.js
        format.html
      end
    end
  end


  def show
  end

  def new
    @doa = Doa.new
  end

  def create
    @doa = Doa.new(doa_params)
    @doa.validate!
    @doa.save
    redirect_to doas_path
  end

  def edit
  end

  def update
    @doa.update(doa_params)
    redirect_to doas_path
  end

  private
    def find_doa
      if Doa.exists?(params[:id])
       @doa = Doa.find(params[:id])
      else
        redirect_to root_path
      end
    end

    def doa_params
      params.require(:doa).permit(:title, :doa, :doa_desc, :expired_at, :user_id)
    end
end
