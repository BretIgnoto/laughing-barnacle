class Borrower < ActiveRecord::Base
	has_one :user, :as => :userable
	after_initialize :init

    def init
      self.raised  ||= 0          
    end
end
