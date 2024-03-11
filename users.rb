require "tilt/erubis"
require "sinatra"
require "sinatra/reloader"
require 'yaml'

before do
  @users = YAML.load_file('users.yml')
end

not_found do 
  redirect "/"
end

helpers do
  def format_interests(interests)
    interests.join(", ")
  end

  def links_to_others(current)
    other_users = @users.select { |name, _| name != current }
    
    other_users.keys.map do |name|
      url = "/#{name}"
      "<a href=#{url}>#{name}</a>"
    end.join(", ")
  end
end

def user_data(user)
  name = user.to_s.capitalize
  email = @users[user][:email]
  interests = @users[user][:interests]

  [name, email, interests]
end

get "/" do
  erb :home
end

get "/:user" do
  @user = params[:user].to_sym
  redirect "/" unless @users.has_key? @user
  @name, @email, @interests = user_data(@user)

  erb :user_bio
end



