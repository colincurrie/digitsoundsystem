class PhotosController < ApplicationController

  GRID_WIDTH = 3

  def index
    @title = 'Gallery'
    @grid = []
    row = 0
    # TODO, limit this before we get too many pictures in the gallery
    photos = Photo.order('created_at desc').to_a
    until photos.empty?
      @grid[row] ||= []
      col = @grid[row].size
      if cell_taken?(row, col)
        puts 'cell: empty'
        @grid[row] << nil
      else
        photo = photos.delete_at(0)
        size = photo_size(photo, row, col)
        cell = {photo: photo, size: size, rowspan: rowspan(size), colspan: colspan(size), row: row, col: col}
        puts "cell: #{cell}"
        @grid[row] << cell
      end

      row += 1 if col+1 >= GRID_WIDTH
    end
  end

  def new
    @photo = Photo.new
  end

  def edit
    @photo = Photo.find(params[:id])
  end

  def show
    @photo = Photo.find(params[:id])
  end

  def create
    @photo = Photo.new(photo_params)
    @photo.user = current_user
    if @photo.save
      flash[:success] = "The photo was added!"
      redirect_to photos_path
    else
      render 'new'
    end
  end

  def update
    @photo = Photo.find(params[:id])
    if @photo.update(photo_params)
      redirect_to photos_path
    else
      render 'edit'
    end
  end

  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy
    redirect_to photos_path
  end

  private

  def photo_params
    params.require(:photo).permit(:image, :description).merge user: current_user
  end

  def cell_taken?( row, col )
    (cell_size(row-1,col-1) == :medium) ||
    (cell_size(row,col-1) == :medium) ||
    (cell_size(row,col-1) == :landscape) ||
    (cell_size(row-1,col) == :medium) ||
    (cell_size(row-1,col) == :portrait)
  end

  def cell_size( row, col )
    @grid[row][col][:size] rescue nil
  end

  def photo_size( photo, row, col )
    if col >= GRID_WIDTH-1
      [:small, :portrait].shuffle.first
    else
      [:small, :medium, :portrait, :landscape].shuffle.first
    end
  end

  def rowspan( size )
    case size
      when :medium, :portrait then 2
      else 1
    end
  end

  def colspan( size )
    case size
      when :medium, :landscape then 2
      else 1
    end
  end

end
