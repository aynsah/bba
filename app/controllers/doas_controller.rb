class DoasController < ApplicationController
  before_action :find_doa, only: [:show, :edit, :update, :destroy]
  def index
    @doas = Doa.all
  end

  def show
  end

  def new
    @doa = Doa.new
  end

  def create
    @doa = Doa.new(doa_params)
    @doa.save
    redirect_to doas_path
  end

  def edit
  end

  def update
    @doa.update(campaign_params)
    redirect_to campaigns_path
  end

  private
    def find_doa
      if Doa.exists?(params[:id])
       @doa = Doa.find(params[:id])
      end
    end

    def doa_params
      params.require(:doa).permit(:title, :doa, :doa_desc, :expired_at, :user_id)
    end
end
