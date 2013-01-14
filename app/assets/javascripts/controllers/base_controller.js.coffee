class BatmanRailsCheckin.BaseController extends Batman.Controller

  authenticate: ->
    return if BatmanRailsCheckin.currentUser

    tempUser = new BatmanRailsCheckin.User()
    tempUser.url = "/users/current.json"
    tempUser.load (err, user) =>
      # throw err if err
      return @redirect "/login" unless !err and user.get('id')?
      BatmanRailsCheckin.set 'currentUser', user