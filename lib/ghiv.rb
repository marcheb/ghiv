$: << File.expand_path(File.dirname(__FILE__))

require 'askiimoji'
require 'ghiv/config'
require 'ghiv/class_factory'
require 'ghiv/client'
require 'ghiv/method_chain'
require 'ghiv/query'
require 'ghiv/runner'
require 'ghiv/transceiver'
require 'ghiv/ui'
require 'json'

API_URL = 'https://api.github.com/repos'
Ghiv::Config.load!(File.expand_path(File.dirname(__FILE__)) + '/../config/config.yml')
