$: << File.expand_path(File.dirname(__FILE__))

require 'askiimoji'
require 'ghiv/config'
require 'ghiv/client'
require 'ghiv/command'
require 'ghiv/command/issue'
require 'ghiv/command/issues'
require 'ghiv/method_chain'
require 'ghiv/query'
require 'ghiv/query/issue'
require 'ghiv/query/issues'
require 'ghiv/runner'
require 'ghiv/transceiver'
require 'ghiv/ui'
require 'json'

API_URL = 'https://api.github.com/repos'
Ghiv::Config.load!(File.expand_path(File.dirname(__FILE__)) + '/../config/config.yml')
