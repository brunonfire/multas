class Company < ApplicationRecord
  belongs_to :city
  belongs_to :created_by, class_name: "User", foreign_key: :created_by

  has_many :branches, class_name: "Company", foreign_key: :company_id

  enum company_type: [:main, :branch]

  validates :name, presence: true, uniqueness: true
  validates :cnpj,:phone,:zipcode, presence: true


end
