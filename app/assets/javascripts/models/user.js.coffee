class BatmanRailsCheckin.User extends Batman.Model
  @hasMany 'checkins',
    autoload: false

  @resourceName: 'user'
  @storageKey: 'users'

  @persist Batman.RailsStorage

  # fields
  @encode "email", "password", "gravatar_url", "latest_checkin"

  # validations
  @validate "email", presence: true
