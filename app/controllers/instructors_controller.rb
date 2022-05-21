class InstructorsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

  def index
    instructors = Instructor.all
    render json: instructors
  end

  def show
    instructor = Instructor.find(params[:id])
    render json: instructor, except: [:created_at, :updated_at]
  end

  def create
    instructor = Instructor.create!(instructor_params)
    render json: instructor, status: :created
  end

  def update
    instructor = Instructor.find(params[:id])
    instructor.update!(instructor_params)
    render json: instructor
  end

  def destroy
    instructor = Instructor.find(params[:id])
    instructor.destroy 
    head :no_content
  end

  private

  def instructor_params
    params.permit(:name)
  end

  def render_not_found_response
    render json: { error: "#{invalid.model} not found" }, status: :not_found
  end

  def render_unprocessable_entity_response
    render json: { error: invalid.record.errors.full_messages}
  end
end
