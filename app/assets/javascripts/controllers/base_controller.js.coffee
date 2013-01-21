class BatmanRailsCheckin.BaseController extends Batman.Controller

  @beforeFilter ->
    BatmanRailsCheckin.unset 'pageTitle'
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

  withProject: (project_id, cb) ->
    project_id = parseInt(project_id)

    BatmanRailsCheckin.Project.find project_id, (err, project) =>
      @set 'project', project
      BatmanRailsCheckin.set 'currentProjectId', project.get('id')
      cb()

    return @render(false)

  switchViewByDateUser: ->
    if @get('sidebarViewBy') is "date"
      @set 'sidebarViewBy', "user"
    else
      @set 'sidebarViewBy', "date"

