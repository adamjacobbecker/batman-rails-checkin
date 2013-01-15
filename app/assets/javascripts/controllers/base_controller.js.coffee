class BatmanRailsCheckin.BaseController extends Batman.Controller

  authenticate: (cb) ->
    return cb() if BatmanRailsCheckin.currentUser

    user = new BatmanRailsCheckin.User()
    user.url = '/users/current'
    user.load (err, user) =>
      if user and user.get('id')?
        BatmanRailsCheckin.set 'currentUser', user
        cb()
      else
        @redirect "/login"

    return @render(false)
