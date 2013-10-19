class GoalsController < ApplicationController

  def index
    @goals = current_user.goals
    render :index
  end

  def show
    @goal = Goal.find(params[:goal])
    render :show
  end

  def new
    @goal = Goal.new
    render :new
  end

  def create
    @goal = Goal.new(params[:goal])
    if @goal.save
      redirect_to user_goals_url(@goal.user_id)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def edit
    @goal = Goal.find(params[:id])
    render :edit
  end

  def update
    @goal = Goal.find(params[:id])
    if @goal.update_attributes(params[:goal])
      redirect_to user_goals_url(@goal.user_id)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :edit
    end
  end

  def destroy
    @goal = Goal.find(params[:id])
    @goal.delete
    redirect_to user_goals_url(@goal.user_id)
  end
end
