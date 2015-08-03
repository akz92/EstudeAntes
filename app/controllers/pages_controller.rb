class PagesController < ApplicationController
  def show
   # filter the params[:id] here to allow only certain values like
   # if params[:id].match /browse|help/
   #  render :partial => params[:id]
   # else
   #  render :file => "/path/to/some/404_template", :status => 404
   # end
  end

  def help
  end
end
