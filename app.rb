require 'sinatra'
require "sinatra/activerecord"

class Log < ActiveRecord::Base
  def to_s
    "#{created_at} - <b>#{name}</b> - #{content}<br>"
  end
end

get '/' do
  content_type :json
  Log.all.reverse.map{ |l| {headers: l.name, content: JSON.parse(l.content)} }.to_json
end

get '/clear' do
  Log.delete_all
  Log.all.reverse.map{ |l| {headers: l.name, content: JSON.parse(l.content)} }.to_json
end

post '/callback' do
  Log.create(name: request.env['HTTP_SIGNATURE'], content: params.to_json)
end
