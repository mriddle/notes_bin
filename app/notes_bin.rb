require 'sinatra'
require 'mongo'

class NotesBin < Sinatra::Base
  DB = Mongo::Connection.new.db("notes_bin", :pool_size => 5, :timeout => 5)

  get '/stylesheet.css' do
    content_type 'text/css', charset: 'utf-8'
    sass :stylesheet, :style => :compact
  end

  get '/' do
    haml :index
  end

end
