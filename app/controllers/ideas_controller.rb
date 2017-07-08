# frozen_string_literal: true

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
    if current_user == @idea.user || current_user.admin
      @idea
    else
      redirect_to @idea, alert: 'You do not have access to edit this idea.'
    end
  end

  def create
    @idea = Idea.new(idea_params)
    if user_signed_in?
      @idea.user = current_user
    else
      verify_recaptcha(model: @idea)
    end
    if @idea.save
      redirect_to @idea, flash: { success: 'Idea created.' }
    else
      render 'new'
    end
  end

  def update
    @idea.update(idea_params)
    respond_with(@idea)
  end

  def destroy
    if current_user == @idea.user || current_user.admin
      @idea.destroy
      respond_with(@idea)
    else
      redirect_to @idea, alert: 'You do not have access to delete this idea.'
    end
  end

  private

    def set_idea
      @idea = Idea.find(params[:id])
    end

    def idea_params
      params.require(:idea).permit(:description, :level_of_fun, :level_of_complexity)
    end
end
