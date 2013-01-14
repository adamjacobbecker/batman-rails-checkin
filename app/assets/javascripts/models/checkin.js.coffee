class BatmanRailsCheckin.Checkin extends Batman.Model
  @resourceName: 'checkin'
  @storageKey: 'checkins'

  @persist Batman.RailsStorage

  # fields
  @encode "body", "date"

  # validations
  @validate "body", presence: true
