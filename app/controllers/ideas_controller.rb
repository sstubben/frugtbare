class IdeasController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :destroy]
  before_action :set_idea, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @ideas = Idea.all
    respond_with(@ideas)
  end

  def show
    respond_with(@idea)
  end

  def new
    @idea = Idea.new
    respond_with(@idea)
  end

  def edit
    # @user = @idea.user unless @idea.user_id.nil?
  end

  def create
    @idea = Idea.new(idea_params)
    @idea.save
    respond_with(@idea)
  end

  def update
    @idea.update(idea_params)
    respond_with(@idea)
  end

  def destroy
    @idea.destroy
    respond_with(@idea)
  end

  private

    def set_idea
      @idea = Idea.find(params[:id])
    end

    def idea_params
      params.require(:idea).permit(:description, :level_of_fun, :level_of_complexity)
    end
end
