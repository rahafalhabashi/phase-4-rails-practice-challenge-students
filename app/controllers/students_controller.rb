class StudentsController < ApplicationController
    def index
        students = Student.all
        render json: students
      end
    
      def show
        students = Student.find(params[:id])
        render json: students
      end
    
      def create
        students = Student.create!(students_params)
        render json: students, status: :created
      end
    
      def update
        students = Student.find(params[:id])
        istructure.update!(students_params)
        render json: students, status: :updated
      end
    
      def destroy
        students = Student.find(params[:id])
        students.destroy 
        head :no_content
      end
    
      private
    
      def students_params
        params.permit(:name, :major, :age, :instructor_id)
      end

      def render_not_found_response
        render json: { error: "Instructor not found" }, status: :not_found
      end
    
      def render_unprocessable_entity_response
        render json: { error: invalid.record.errors.full_messages}
      end
end
