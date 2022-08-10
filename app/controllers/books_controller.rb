class BooksController < ApplicationController

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @user = current_user
    @book_new = Book.new
    @book_comment = BookComment.new
    
    @book_detail = Book.find(params[:id])
    unless ViewCount.find_by(user_id: current_user.id, book_id: @book_detail.id)
      current_user.view_counts.create(book_id: @book_detail.id)
    end
    
  end

  # def index
  #   to  = Time.current.at_end_of_day
  #   from  = (to - 6.day).at_beginning_of_day
  #   @books = Book.includes(:favorited_users).
  #     sort {|a,b| 
  #       b.favorited_users.includes(:favorites).where(created_at: from...to).size <=> 
  #       a.favorited_users.includes(:favorites).where(created_at: from...to).size
  #     }
  #   @book = Book.new
  # end
  def index
    @users = User.all
    to  = Time.current.at_end_of_day
    from  = (to - 6.day).at_beginning_of_day
    @books = Book.all.sort {|a,b| 
      b.favorites.where(created_at: from...to).size <=> 
      a.favorites.where(created_at: from...to).size
    }
    @book = Book.new
  end


  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book.id), notice: "You have created book successfully."
    else
      @books = Book.all
      
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def delete
    @book = Book.find(params[:id])
    @book.destoy
    redirect_to books_path
  end
  
  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to '/books'
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
