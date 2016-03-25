class UsersController < ApplicationController
  	def index
  	end
  	def lender
  		lender = Lender.new(money: params[:money])
		if lender.save
			user = User.new(fname: params[:fname], lname: params[:lname], email: params[:email], password: params[:password], userable_id: Lender.last.id, userable_type: "lender")
			if user.save
				session[:user_id] = User.last.id
				redirect_to "/lender/#{session[:user_id]}"
			else
				flash[:errors] = user.errors.full_messages
				redirect_to :root	
			end		
		else
			flash[:errors] = user.errors.full_messages
			redirect_to :root
		end	
  	end
  	def borrower
  		borrower = Borrower.new(money_for: params[:money_for], reason: params[:reason], needed: params[:needed])
		if borrower.save
			user = User.new(fname: params[:fname], lname: params[:lname], email: params[:email], password: params[:password], userable_id: Borrower.last.id, userable_type: "borrower")
			if user.save
				session[:user_id] = User.last.id
				redirect_to "/borrower/#{session[:user_id]}"
			else
				flash[:errors] = user.errors.full_messages
				redirect_to :root	
			end		
		else
			flash[:errors] = user.errors.full_messages
			redirect_to :root
		end	
  	end
  	def login	
  	end
  	def create
  		user = User.find_by(email:params[:email])
	  	if user && user.authenticate(params[:password])
	  		session[:user_id] = user.id
	  		redirect_to "/#{user.userable_type}/#{user.id}"
	  	else
	  		flash[:errors] = ["Invalid email/password"]
	  		redirect_to '/login'
	  	end
  	end
  	def logout
  		session[:user_id] = nil
  		redirect_to :root
  	end
end
