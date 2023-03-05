class BooksController < ApplicationController

  def show
    @books = Book.new
    @book = Book.find(params[:id])
    impressionist(@book, nil, unique: [:ip_address])
    @user = @book.user
    @post_comment = PostComment.new
  end

  def index
    to  = Time.current.at_end_of_day
    from  = (to - 6.day).at_beginning_of_day
    @books = Book.all.sort {|a,b| 
      b.favorites.where(created_at: from...to).size <=> 
      a.favorites.where(created_at: from...to).size
    }
    @book_new = Book.new
    @user = current_user
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @user = current_user
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
  
  # def rank
    # @books = Book.last_week
  # end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
  
  def editing_user
    book = Book.find(params[:id])
    if book.user != current_user
      redirect_to books_path
    end
  end
end
