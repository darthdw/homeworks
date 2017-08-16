class Person < ActiveRecord::Base
  validates :name, presence:true, uniqueness:true
  validates :house_id, presence:true
  belongs_to(
    :house,
    class_name: 'House',
    foreign_key: :house_id,
    primary_key: :id
  )
end