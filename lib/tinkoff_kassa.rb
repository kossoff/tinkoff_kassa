require 'active_support'
require 'active_support/core_ext/hash'
require 'httparty'

require 'tinkoff_kassa/client'
require 'tinkoff_kassa/notification'
require 'tinkoff_kassa/payment'
require 'tinkoff_kassa/request'
require 'tinkoff_kassa/version'

module TinkoffKassa
  include ActiveSupport::Configurable
end
