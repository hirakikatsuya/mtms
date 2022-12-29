# frozen_string_literal: true

class SearchesController < ApplicationController
  def search
    @model = params[:model]
    @content = params[:content]
    if @content.present?
      if @model == "user"
        @records = User.search_for(@content).where(is_deleted: false).page(params[:page]).per(10)
      elsif @model == "training"
        @records = Training.search_for(@content).active_users.page(params[:page]).per(10)
      else
        @records = Group.search_for(@content).page(params[:page]).per(10)
      end
    else
      flash[:notice] = "キーワードを入力して検索してください"
      redirect_to request.referer
    end
  end
end
