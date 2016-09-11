module LoadGameFilter
  module_function

  def before(controller)
    params = controller.params

    game = Game.find(params[:id])

    if game
      controller.current_game = game
    else
      fail NotFoundError, %Q(Game with id: #{params[:id].inspect} could not be found)
    end
  end
end
