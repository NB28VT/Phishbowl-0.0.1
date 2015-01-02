class PredictionsController <ApplicationController
  def new
    @prediction = Prediction.new
  end

  def create
    @prediction = Prediction.create(prediction_params)
    redirect_to (prediction_path(@prediction.id)), notice: "Predictions submitted!"
  end

  def show
    @prediction = Prediction.find(params[:id])
  end


  private

  def prediction_params
    params.require(:prediction).permit(
      :set_one_opener,
      :set_one_closer,
      :set_two_opener,
      :set_two_closer,
      :encore,
      :random_song_one,
      :random_song_two,
      :random_song_three,
      :random_song_four,
      :random_song_five,
      :animal_song,
      :gamehendge_song,
      :cover_song,
      :place_song,
      :elemental_song,
      :name_song
    )

  end

end
