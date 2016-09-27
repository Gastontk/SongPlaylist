class SongsController < ApplicationController
	before_filter :authorize



	def index
		# render plain: "adsfasfdfasdfsdfsd"
		# @songs = Song.where(:user_id => current_user.id)
		# render '/songs_index'

		@songs=Song.all
	end
	# def show
	# 	render plain: "WTF??"
	# end
    



	def create
		

		if Song.exists?(title: params[:title], artist: params[:artist])
			@song =Song.find_by_artist_and_title(params[:artist], params[:title])

			@song.increment!(:num_added, 1)
			@song.save
			@songs=Song.all

      		redirect_to root_path
		else 
			
			@song = Song.new(song_params)
			@song.user_id = current_user.id
			@song.num_added = 1
			@songs=Song.all
			# render plain: @song.user_id
			if @song.save
				# render plain: @song.title
      			redirect_to root_path
   			else
     			 render 'songs/index'
			
			end

		end

		# @song.user_id = current_user.id
		# @song.save

		# @songs = Song.where(:user_id => current_user.id)
		# render 'songs/index'


	end





	private
		def song_params
			params.permit(:artist, :title)
		end
end
