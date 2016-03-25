class Lender < ActiveRecord::Base
	has_one :user, :as => :userable
	has_many :lends
end
