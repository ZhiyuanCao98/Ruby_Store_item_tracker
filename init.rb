######## Author: Zhiyuan Cao
#### Item_Info Tracker####
#
# Using command line to running the file #
# >>ruby init.rb


FILE_PATH = File.dirname(__FILE__)
$:.unshift(File.join(FILE_PATH, 'lib') )
require 'interact'


interact = Interact.new('item.txt')
interact.launch!
