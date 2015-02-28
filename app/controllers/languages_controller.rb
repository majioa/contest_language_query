class LanguagesController < ApplicationController
  include LanguagesHelper

  # GET /languages
  # GET /languages.json
  def index
    @languages = Language.all
  end

  # GET /filter
  # GET /filter.json
  def filter
    @languages = Language.by_tokens_with_relations filter_tokens

    render :index
  end

  private

  def filter_params
    params.require(:request)
    params.permit(:request)
  end

  def filter_tokens
    tokenize filter_params.to_h[ 'request' ]
  end
end
