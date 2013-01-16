class BatmanRailsCheckin.CheckinsController extends BatmanRailsCheckin.BaseController
  routingKey: 'checkins'

  # index: (params) ->
  #   BatmanRailsCheckin.Day.load (err, days) =>
  #     @by_date({date: days[0].get('date')})
  #   @render(false)

  by_date: (params) ->
    @authenticated =>
      @set 'users', BatmanRailsCheckin.User.get('all')
      @set 'checkins', BatmanRailsCheckin.Checkin.get('all')

      BatmanRailsCheckin.Day.load (err, days) =>
        @set 'days', days

      BatmanRailsCheckin.Day.find params.date || 'today', (err, day) =>
        @set 'currentDay', day.get('date')
        console.log day.get('checkins')

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
      @set 'checkin', new BatmanRailsCheckin.Checkin()
      @form = @render()

  create: (params) ->
    @authenticated =>
      @get('checkin').save (err) =>
        $('#new_checkin').attr('disabled', false)

        if err
          throw err unless err instanceof Batman.ErrorsSet
        else
          BatmanRailsCheckin.flashSuccess "Checkin created successfully!"
          @redirect '/checkins'

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
  destroy: ->
    @authenticated =>
      @get('checkin').destroy (err) =>
        if err
          throw err unless err instanceof Batman.ErrorsSet
        else
          BatmanRailsCheckin.flashSuccess "Removed successfully!"
          @redirect '/checkins'