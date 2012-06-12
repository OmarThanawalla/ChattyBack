class DemoController < ApplicationController
#before_filter :confirm_logged_in
  before_filter :check_logged_in
  def index
  end
  
  def hello
  render('hello')
  end

end
