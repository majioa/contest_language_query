class LanguagesController < ApplicationController
  include LanguagesHelper

  # GET /languages
  def index
    tokens = filter_tokens
    @languages = tokens.blank? && Language.all || Language.by_tokens_with_relations( filter_tokens )

    respond_to do |format|
      format.html { render :index }
      format.js
    end
  end

  protected

  def filter_params
    params.permit( :request )
  end

  def filter_tokens
    tokenize( filter_params.to_h[ 'request' ] )
  end
end
