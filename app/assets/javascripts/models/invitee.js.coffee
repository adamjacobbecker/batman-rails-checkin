class BatmanRailsCheckin.Invitee extends Batman.Model
  @belongsTo 'project',
    autoload: false

  @resourceName: 'invitee'
  @storageKey: 'invitees'

  @persist Batman.RailsStorage

  @urlNestsUnder 'project'

  # fields
  @encode "email"
