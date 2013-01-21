class BatmanRailsCheckin.CheckinsController extends BatmanRailsCheckin.BaseController
  routingKey: 'checkins'


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

