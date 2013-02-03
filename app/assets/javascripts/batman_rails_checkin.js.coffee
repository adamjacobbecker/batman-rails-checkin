Batman.config.pathPrefix = '/'
Batman.config.viewPrefix = '/assets/views'
Batman.config.fetchRemoteViews = true
Batman.config.usePushState = true

window.BatmanRailsCheckin = class BatmanRailsCheckin extends Batman.App
  @title = "MorningCheckin"

  @root 'main#index'

  @resources 'projects', ->
    @resources 'checkins'
    @resources 'users'

  @route '/settings', 'main#settings'
  @route '/login', 'main#login'
  @route '/logout', 'main#logout'

  @on 'run', ->
    BatmanRailsCheckin.preloadViews() unless window.railsEnv is "development"

    if window.bootstrapData
      if bootstrapData.user_list? then @set 'currentUser', new BatmanRailsCheckin.User().fromJSON(bootstrapData.user_list)

    @set 'preferences', BatmanRailsCheckin.Preference.get('first') || BatmanRailsCheckin.Preference.create({})

  @flash: Batman()
  @flash.accessor
    get: (key) -> @[key]
    set: (key, value) ->
      @[key] = value
      if value isnt ''
        setTimeout =>
          @set(key, '')
        , 2000
      value

  @flashSuccess: (message) -> @set 'flash.success', message
  @flashError: (message) ->  @set 'flash.error', message

  @classAccessor 'pageTitle'
    get: (k) ->
      if @[k]? and @[k] isnt ''
        "#{@[k]} | #{@title}"
      else
        @title

    set: (k, v) ->
      @[k] = v
