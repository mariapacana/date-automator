class Crush < ActiveRecord::Base
  has_many :exchanges
  belongs_to :user
  belongs_to :phone

  validates_presence_of :first_name, :last_name, :phone, :status
  validates_uniqueness_of :phone_id, :scope => :user_id
  validate :status_must_be_valid

  VALID_STATUS = ["not contacted", "contacted", "not interested", "date scheduled"]

  def status_must_be_valid
    errors.add(:status, "must be valid") if !VALID_STATUS.include?(status)
  end

end
