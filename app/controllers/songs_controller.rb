class SongsController < ApplicationController
	def index
		@songs = Song.where(:user_id => current_user.id)
	end




	def create
		

		if Song.exists?(title: params[:title], artist: params[:artist])
			@song =Song.find_by_artist_and_title(params[:artist], params[:title])

			@song.increment!(:num_added, 1)
			@song.save
			redirect_to '/songs_index'
		else 
			
			@song = Song.new(song_params)
			@song.user_id = current_user.id
			@song.num_added = 1
			# render plain: @song.user_id
			if @song.save
				# render plain: @song.title
				redirect_to '/songs_index'
			else
				render plain: "The song is new, but it wasn't saved."
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
