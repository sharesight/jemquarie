require 'warning'

Warning.process do |warning|
  case warning
  when /warning:/
    :raise
  else
    :default
  end
end
