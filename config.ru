require './config/environment'

use Rack::MethodOverride
use UsersController
use BanjosController
run ApplicationController
