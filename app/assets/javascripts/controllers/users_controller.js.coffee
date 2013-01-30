class BatmanRailsCheckin.UsersController extends BatmanRailsCheckin.BaseController
  routingKey: 'users'

  index: (params) ->
    @authenticated =>
      @unset 'user'
      @withProject params.projectId, =>
        @set 'paginator', new Batman.ModelPaginator {model: @get('project.checkins'), limit: 10}
        @set 'currentPosition', 1
        @_updatePagination(params)

        @render source: "shared/checkins"

  nextPage: ->
    @set('currentPosition', @get('currentPosition') + 10)
    @_updatePagination()

  previousPage: ->
    @set('currentPosition', @get('currentPosition') - 10)
    @_updatePagination()

  show: (params) ->
    @authenticated =>
      @withProject params.projectId, =>

        user = new BatmanRailsCheckin.User {id: params.id, project_id: params.projectId}
        user.load (err, user, env) =>
          @set 'user', user
          @set 'checkins', user.get('checkins')

        @render source: "shared/checkins"


  _updatePagination: (params) ->
    @set 'checkins', @get('project.checkins')

    @get('paginator').loadItemsForOffsetAndLimit (@get('currentPosition') - 1), 10, (error, checkins, env) =>
      @set 'totalCount', env.response.meta.total

    @get('paginator').observe 'cache.items', (newValue,oldValue) =>
      console.log 'hi', newValue, oldValue
      @set 'checkins', newValue
      @set('endingPosition',@get('currentPosition') + newValue.length - 1)
