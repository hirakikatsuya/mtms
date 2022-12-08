class SearchesController < ApplicationController

  def search
    @model=params[:model]
    @content=params[:content]
    @method=params[:method]
    if @model == "user"
      @records=User.search_for(@content, @method).where(is_deleted:false)
    else
      @records=Training.search_for(@content, @method).active_users
    end
  end

end
