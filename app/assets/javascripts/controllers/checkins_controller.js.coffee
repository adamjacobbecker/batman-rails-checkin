class BatmanRailsCheckin.CheckinsController extends BatmanRailsCheckin.BaseController
  routingKey: 'checkins'

  @beforeFilter 'resetCheckinDisplayParams'

  resetCheckinDisplayParams: ->
    if !@get('users') then BatmanRailsCheckin.User.load (err, users) =>
      @set 'users', users

    if !@get('days') then BatmanRailsCheckin.Day.load {now: Math.round(Date.now()/1000)}, (err, days) =>
      @set 'days', days

  by_date: (params) ->
    @authenticated =>
      @set 'sidebarViewBy', 'date'
      @set 'sidebarActiveUser', undefined
      @set 'currentlyViewingBy', 'date'

      BatmanRailsCheckin.Day.find params.date || moment().format('YYYY-MM-DD'), (err, day) =>
        @set 'sidebarActiveDay', day
        @set 'checkins', day.get('checkins')

      @render()

  by_user: (params) ->
    @authenticated =>
      @set 'sidebarViewBy', 'user'
      @set 'sidebarActiveDay', undefined
      @set 'currentlyViewingBy', 'user'

      BatmanRailsCheckin.User.find parseInt(params.user_id), (err, user) =>
        @set 'sidebarActiveUser', user
        user.get('checkins').load (err, checkins) =>
          @set 'checkins', checkins

      @render source: "checkins/by_date"

  show: (params) ->
    @authenticated =>
      @set 'checkin', BatmanRailsCheckin.Checkin.find parseInt(params.id), (err, checkin) =>
        BatmanRailsCheckin.set 'pageTitle', checkin.get('date')
        throw err if err

      @render()

  new: (params) ->
    @authenticated =>
      BatmanRailsCheckin.set 'pageTitle', 'New Checkin'
      @set 'checkin', new BatmanRailsCheckin.Checkin
        user_id: BatmanRailsCheckin.get('currentUser').get('id')
        created_at: new Date().toISOString()
        body: """
          #### Get Done


          #### Got Done


          #### Flags


          #### Shelf

        """
      @form = @render()

  create: (params) ->
    @authenticated =>
      @get('checkin').save (err) =>
        $('#new_checkin').attr('disabled', false)

        if err
          throw err unless err instanceof Batman.ErrorsSet
        else
          BatmanRailsCheckin.flashSuccess "Checkin created successfully!"
          @redirect '/'

  edit: (params) ->
    @authenticated =>
      @set 'checkin', BatmanRailsCheckin.Checkin.find parseInt(params.id), (err, checkin) ->
        BatmanRailsCheckin.set 'pageTitle', "Editing #{checkin.get('date')}"
        throw err if err
      @form = @render()

  update: (params) ->
    @authenticated =>
      @get('checkin').save (err) =>
        $('#edit_checkin').attr('disabled', false)

        if err
          throw err unless err instanceof Batman.ErrorsSet
        else
          BatmanRailsCheckin.flashSuccess "Checkin updated successfully!"
          @redirect '/checkins'

  # not routable, an event
  destroy: (node, event, context) ->
    context.get('checkin').destroy (err) =>
      if err
        throw err unless err instanceof Batman.ErrorsSet

    _.find( @get('days'), (day) ->
      context.get('checkin').get('date') is day.get('date')
    ).decrementCheckinCount()

    @get('checkins').remove(context.get('checkin'))
    BatmanRailsCheckin.flashSuccess "Checkin deleted successfully!"


  switchViewByDateUser: ->
    if @get('sidebarViewBy') is "date"
      @set 'sidebarViewBy', "user"
      BatmanRailsCheckin.get('preferences').updateAttributes({sidebarViewBy: 'user'}).save()
    else
      @set 'sidebarViewBy', "date"
      BatmanRailsCheckin.get('preferences').updateAttributes({sidebarViewBy: 'date'}).save()
