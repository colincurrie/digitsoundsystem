class PhotosController < ApplicationController

  GRID_WIDTH = 3

  def index
    @title = 'Gallery'
    # TODO: paginate
    # TODO: refactor this or DRY it up a bit or something... it's ugly

    page = params.fetch('page', 1)
    per_page = params.fetch('per_page', 35)
    @photos = Photo.order('created_at DESC, score DESC').page(page).per_page(per_page)
    queue = Queue.new
    @photos.each { |photo| queue << photo }

    @groups = []
    group_sizes = reduce([4]*12, per_page, 0)
    group_sizes.each do |size|
      begin
        if queue.size < size
          logger.debug 'skipping this one because there are not enough images'
          next
        end
        case size
          when 1
            @groups << Array.new(size).map { [queue.pop, :large] }
          when 2
            @groups << Array.new(size).map { [queue.pop, :portrait] }
          when 3
            # needs to be 2 small then one landscape or one landscape then 2 small
            if Random.rand(0..1) == 0
              @groups << [[queue.pop, :landscape]] + Array.new(2).map { [queue.pop, :small] }
            else
              @groups << Array.new(2).map { [queue.pop, :small] } + [[queue.pop, :landscape]]
            end
          when 4
            @groups << Array.new(size).map { [queue.pop, :small] }
          else
            logger.error 'invalid group size'
        end
      rescue => e
        logger.error "ran out of images (#{size}, #{queue.size}): #{e}"
      end
    end

    @groups.shuffle!
  end

  def reduce(group_sizes, target, n)
    sum = group_sizes.reduce(:+)
    if sum > target
      difference = sum - target
      added = (n%3)+1
      group_sizes.pop
      group_sizes.push([ added, difference ].min)
      group_sizes = reduce(group_sizes.sort, target, n+1)
    end
    group_sizes
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
      redirect_to photo_path @photo
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
end
