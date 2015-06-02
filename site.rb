require 'bundler/setup'
require 'json'
require 'sinatra'
require 'sass'
require 'erb'
require 'sinatra/assetpack'
require 'tilt/erb'

class App < Sinatra::Application
	def initialize(app=nil)
		super(app)
	end

	register Sinatra::AssetPack
	assets do
		js :application, [
			'js/*.js'
		]

		css :application, [
			'css/*.css'
		]

		js_compression :jsmin
		css_compression :sass
	end

	# 404 Error!
	not_found do
	  status 404
	  erb :not_found, :layout => :layout
	end

	error do
	  erb :error, :layout => :layout
	end

	get '/' do
		redirect '/calendar'
	end

	get '/calendar' do
		erb :calendar, :layout => :layout
	end

	get '/about' do
		erb :about, :layout => :layout
	end

	get '/elsewhere' do
		erb :elsewhere, :layout => :layout
	end

	get '/groups' do
		json = File.read('data/groups.json') 
		events = JSON.parse(json)  
		erb :event_list, :layout => :layout, :locals => {events:events}
	end

	get '/conferences' do
		json = File.read('data/conferences.json') 
		events = JSON.parse(json)  
		erb :event_list, :layout => :layout, :locals => {events:events}
	end
end