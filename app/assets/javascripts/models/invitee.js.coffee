class BatmanRailsCheckin.Invitee extends Batman.Model
  @resourceName: 'invitee'
  @storageKey: 'invitees'

  @belongsTo 'project',
    autoload: false

  @persist Batman.RailsStorage

  @urlNestsUnder 'project'

  # fields
  @encode "email"
