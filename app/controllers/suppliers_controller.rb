class SuppliersController < ApplicationController
	before_action :set_supplier, only: [:show, :edit, :update, :destroy]

  # GET /suppliers
  # GET /suppliers.json
  def index
    @suppliers = Supplier.order('name ASC').all
  end

  # GET /suppliers/1
  # GET /suppliers/1.json
  def show
  end

  # GET /suppliers/new
  def new
    @supplier = Supplier.new
  end

  # GET /suppliers/1/edit
  def edit
  end

  # POST /suppliers
  # POST /suppliers.json
  def create
    @supplier = Supplier.new(supplier_params)

    if Supplier.exists?(name: @supplier.name)

      pro = Supplier.find_by(name: @supplier.name)
      @ReportSupplier = ReportSupplier.new(supplier_params)
      @ReportSupplier.save

      respond_to do |format|
        format.html { redirect_to suppliers_path, notice: 'supplier was successfully updated.' }
      end

    else

      @supplier = Supplier.new(supplier_params)
      @ReportSupplier = ReportSupplier.new(supplier_params)
  
      respond_to do |format|
        if @supplier.save && @ReportSupplier.save
          format.html { redirect_to @supplier, notice: 'supplier was successfully created.' }
        else
          format.html { render :new }
        end
      end
    end
  end

  # PATCH/PUT /suppliers/1
  # PATCH/PUT /suppliers/1.json
  def update
    respond_to do |format|
      if @supplier.update(supplier_params)
        format.html { redirect_to @supplier, notice: 'supplier was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /suppliers/1
  # DELETE /suppliers/1.json
  def destroy
    @supplier.destroy
    respond_to do |format|
      format.html { redirect_to suppliers_url, notice: 'supplier was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_supplier
      @supplier = supplier.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def supplier_params
      params.require(:supplier).permit(:name, :country)
    end
end
