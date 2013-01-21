class BatmanRailsCheckin.BaseController extends Batman.Controller

  @beforeFilter ->
    BatmanRailsCheckin.unset 'pageTitle'
    @set 'projects', BatmanRailsCheckin.Project.get('all')

    if !BatmanRailsCheckin.get('controllers').get('base').get('newProject')
      BatmanRailsCheckin.get('controllers').get('base').set 'newProject', new BatmanRailsCheckin.Project()

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
      @unset('isViewingSettings')
      @unset 'checkins'
      BatmanRailsCheckin.Project.find project_id, (err, project) =>
        @set 'project', project
        @set 'newCollaborator', new BatmanRailsCheckin.User {project_id: project.get('id')}
        BatmanRailsCheckin.set 'currentProjectId', project.get('id')
        cb()

    return @render(false)

  createCollaborator: (node) ->
    @get('newCollaborator').set 'email', $(node).find('input').val() # hack for typeahead not updating
    @get('newCollaborator').save (err) =>
      @set 'newCollaborator', new BatmanRailsCheckin.User {project_id: @get('project').get('id')}

  # not routable, an event
  destroyCheckin: (node, event, context) ->
    $(node).closest(".checkin-wrapper").fadeOut 400, ->
      context.get('checkin').destroy (err) =>
        if err
          throw err unless err instanceof Batman.ErrorsSet

  createProject: (node, event, context) ->
    @get('newProject').save (err, project) =>
      @redirect project
      project.get('users').load ->
      @unset('isAddingProject')
      @set 'newProject', new BatmanRailsCheckin.Project()

  toggleIsAddingProject: (node, event, context) ->
    if @get('isAddingProject')?
      @unset('isAddingProject')
    else
      @set 'isAddingProject', true

  toggleIsViewingSettings: (node, event, context) ->
    if @get('isViewingSettings')?
      @unset('isViewingSettings')
    else
      @set 'isViewingSettings', true

  updateProjectSettings: ->
    @updateProjectTimeout ||= setTimeout =>
      @get('project').save (err) =>
        @updateProjectTimeout = undefined
    , 500

  updateProjectSettingsAndToggleIsViewingSettings: ->
    @updateProjectSettings()
    @toggleIsViewingSettings()

  deleteProject: ->
    return unless confirm "Are you sure you want to delete this project?"
    @get('project').destroy (err) =>
      @redirect "/"