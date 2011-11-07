require 'rubygems'
require 'bundler'

Bundler.setup

require 'sinatra'
require 'slim'
require 'json'
require 'mongoid'

require './application'

run Application
