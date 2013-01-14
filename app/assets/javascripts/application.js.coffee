#= require jquery
#= require jquery_ujs
#= require twitter/bootstrap

# Batman.js and its adapters
#= require batman/es5-shim
#= require batman/batman
#= require batman/batman.jquery
#= require batman/batman.rails

#= require batman_rails_checkin

#= require_tree ./models
#= require_tree ./controllers
#= require_tree ./helpers

#= require_tree .
# Run the Batman app
$(document).ready ->
  BatmanRailsCheckin.run()