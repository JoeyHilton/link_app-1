class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  belongs_to :user
  validates_format_of :url, :with => URI::regexp(%w(http https))

end
