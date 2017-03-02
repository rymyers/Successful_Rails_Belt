class Group < ActiveRecord::Base
    validates :name, :info, :members, :owner, presence: true
    validates :name, :info, uniqueness: true
    validates :name, length: 5..30
    validates :info, length: 10..100
    has_many :member, dependent: :destroy  
end
