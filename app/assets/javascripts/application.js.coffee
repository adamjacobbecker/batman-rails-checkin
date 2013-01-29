#= require jquery
#= require jquery_ujs
#= require twitter/bootstrap
#= require underscore
#= require moment

# Batman.js and its adapters
#= require es5-shim
#= require batman
#= require batman.jquery
#= require batman.rails

#= require batman_rails_checkin

#= require_tree ./models
#= require_tree ./controllers
#= require_tree ./helpers
#= require_tree ./view_helpers
#= require_tree ./views

#= require_tree .

$(document).ready ->
  BatmanRailsCheckin.run()
