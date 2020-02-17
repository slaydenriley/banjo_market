require './config/environment'

use Rack::MethodOverride
use UserController
use BanjoController
run ApplicationController
