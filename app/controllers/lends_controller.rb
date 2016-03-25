class LendsController < ApplicationController
  def lender
  	@lender = User.joins('LEFT JOIN lenders ON lenders.id = userable_id').select("*").find(params[:id])
  	@borrowers = User.joins('INNER JOIN borrowers on borrowers.id = userable_id').select("*").where(userable_type:"borrower")
  	@loaned = Lend.joins('INNER JOIN borrowers on borrowers.id = borrower_id').joins("INNER JOIN users on users.userable_id = borrowers.id").select("*").where(lender_id: @lender.id)
  end

  def borrower
  	@borrower = User.joins('LEFT JOIN borrowers ON borrowers.id = userable_id').select("*").find(params[:id])
  	@loaned = Lend.joins('INNER JOIN lenders on lenders.id = lender_id').joins("INNER JOIN users on users.userable_id = lenders.id").select("*").where(borrower_id: @borrower.id)
  end
  def lend
  	lender = User.joins('LEFT JOIN lenders ON lenders.id = userable_id').select("*").find(session[:user_id])
  	if lender.money.to_i > params[:amount].to_i
  		if Lend.where(lender_id: lender.id, borrower_id:params[:id]).empty?
			Lend.create(lender_id: lender.id, borrower_id: params[:id], amount: params[:amount])
		else
			loan = Lend.find_by(lender_id:session[:user_id], borrower_id:params[:id])
			loan.update(amount: loan.amount + params[:amount])
		end
		lends = Lender.find(lender.userable_id)
		lends.update(money: lends.money-params[:amount].to_i)
		borrower = Borrower.find(params[:id])
		borrower.update(raised: borrower.raised+params[:amount].to_i)
	else
		flash[:errors] = ["Insufficient Funds"]
	end
	redirect_to "/lender/#{session[:user_id]}"  	
  end
end

