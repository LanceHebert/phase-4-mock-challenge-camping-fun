class CampersController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :not_found
    rescue_from ActiveRecord::RecordInvalid, with: :invalid_records


    def index
        campers = Camper.all
        render json: campers
    end
    def show
        camper = Camper.find(params[:id])
        render json: camper,include: :activities
    end

    def create
        camper = Camper.create!(camper_params)        
        render json: camper,include: :activities,status: :created
    end


    private

    def not_found
        render json:{error: "Camper not found"},status: :not_found
    end

    def invalid_records(invalid)
        render json: {errors: invalid.record.errors.full_messages},status: :unprocessable_entity
      end

    def camper_params
        params.permit(:name,:age)
    end


end
