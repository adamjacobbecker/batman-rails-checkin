class BatmanRailsCheckin.CheckinsController extends BatmanRailsCheckin.BaseController
  routingKey: 'checkins'

  @beforeFilter 'resetCheckinDisplayParams'

  resetCheckinDisplayParams: ->
    @set 'currentDay', undefined

    if !@get('sidebarViewBy')
      @set 'sidebarViewBy', BatmanRailsCheckin.get('preferences').get('sidebarViewBy') || "date"

  # index: (params) ->
  #   BatmanRailsCheckin.Day.load (err, days) =>
  #     @by_date({date: days[0].get('date')})
  #   @render(false)

  by_date: (params) ->
    @authenticated =>
      @set 'users', BatmanRailsCheckin.User.get('all')

      BatmanRailsCheckin.Day.load {now: Math.round(Date.now()/1000)}, (err, days) =>
        @set 'days', days

      BatmanRailsCheckin.Day.find params.date || 'today', (err, day) =>
        @set 'currentDay', day
        @set 'checkins', day.get('checkins')

      @render()

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

    @get('days').find( (day) ->
      context.get('checkin').get('date') is day.get('date')
    ).decrementCheckinCount()

    @get('checkins').remove(context.get('checkin'))


  switchViewByDateUser: ->
    if @get('sidebarViewBy') is "date"
      @set 'sidebarViewBy', "user"
      BatmanRailsCheckin.get('preferences').updateAttributes({sidebarViewBy: 'user'}).save()
    else
      @set 'sidebarViewBy', "date"
      BatmanRailsCheckin.get('preferences').updateAttributes({sidebarViewBy: 'date'}).save()
