class BatmanRailsCheckin.UsersController extends BatmanRailsCheckin.BaseController
  routingKey: 'users'

  show: (params) ->
    @authenticated =>
      @withProject params.projectId, =>

        user = new BatmanRailsCheckin.User {id: params.id, project_id: params.projectId}
        user.load (err, user) =>
          @set 'user', user

          user.get('checkins').load (err, checkins) =>
            @set 'checkins', checkins

        @render source: "shared/checkins"

