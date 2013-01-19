class BatmanRailsCheckin.ProjectsController extends BatmanRailsCheckin.BaseController
  routingKey: 'projects'

  show: (params) ->
    @authenticated =>
      @withProject params.id, =>
        @set 'sidebarViewBy', 'date'
        @set 'checkinsViewBy', 'date'
        @set 'dateId', moment().format('YYYY-MM-DD')
        @set 'userId', undefined

        @get('project').get('checkins').load {date: params.date || moment().format('YYYY-MM-DD')}, (err, checkins) =>
          @set 'checkins', checkins

        @render source: "shared/checkins"


  # by_date: (params) ->
  #   @authenticated =>
  #     @withProject params.project_id, =>
  #       @set 'sidebarViewBy', 'date'
  #       @set 'sidebarActiveUser', undefined
  #       @set 'currentlyViewingBy', 'date'

  #       @get('currentProject').get('checkins').load {date: params.date || moment().format('YYYY-MM-DD')}, (err, checkins) =>
  #         @set 'checkins', checkins

  #       # @set 'sidebarActiveDay', @get('currentProject').get('days').find(1)

  #       @render()

  # by_user: (params) ->
  #   @authenticated =>
  #     @set 'sidebarViewBy', 'user'
  #     @set 'sidebarActiveDay', undefined
  #     @set 'currentlyViewingBy', 'user'

  #     BatmanRailsCheckin.User.find parseInt(params.user_id), (err, user) =>
  #       @set 'sidebarActiveUser', user
  #       user.get('checkins').load (err, checkins) =>
  #         @set 'checkins', checkins

  #     @render source: "checkins/by_date"

  # show: (params) ->
  #   @authenticated =>
  #     @set 'checkin', BatmanRailsCheckin.Checkin.find parseInt(params.id), (err, checkin) =>
  #       BatmanRailsCheckin.set 'pageTitle', checkin.get('date')
  #       throw err if err

  #     @render()

  # new: (params) ->
  #   @authenticated =>
  #     BatmanRailsCheckin.set 'pageTitle', 'New Checkin'
  #     @set 'checkin', new BatmanRailsCheckin.Checkin
  #       user_id: BatmanRailsCheckin.get('currentUser').get('id')
  #       created_at: new Date().toISOString()
  #       body: """
  #         #### Get Done


  #         #### Got Done


  #         #### Flags


  #         #### Shelf

  #       """
  #     @form = @render()

  # create: (params) ->
  #   @authenticated =>
  #     @get('checkin').save (err) =>
  #       $('#new_checkin').attr('disabled', false)

  #       if err
  #         throw err unless err instanceof Batman.ErrorsSet
  #       else
  #         BatmanRailsCheckin.flashSuccess "Checkin created successfully!"
  #         @redirect '/'

  # edit: (params) ->
  #   @authenticated =>
  #     @set 'checkin', BatmanRailsCheckin.Checkin.find parseInt(params.id), (err, checkin) ->
  #       BatmanRailsCheckin.set 'pageTitle', "Editing #{checkin.get('date')}"
  #       throw err if err
  #     @form = @render()

  # update: (params) ->
  #   @authenticated =>
  #     @get('checkin').save (err) =>
  #       $('#edit_checkin').attr('disabled', false)

  #       if err
  #         throw err unless err instanceof Batman.ErrorsSet
  #       else
  #         BatmanRailsCheckin.flashSuccess "Checkin updated successfully!"
  #         @redirect '/checkins'

  # # not routable, an event
  # destroy: (node, event, context) ->
  #   context.get('checkin').destroy (err) =>
  #     if err
  #       throw err unless err instanceof Batman.ErrorsSet

  #   _.find( @get('days'), (day) ->
  #     context.get('checkin').get('date') is day.get('date')
  #   ).decrementCheckinCount()

  #   @get('checkins').remove(context.get('checkin'))
  #   BatmanRailsCheckin.flashSuccess "Checkin deleted successfully!"


