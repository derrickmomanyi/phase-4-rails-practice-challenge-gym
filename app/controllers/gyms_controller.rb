class GymsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    

 

         def index
        gyms = Gym.all
        render json: gyms, except: [:created_at, :updated_at], status: :ok
        end
      
        def show
        gym = find_gym
        render json: gym, except: [:created_at, :updated_at], status: :ok
        end


        def destroy
        gym = find_gym
        gym.destroy
        render json: { message: 'Gym was successfully deleted' }, status: :ok
        end


        private

        def find_gym
            Gym.find(params[:id])
        end

        def gym_params
            params.permit(:name, :address)
        end

        def render_not_found_response
            render json: { error: "Gym not found" }, status: :not_found
        end

 

end
