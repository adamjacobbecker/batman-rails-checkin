Batman.config =
  pathPrefix: '/'
  usePushState: true

Batman.mixin Batman.Filters,
  momentFormatDateVerbose: (value) ->
    moment(value).format("\\a\\t h:mma \\o\\n M/D/YY")

window.BatmanRailsCheckin = class BatmanRailsCheckin extends Batman.App

  @title = "Batman Rails Checkin"

  Batman.ViewStore.prefix = 'assets/views'

  @root 'checkins#index'

  @route '/projects/:project_id', 'checkins#by_date'
  @route '/projects/:project_id/checkins/new', 'checkins#new'
  @route '/projects/:project_id/checkins/by_date/:date', 'checkins#by_date'
  @route '/projects/:project_id/checkins/by_user/:user_id', 'checkins#by_user'


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
