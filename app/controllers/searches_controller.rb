# frozen_string_literal: true

class SearchesController < ApplicationController
  def search
    @model = params[:model]
    @content = params[:content]
    @method = params[:method]
    if @model == "user"
      @records = User.search_for(@content, @method).where(is_deleted: false).page(params[:page]).per(10)
    elsif @model == "training"
      @records = Training.search_for(@content, @method).active_users.page(params[:page]).per(10)
    else
      @records = Group.search_for(@content, @method).page(params[:page]).per(10)
    end
  end
end
