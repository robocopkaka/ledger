class TransactionsController < ApplicationController
  def new
  	@transaction = Transaction.new
  end

  def create
  	@transaction = Transaction.new(transaction_params)
  	respond_to do |format|
  		if @transaction.save
  			format.html{redirect_to @transaction}
			format.json{render :show, status: :created, location: @transaction}
		else
			format.html{render :new}
			format.json{render json: @transaction.errors, status: :unprocessible_entity}
  		end
  	end
  end

  def edit
  	@transaction = Transaction.find_by_id(params[:id])
  end

  def update
  	@transaction = Transaction.find_by_id(params[:id])

  	respond_to do |format|
  		if @transaction.update_attributes(transaction_params)
  			redirect_to @transaction
  		else
  			render 'edit'
  		end
  	end
  end

  def show
  	@transaction = Transaction.find_by_id(params[:id])
  end

  def index
  	@transactions = Transaction.all
  end

  def expense
  	@expenses = Transaction.where("transaction_type LIKE ?", "expenses")
  end

  def income
  	@incomes = Transaction.where("transaction_type LIKE ?", "income")
  end

  private

  def transaction_params
  	params.require(:transaction).permit(:amount, :narration,:transaction_type)
  end
end
