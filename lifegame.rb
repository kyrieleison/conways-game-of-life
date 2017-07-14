$LOAD_PATH << File.expand_path('./lib', __dir__)
require 'lifegame'

lifegame = Lifegame.new(20, 20)
lifegame.start
