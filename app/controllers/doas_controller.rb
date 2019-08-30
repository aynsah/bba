class DoasController < ApplicationController
  before_action :find_doa, only: [:show, :edit, :update, :destroy]
  before_action :check_doa_status, only: [:create]

  def index
    if current_user
      display_all_doas
      respond_to do |format|
        format.js
        format.html
      end
    else
      redirect_to new_user_session_path
    end
  end
  
  def change_status
    if @doas = Doa.update_status(
                    params.require(change_status_path).permit(:doa_status_id), 
                    params[:id], 
                    current_user.id
                  )
    
      @statuses = DoaStatus.all
      respond_to do |format|
        format.js { render :action => "index" }
        format.html
      end
    end
  end

  def destroy
    @doa.destroy
    display_all_doas
    respond_to do |format|
      format.js { render :action => "index" }
      format.html
    end
  end

  def show
    only_user_and_admin @doa
  end

  def new
    redirect_to new_user_session_path unless current_user
    @doa = Doa.new
  end

  def create
    @doa = Doa.new(doa_params)
      if @doa.save
        redirect_to( doas_path, 
                     notice: 'Doa berhasil tersimpan'
                    )
      else 
        @doa.valid?
        flash[:alert] = @doa.errors.full_messages[0]
        render :action => :new
      end
  end

  def edit
    only_user_and_admin @doa
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

    def display_all_doas
      @doas = Doa.filter(params[:doa_filter])
                 .where("user_id = ?", "#{current_user.id}")
                 .order(created_at: :desc)

      @statuses = DoaStatus.all
    end

    def check_doa_status
      DoaStatus.new(:id => 1,:status_name => "Berjalan").save unless DoaStatus.any?
    end
end
