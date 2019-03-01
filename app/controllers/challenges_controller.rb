class ChallengesController < ApplicationController
  
  before_action :signed_in_user
  before_action :enrolled_in_course, only: [:index, :show]
  before_action :challenge_is_part_of_user_courses, only: [:show]
  
  ...

  def index
    @course = Course.find(params[:course]) if current_user.admin? 
    @week = Week.find(params[:week])
    @day = params[:day] 
    @schedules = @week.schedules.where(day:@day).order(:order)
  end

  def show
    @answer = Answer.new
    @challenge = Challenge.find(params[:id])
    @course = params[:course]    
    @week = params[:week]
    @day = params[:day]
  end

  ...

  def update
    @challenge = Challenge.find(params[:id])
    if @challenge.update_attributes(challenge_params)
      flash[:success] = "..."
      redirect_to challenge_path(@challenge)
    else
      render 'edit'
    end
  end


  def destroy
    @challenge = Challenge.find(params[:id])
    if @challenge.can_destroy?
       @challenge.destroy
       flash[:success] = "..."
    else
      flash[:warning] = "..."
    end
    redirect_to root_path
  end

  def weeks
    @course = Course.find(params[:course])
    @week = Week.find(params[:week])
    @day = params[:day]
    @schedules = @week.schedules.where(day:@day).order(:order)
    @empty = true if @schedules.empty?
  end

  def fasecero
    @course = Course.find(1)
    @week = params[:week] || 0
    @ruby_exercises = Challenge.week_day(@week, 5).order(title: :asc)
    @semana_1 = Challenge.week_day(@week, 1).order(title: :asc)
    @semana_2 = Challenge.week_day(@week, 2).order(title: :asc)
    
    ...

  end

  private

    def challenge_params
      params.require(:challenge).permit(:title,:content, :week, :day, :source, :gradable)
    end

    def payments_pending
      if !current_user.payments_pending.empty? 
        flash[:danger] = "..."      
          redirect_to(root_url) 
      end
    end

    ...

    def enrolled_in_course
      unless current_user.admin? 
        @course = Course.find(params[:course])  
        unless current_user.is_in_course?(@course.name) && current_user.status != "Baja"
          flash[:danger] = "..."      
          redirect_to(root_url) 
        end
      end
    end

    def challenge_is_part_of_user_courses
      unless current_user.admin?                
        @course = Course.find(params[:course]) 
        if  @course.name == "Intensivo" && !((current_user.fase + 1) * 3 >= params[:week].to_i) 
          flash[:danger] = "..."
          redirect_to(root_url) 
        end
      end 
    end

    ...

end




  


  



