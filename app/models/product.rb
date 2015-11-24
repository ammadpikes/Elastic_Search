class Product < ActiveRecord::Base

  # --------- Validations --------- #

  validates :name, presence: true
  validates :description, presence: true
  validates :photo, presence: true

  # --------- Paperclip Image Upload --------- #

  has_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "150x150>" }
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/

  # ---------  Elastic Search --------- #

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  mappings dynamic: 'false' do
    indexes :name, type: 'string'
    indexes :price, type: 'integer'
    indexes :description, type: 'text'
  end


end
