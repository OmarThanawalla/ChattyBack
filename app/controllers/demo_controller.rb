class DemoController < ApplicationController
#before_filter :confirm_logged_in
  def index
  end
  
  def hello
  render('hello')
  end

end
