class Admin::ProblemsController < ActionController::Base
  before_action :authenticate_admin!

  layout 'admin'

  def index
    @problems = Problem.all.reverse_order
  end


  private
end
