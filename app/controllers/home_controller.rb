class HomeController < ApplicationController
  before_action :already_login?
  def top
  end
end
