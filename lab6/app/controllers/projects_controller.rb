class ProjectsController < ApplicationController
  before_action :set_project, only: %i[show edit update destroy]

  def index
    @projects = Project.all
  end

  def in_progress
    @projects = Project.in_progress
  end

  def deadline_soon
    @projects = Project.deadline_soon
  end

  def show; end

  def new
    @project = Project.new
  end

  def edit; end

  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_to @project, notice: "Проєкт успішно створено."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @project.update(project_params)
      redirect_to @project, notice: "Проєкт успішно оновлено."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_url, notice: "Проєкт успішно видалено."
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:title, :description, :category_id, :client, :start_date, :deadline, :budget, :status, :team, tag_ids: [])
  end
end
