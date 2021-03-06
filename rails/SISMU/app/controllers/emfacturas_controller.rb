class EmfacturasController < ApplicationController
  before_action :authenticate_user!
  before_action :set_emfactura, only: [:show]

  def new
    @emfactura = Emfactura.new
    authorize @emfactura
  end

  def show
    @emdetalles = @emfactura.emdetalles
    authorize @emfactura
    @emdetalle = Emdetalle.new
    @total = @emfactura.emdetalles.sum(:valor)
  end

  def edit
    @emfactura = Emfactura.find(params[:id])
    authorize @emdetalle
  end


  def update
    @emfactura = Emfactura.find(params[:id])
    if @emfactura.update(emfactura_params)
      flash[:notice] = "Se actualizó correctamente."
      redirect_to emfacturas_path
    else
        render :edit
    end
  end

  def index


    @emfacturas = Emfactura.all()

    authorize @emfacturas
    @q = Emfactura.ransack(params[:q])
    
    @emfacturas = if params[:q]
       @q.result(distinct: true).paginate(:per_page => 20, :page => params[:page])  
      else
        Emfactura.search(params[:search]).paginate(:per_page => 20, :page => params[:page])
      end

  end

  def create
    @emfactura = Emfactura.new(emfactura_params)
    if @emfactura.save
      flash[:notice] = "Se creo correctamente."
      redirect_to emfactura_path(@emfactura)
    else
      render :new
    end
  end
def destroy 
  @emfactura = Emfactura.find(params[:id]).destroy
  redirect_to emfacturas_path
end
  private

  def emfactura_params
    params.require(:emfactura).permit(:empresa_id, :fechafin)
  end

  def set_emfactura
    @emfactura = Emfactura.find(params[:id])
  end
end
