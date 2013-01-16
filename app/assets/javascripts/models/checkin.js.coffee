class BatmanRailsCheckin.Checkin extends Batman.Model
  @belongsTo 'user',
    autoload: false

  @resourceName: 'checkin'
  @storageKey: 'checkins'

  @persist Batman.RailsStorage

  # fields
  @encode "body", "date"

  # validations
  @validate "body", presence: true
