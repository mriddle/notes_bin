require 'rubygems'
require 'bundler'

Bundler.require

Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8

require './app'
require './app/notes_api'

map "/api" do
  run NotesAPI
end

map "/assets" do
  run App.sprockets
end

run App