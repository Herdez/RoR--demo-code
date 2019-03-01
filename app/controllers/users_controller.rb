class UsersController < ApplicationController


  skip_before_filter :verify_authenticity_token, :only => [:inscritos_api]
  before_action :signed_in_user, only: [:index, :edit, :show, :update,:destroy, :stats]

  ...

  before_action :correct_user,   only: [:edit, :update, :show]
  before_action :admin_user,     only: [:destroy, :stats]
  skip_before_filter :verify_authenticity_token, :only => [:inscritos_api]



  def index
     @users = User.all.order(:status,:mode,:fase,:init_date).group_by(&:status)
  end

  ...

  def stats
    @users = User.all.order(:status,:mode,:fase,:init_date).group_by(&:status)
    # url has been deleted for this demo
    url = URI.parse('...')
    @leads = JSON.parse(Net::HTTP.get(url))
    @init_date_months = all_months("init_date")
    @enrrolment_date_months = all_months("enrolment_date")
  end

  def inscritos_api
    if params[:spots_token].nil? || params[:spots_token] != Rails.application.secrets.spots_token
      render :json => {error: "TOKEN INVALIDO"}
    elsif params[:spots_token] == Rails.application.secrets.spots_token
      @users = User.errolled.order(:mode,:fase,:init_date).pluck(:id,:name,:mode,:fase,:init_date)
      render :json => @users.to_json
    end
  end



  private

    def user_params
      params.require(:user).permit(:name, :email, :fase,
                                   :password, :password_confirmation,
                                   :init_date, :notes, :invoice,:enrolment_date,
                                   :status, :mode, :phone, :agreement, :demo)
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user) || current_user.admin?
    end

    ...

end
