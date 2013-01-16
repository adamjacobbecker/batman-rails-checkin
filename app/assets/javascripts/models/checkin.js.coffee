class BatmanRailsCheckin.Checkin extends Batman.Model
  @belongsTo 'user',
    autoload: false

  @resourceName: 'checkin'
  @storageKey: 'checkins'

  @persist Batman.RailsStorage

  # fields
  @encode "body", "body_html", "date", "date_slashes", "date_pretty", "time_pretty"

  # validations
  @validate "body", presence: true

  @accessor 'dateRoute', ->
    if @get('date_pretty') is "Today"
      '/'
    else
      '/checkins/by_date/' + @get('date')