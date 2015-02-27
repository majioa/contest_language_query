class LanguagesController < ApplicationController
  # GET /languages
  # GET /languages.json
  def index
    @languages = Language.all
  end

  # GET /filter
  # GET /filter.json
  def filter
    @languages = Language.by_tokens filter_tokens

    render :index
  end

  private

  def filter_params
    params.require(:request)
    params.permit(:request)
  end

  def filter_tokens
    filter_params.to_h[ 'request' ].split( /\s+/ )
  end
end
