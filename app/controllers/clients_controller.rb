class ClientsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  

  def create
  client = Client.create!(client_params)
  render json: client, status: :created
  end

  def index
  clients = Client.all
  render json: clients, except: [:created_at, :updated_at], status: :ok
  end

  def show
  client = find_client
  render json: client, except: [:created_at, :updated_at], status: :ok
  end

  

  private

  def find_client
    Client.find(params[:id])
  end

  

  def render_not_found_response
    render json: { error: "Client not found" }, status: :not_found
  end


end
