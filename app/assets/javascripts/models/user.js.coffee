class BatmanRailsCheckin.User extends Batman.Model
  @resourceName: 'user'
  @storageKey: 'users'

  @hasMany 'checkins',
    autoload: true
    saveInline: false

  @belongsTo 'project',
    autoload: false

  @primaryKey: 'projects_users_id'

  @persist Batman.RailsStorage

  @urlNestsUnder 'project'

  # fields
  @encode "user_id", "email", "name", "gravatar_url", "project_id"

  @encode "latest_checkin",
    decode: (x) ->
      new BatmanRailsCheckin.Checkin(x)

  # validations
  @validate "email", presence: true

  @accessor 'route', ->
      "/projects/#{@get('project_id')}/checkins/by_user/#{@get('id')}"

  @accessor 'status', ->
    return "offline" if !@get('latest_checkin')?.get('created_at')

    latest = moment(@get('latest_checkin').get('created_at'))

    if latest > moment().subtract('days', 1)
      "available"
    else if latest > moment().subtract('days', 2)
      "away"
    else
      "offline"
