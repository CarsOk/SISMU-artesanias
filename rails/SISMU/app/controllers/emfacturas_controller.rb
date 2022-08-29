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
    respond_to do |format|
      format.html
      format.pdf do
        render template: "emfacturas/factura", pdf: "factura empresas-#{@emfactura.id}" ,layout:"pdf" # Excluding ".pdf" extension.
      end
    end
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
      
    if current_user.has_role? :perla
          @emfacturas = Emfactura.joins(:empresa).where("nombre = 'cuatro perlas'")

          
        elsif current_user.has_role? :kate
          @emfacturas = Emfactura.joins(:empresa).where("nombre = 'kate wriGle'")
          
          
        elsif current_user.has_role? :aida
          @emfacturas = Emfactura.joins(:empresa).where("nombre = 'Aída furmasky'")
          
          
        elsif current_user.has_role? :mito
          @emfacturas = Emfactura.joins(:empresa).where("nombre = 'Mito-Caly'")
          
          
        end
        
        if current_user.has_role? :admin
          @q = @emfacturas.ransack(params[:q])
          @emfacturas = if params[:q]
            @emfacturas= @q.result(distinct: true).paginate(:per_page => 20, :page => params[:page])  
            else
              @emfacturas = Emfactura.search(params[:search]).paginate(:per_page => 20, :page => params[:page])
            end

        elsif current_user.has_any_role? :mito, :perla, :kate, :aida

          @q = @emfacturas.ransack(params[:q])
          @emfacturas= @q.result(distinct: true).paginate(:per_page => 20, :page => params[:page])  
      
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
    params.require(:emfactura).permit(:empresa_id, :fechafin, :emfref)
  end

  def set_emfactura
    @emfactura = Emfactura.find(params[:id])
  end
end
