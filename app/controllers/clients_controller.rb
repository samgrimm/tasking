class ClientsController < ApplicationController
  before_action :authenticate_user!

  def index
    @clients = Client.all
  end
end
