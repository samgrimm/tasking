class ClientsController < ApplicationController
  before_action :authenticate_user!

  def index
    @clients = current_user.clients
  end
end
