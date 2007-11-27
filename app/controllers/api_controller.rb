class ApiController < ApplicationController
  before_filter :verify_oauth_request
  
  # returns non-OAuth params
  def echo
    render :text => request.query_parameters.map { |k,v| "#{k}=#{v}" }.join("&")
  end
end
