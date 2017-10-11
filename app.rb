require 'sinatra'
require "sinatra/activerecord"

class Log < ActiveRecord::Base
  def to_s
    "#{created_at} - <b>#{name}</b> - #{content}<br>"
  end
end

get '/' do
  Log.all.map(&:to_s)
end

post '/callback' do
  Log.create(name: params[:name], content: params.to_json)
end
