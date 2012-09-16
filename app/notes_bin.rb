class NotesBin < Sinatra::Base

  get '/stylesheet.css' do
    content_type 'text/css', charset: 'utf-8'
    sass :stylesheet, :style => :compact
  end

  get '/' do
    haml :index
  end

end
