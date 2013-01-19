class BatmanRailsCheckin.BaseController extends Batman.Controller

  @beforeFilter ->
    BatmanRailsCheckin.set 'pageTitle', undefined
    @set 'projects', BatmanRailsCheckin.Project.get('all')


  authenticated: (cb) ->
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

  notAuthenticated: (cb) ->
    return @redirect "/" if BatmanRailsCheckin.currentUser

    user = new BatmanRailsCheckin.User()
    user.url = '/users/current'
    user.load (err, user) =>
      if user and user.get('id')?
        BatmanRailsCheckin.set 'currentUser', user
        @redirect "/"
      else
        cb()

    return @render(false)
