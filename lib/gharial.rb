$: << File.expand_path(File.dirname(__FILE__))

require 'gharial/config'
require 'gharial/client'
require 'gharial/issues'
require 'gharial/query'
require 'gharial/runner'
require 'gharial/transceiver'
require 'gharial/ui'

API_URL = 'https://api.github.com/repos'
Gharial::Config.load!(File.expand_path(File.dirname(__FILE__)) + '/../config/config.yml')
