
class ApplicationController < ActionController::Base
 
  protect_from_forgery unless: -> { request.format.json? }
    def not_found
        binding.pry
      render json: { error: 'not_found' }
    end
  
    def authorize_request
     
        binding.pry
      header = request.headers['Authorization']
      header = header.split(' ').last if header
      begin
        binding.pry
        @decoded = JsonWebToken.decode(header)
        @current_HospitalRegistration = HospitalRegistration.find(@decoded[:HospitalRegistration_id])
        binding.pry
      rescue ActiveRecord::RecordNotFound => e
        binding.pry
        render json: { errors: e.message }, status: :unauthorized
      rescue JWT::DecodeError => e
        binding.pry
        render json: { errors: e.message }, status: :unauthorized
      end
    end
  end