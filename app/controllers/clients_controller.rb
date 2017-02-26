class ClientsController < ApplicationController
  before_action :authenticate_user!

  def index
    @clients = Client.by_user(current_user)
  end
end
