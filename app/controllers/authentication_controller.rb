class AuthenticationController < ApplicationController
    before_action :authorize_request, except: :login
    
    # POST /auth/login
    def login
      @hospital_registration = HospitalRegistration.find_by_email(params[:email])
      if @hospital_registration&.authenticate(params[:password])
        token = JsonWebToken.encode(hospital_registration_id:  @hospital_registration.id)
        time = Time.now + 24.hours.to_i
        render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"),
        hospitalDetails: @hospital_registration }, status: :ok
      else
        render json: { error: 'unauthorized' }, status: :unauthorized
      end
    end
    private
  
    def login_params
      params.permit(:email, :password)
    end
  end
