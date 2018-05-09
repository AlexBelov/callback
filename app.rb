require 'sinatra'
require "sinatra/activerecord"

class Log < ActiveRecord::Base
  def to_s
    "#{created_at} - <b>#{name}</b> - #{content}<br>"
  end
end

get '/' do
  content_type :json
  Log.pluck(:content).reverse.map{ |c| JSON.parse(c) }.to_json
end

get '/clear' do
  Log.delete_all
  Log.pluck(:content).reverse.map{ |c| JSON.parse(c) }.to_json
end

post '/callback' do
  Log.create(name: params[:name], content: params.to_json)
end
