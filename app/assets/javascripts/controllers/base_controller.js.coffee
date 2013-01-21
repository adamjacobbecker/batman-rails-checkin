class BatmanRailsCheckin.BaseController extends Batman.Controller

  @beforeFilter ->
    BatmanRailsCheckin.unset 'pageTitle'
    @set 'projects', BatmanRailsCheckin.Project.get('all')

    if !BatmanRailsCheckin.get('newProject')
      BatmanRailsCheckin.set 'newProject', new BatmanRailsCheckin.Project()

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

    if @get('project')?.get('id') is project_id
      cb()

    else
      @unset 'checkins'
      BatmanRailsCheckin.Project.find project_id, (err, project) =>
        @set 'project', project
        BatmanRailsCheckin.set 'currentProjectId', project.get('id')
        cb()

    return @render(false)

  # not routable, an event
  destroyCheckin: (node, event, context) ->
    $(node).closest(".checkin-wrapper").fadeOut 400, ->
      context.get('checkin').destroy (err) =>
        if err
          throw err unless err instanceof Batman.ErrorsSet

  createProject: (node, event, context) ->
    alert 'hi'
    # @get('newProject').save (err, project) =>
    #   console.log project
    #   context.redirect project


