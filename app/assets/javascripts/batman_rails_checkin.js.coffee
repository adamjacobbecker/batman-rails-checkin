window.BatmanRailsCheckin = class BatmanRailsCheckin extends Batman.App

  # @root 'controller#all'
  # @route '/controller/:id', 'controller#show', resource: 'model', action: 'show'

  @title = "Batman Rails Checkin"

  # 0.8.0 changed to this syntax
  Batman.ViewStore.prefix = 'assets/views'

  @navLinks: [
    {href: "/#!/checkins/", controller: "checkins", text: "Checkins"},
  ]

  @resources 'checkins'
  @root 'checkins'

  @on 'run', ->
    console?.log "Running ...."

  @on 'ready', ->
    console?.log "BatmanRailsCheckin ready for use."

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
