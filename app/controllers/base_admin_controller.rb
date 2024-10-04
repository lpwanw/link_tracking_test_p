class BaseAdminController < ApplicationController
  http_basic_authenticate_with(
    name: ENV.fetch("ADMIN_USER_NAME", "admin"),
    password: ENV.fetch("ADMIN_USER_PASSWORD", "password")
    )
end
