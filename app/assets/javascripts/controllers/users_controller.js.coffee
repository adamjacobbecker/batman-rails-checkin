class BatmanRailsCheckin.SimplePaginator extends Batman.Object
  page: 1
  perPage: 10

  @accessor 'totalResults'
  @accessor 'previousPageRoute'
  @accessor 'nextPageRoute'
  @accessor 'results'

  @accessor 'displayRange', ->
    if @get('totalResults')
      "#{(@page - 1)*@perPage+1}-#{Math.min(@page*@perPage, @get('totalResults'))}"

  constructor: (args) ->
    super(args)
    @page = if @params.page then parseInt(@params.page, 10) else 1
    @model.load {page: @page, per_page: @perPage}, (err, results, env) =>
      set = new Batman.Set
      set.add(record) for record in env.records
      @set 'results', set
      @set 'totalResults', env.response.meta.total

      if @get('totalResults') > (@page * @perPage)
        @set 'nextPageRoute', "#{@params.path}?page=#{@page + 1}"

      if @page > 1
        @set 'previousPageRoute', "#{@params.path}?page=#{@page - 1}"




class BatmanRailsCheckin.UsersController extends BatmanRailsCheckin.BaseController
  routingKey: 'users'

  index: (params) ->
    @authenticated =>
      @unset 'user'
      @withProject params.projectId, =>
        @set 'paginator', new BatmanRailsCheckin.SimplePaginator
          model: @get('project').get('checkins')
          params: params

        @render source: "shared/checkins"

  show: (params) ->
    @authenticated =>
      @withProject params.projectId, =>

        user = new BatmanRailsCheckin.User {id: params.id, project_id: params.projectId}
        user.load (err, user) =>
          @set 'user', user
          @set 'checkins', user.get('checkins')

        @render source: "shared/checkins"
