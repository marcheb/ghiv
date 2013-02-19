$: << File.expand_path(File.dirname(__FILE__))

require 'ghiv/config'
require 'ghiv/client'
require 'ghiv/issues'
require 'ghiv/query'
require 'ghiv/runner'
require 'ghiv/transceiver'
require 'ghiv/ui'

API_URL = 'https://api.github.com/repos'
Ghiv::Config.load!(File.expand_path(File.dirname(__FILE__)) + '/../config/config.yml')
