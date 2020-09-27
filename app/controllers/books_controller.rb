class BooksController < ApplicationController
 before_action :authenticate_user!

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
     if @book.save
       flash[:notice] = 'You have created book successfully.'
       redirect_to book_path(@book)
     else
       @books = Book.all
       @user = current_user
       @book = Book.new
       flash[:notice] = 'error'
       render :index
     end
  end

  def index
    @book = Book.new
    @books = Book.all
    @user= current_user
  end

  def show
    @book_new = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def edit
    @book = Book.find(params[:id])
    @user = User.find(@book.user_id)
    if @user.id != current_user.id
     redirect_to books_path
    end

  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book)
    else
      flash[:notice] = "error"
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.delete
    flash[:destroy] = 'You have destroyed book successfully.'
    redirect_to books_path
  end

  private
  def book_params
    params.require(:book).permit(:title, :body, :user_id)
  end
end
