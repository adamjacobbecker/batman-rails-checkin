Batman.config =
  pathPrefix: '/'
  usePushState: true

window.BatmanRailsCheckin = class BatmanRailsCheckin extends Batman.App

  @title = "Batman Rails Checkin"

  Batman.ViewStore.prefix = 'assets/views'

  @root 'checkins#by_date'
  @resources 'checkins'
  @route '/checkins/by_date/:date', 'checkins#by_date'
  @route '/login', 'main#login'
  @route '/logout', 'main#logout'

  @navLinks: [
    # {route: @get('routes.checkins'), controller: "checkins", text: "Checkins"},
  ]

  @on 'run', ->
    if window.bootstrapData
      @set 'currentUser', new BatmanRailsCheckin.User().fromJSON(bootstrapData.user_list)

    @set 'preferences', BatmanRailsCheckin.Preference.get('first') || BatmanRailsCheckin.Preference.create({})

  # @on 'ready', ->

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
