class BatmanRailsCheckin.UsersController extends BatmanRailsCheckin.BaseController
  routingKey: 'users'

  index: (params) ->
    @authenticated =>
      @unset 'user'
      @withProject params.projectId, =>
        @get('project').get('checkins').load (err, checkins) =>
          @set 'checkins', checkins

        @render source: "shared/checkins"


  show: (params) ->
    @authenticated =>
      @withProject params.projectId, =>

        user = new BatmanRailsCheckin.User {id: params.id, project_id: params.projectId}
        user.load (err, user) =>
          @set 'user', user
          @set 'checkins', user.get('checkins')

        @render source: "shared/checkins"

