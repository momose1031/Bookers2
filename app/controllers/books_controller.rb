class BooksController < ApplicationController
  
  def index
    @books = Book.all
    @book = Book.new
    
  end

  def create
    @book = Book.new(book_params)
    @book.use_id = current_user.id
    @book.save
    redirect_to books_path
  end

  def show
  end

  def destroy
  end
  
  private
  
  def book_params
    params.require(:book).permit(:title, :body)
  end
  
end
