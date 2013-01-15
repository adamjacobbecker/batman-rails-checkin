class BatmanRailsCheckin.CheckinsController extends BatmanRailsCheckin.BaseController
  routingKey: 'checkins'

  index: (params) ->
    @authenticated =>
      BatmanRailsCheckin.Checkin.load (err, results) =>
        @set 'checkins', results
        @render()

  show: (params) ->
    @set 'checkin', BatmanRailsCheckin.Checkin.find parseInt(params.id, 10), (err) ->
      throw err if err

    @render source: 'checkins/show'

  new: (params) ->
    @set 'checkin', new BatmanRailsCheckin.Checkin()
    @form = @render()

  create: (params) ->
    @get('checkin').save (err) =>
      $('#new_checkin').attr('disabled', false)

      if err
        throw err unless err instanceof Batman.ErrorsSet
      else
        BatmanRailsCheckin.flashSuccess "Checkin created successfully!"
        @redirect '/checkins'

  edit: (params) ->
    @set 'checkin', BatmanRailsCheckin.Checkin.find parseInt(params.id, 10), (err) ->
      throw err if err
    @form = @render()

  update: (params) ->
    @get('checkin').save (err) =>
      $('#edit_checkin').attr('disabled', false)

      if err
        throw err unless err instanceof Batman.ErrorsSet
      else
        BatmanRailsCheckin.flashSuccess "Checkin updated successfully!"
        @redirect '/checkins'

  # not routable, an event
  destroy: ->
    @get('checkin').destroy (err) =>
      if err
        throw err unless err instanceof Batman.ErrorsSet
      else
        BatmanRailsCheckin.flashSuccess "Removed successfully!"
        @redirect '/checkins'