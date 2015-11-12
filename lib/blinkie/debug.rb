def require_if_available(lib_name)
  require lib_name
rescue LoadError
end

require_if_available "cute_print"
require_if_available "pry"
require_if_available "pry-byebug"
