Batman.config =
  pathPrefix: '/'
  viewPrefix: '/assets/views'
  fetchRemoteViews: true
  usePushState: true

Batman.mixin Batman.Filters,
  momentFormatDateVerbose: (value) ->
    moment(value).format("\\a\\t h:mma \\o\\n M/D/YY")

  momentFormatDate: (value) ->
    moment(value).format("M/D/YY")

window.BatmanRailsCheckin = class BatmanRailsCheckin extends Batman.App

  @title = "Batman Rails Checkin"

  @root 'main#index'

  @resources 'projects', ->
    @resources 'checkins'
    @resources 'users'

  @route '/login', 'main#login'
  @route '/logout', 'main#logout'

  @on 'run', ->
    if window.bootstrapData
      if bootstrapData.user_list? then @set 'currentUser', new BatmanRailsCheckin.User().fromJSON(bootstrapData.user_list)

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
