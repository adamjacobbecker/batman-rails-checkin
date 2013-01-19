class BatmanRailsCheckin.User extends Batman.Model
  @hasMany 'checkins',
    saveInline: false
    autoload: false

  @resourceName: 'user'
  @storageKey: 'users'

  @persist Batman.RailsStorage

  # fields
  @encode "email", "name", "password", "gravatar_url"

  @encode "latest_checkin",
    decode: (x) ->
      new BatmanRailsCheckin.Checkin(x)

  # validations
  @validate "email", presence: true

  @accessor 'route', ->
    '/checkins/by_user/' + @get('id')

  @accessor 'status', ->
    return "offline" if !@get('latest_checkin').get('created_at')

    latest = moment(@get('latest_checkin').get('created_at'))

    if latest > moment().subtract('days', 1)
      "available"
    else if latest > moment().subtract('days', 2)
      "away"
    else
      "offline"
