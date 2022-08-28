class Emfactura < ApplicationRecord
  belongs_to :empresa

  has_many :emdetalles, dependent: :destroy
  has_many :productos, through: :emdetalles
  validates_associated :empresa
  def final
    emdetalles.sum(&:valor)
  end
  def iva
    self.final*0.19
  end
  def final_total
    self.final + self.iva
  end
  def self.search(search)
    if search
      
      includes(:empresa).where( ["id LIKE  ? or nombre LIKE?","%#{search}%","%#{search}%"]).references(:empresa)
    else
        unscoped
    end
  end
end
