class BatmanRailsCheckin.User extends Batman.Model
  @resourceName: 'user'
  @storageKey: 'users'

  @persist Batman.RailsStorage

  # fields
  @encode "email", "password", "latest_checkin"

  # validations
  @validate "email", presence: true
