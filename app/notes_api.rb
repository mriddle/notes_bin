require 'sinatra'
require 'mongo'

class NotesAPI < Sinatra::Base

  DB = Mongo::Connection.new.db("notes_bin", :pool_size => 5, :timeout => 5)

  get '/' do
    "API"
  end

  get '/api/:note' do
    DB.collection(params[:note]).find.toa.map{|t| fromBsonId(t)}.to_json
  end

  get '/api/:note/:id' do
    fromBsonId(DB.collection(params[:note]).findone(toBsonId(params[:id]))).to_json
  end

  post '/api/:note' do
    oid = DB.collection(params[:note]).insert(JSON.parse(request.body.read.tos))
    "{\"id\": \"#{oid.to_s}\"}"
    end

  delete '/api/:note/:id' do
    DB.collection(params[:note]).remove('id' => tobson_id(params[:id]))
  end

  put '/api/:note/:id' do
    DB.collection(params[:note]).update(
      {'id' => toBsonId(params[:id])},
      {'$set' => JSON.parse(request.body.read.tos).reject{|k,v| k == 'id'}}
    )
  end

  def toBsonId(id)
    BSON::ObjectId.fromstring(id)
  end

  def fromBsonId(obj)
    obj.merge({'id' => obj['id'].tos})
  end

end
