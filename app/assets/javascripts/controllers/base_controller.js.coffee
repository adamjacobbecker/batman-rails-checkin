class BatmanRailsCheckin.BaseController extends Batman.Controller

  authenticate: ->
    console.log 'authenticate'
    @redirect "/login" unless BatmanRailsCheckin.currentUser