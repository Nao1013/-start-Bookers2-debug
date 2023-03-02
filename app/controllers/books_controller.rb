class BooksController < ApplicationController

  def show
    @books = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
    @post_comment = PostComment.new
  end

  def index
    @books = Book.all
    @book_new = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
    user = @book.user
    unless user == current_user
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    @user = @book.user
    if @book.update(book_params)
      redirect_to book_path(@book.id), notice: "You have updated book successfully."
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
