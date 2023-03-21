class MembershipsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

  def create
  membership = Membership.create!(membership_params)
  render json: membership, status: :created
  end

  def index
  memberships = Membership.all
  render json: memberships, except: [:created_at, :updated_at], status: :ok
  end

  def show
  membership = find_membership
  render json: membership, except: [:created_at, :updated_at], status: :ok
  end

 
 
  private

  def find_membership
    Membership.find(params[:id])
  end

  def membership_params
    params.permit(:gym_id, :client_id, :charge)
  end

  def render_not_found_response
    render json: { error: "Membership not found" }, status: :not_found
  end


  def render_unprocessable_entity_response(invalid)
    render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
  end 
end
