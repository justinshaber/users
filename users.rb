require "tilt/erubis"
require "sinatra"
require "sinatra/reloader"
require 'yaml'

before do
  @users = YAML.load_file('users.yml')
end

get "/" do
  erb :home
end