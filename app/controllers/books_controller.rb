class BooksController < ApplicationController
  before_action :find_book, except: %i(index new create)

  def index
    @books = Book.ordered.paginate page: params[:page],
      per_page: Settings.book.per_page
  end

  def new
    @book = Book.new
  end

  def show; end

  def create
    @book = Book.new book_params
    if @book.save
      flash[:success] = t "book.created"
      redirect_to books_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @book.update book_params
      flash[:success] = t "book.edited"
      redirect_to book_path(@book)
    else
      render :edit
    end
  end

  def destroy
    if @book.destroy
      flash[:success] = t "book.delete_book"
      redirect_to books_path
    else
      flash[:danger] = t "book.unsuccessfully_delete"
      redirect_to root_path
    end
  end

  private

  def book_params
    params.require(:book).permit :title, :content, :category_id, :author,
      :quanlity, :book_img
  end

  def find_book
    @book = Book.find_by id: params[:id]
    return if @book
    flash[:danger] = t "no_data"
    redirect_to root_path
  end
end
