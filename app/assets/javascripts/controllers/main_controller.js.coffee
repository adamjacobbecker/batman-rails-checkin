class BatmanRailsCheckin.MainController extends BatmanRailsCheckin.BaseController
  routingKey: 'main'

  logout: ->
    BatmanRailsCheckin.currentUser.destroy (err) =>
      BatmanRailsCheckin.unset 'currentUser'
      @redirect '/'

    @render(false)

  index: (params) ->
    @authenticated =>
      @unset 'project'
      BatmanRailsCheckin.unset 'currentProjectId'
      @render()
    , =>
      BatmanRailsCheckin.unset 'pageTitle'
      BatmanRailsCheckin.set 'invite', params.invite
      @render {source: "main/splash"}

  settings: (params) ->
    @authenticated =>
      BatmanRailsCheckin.unset 'currentProjectId'
      BatmanRailsCheckin.set 'activeNav', 'settings'
      @render()

  updateSettings: ->
    new Batman.Request
      url: '/users.json'
      method: 'put'
      type: 'json'
      data:
        user:
          email: BatmanRailsCheckin.get('currentUser').get('email')
          name: BatmanRailsCheckin.get('currentUser').get('name')
      success: (data) =>
        BatmanRailsCheckin.get('currentUser').set('gravatar_url', data.user.gravatar_url)
        BatmanRailsCheckin.flashSuccess "Settings updated successfully!"
