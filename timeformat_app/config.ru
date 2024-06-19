require_relative 'middleware/timerequest'
require_relative 'app'

use Timerequest
run App.new