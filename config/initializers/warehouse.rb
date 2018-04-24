require './lib/warehouse/api_factory'
require './lib/warehouse/fake_api'
require 'warehouse/json_api'

if Rails.env.local?
  WAREHOUSE_URL = "http://localhost:8080"
  Warehouse::APIFactory.class_name = Warehouse::JsonAPI
else
  WAREHOUSE_URL = "http://localhost:8080"
  Warehouse::APIFactory.class_name = Warehouse::JsonAPI
end
