class BatmanRailsCheckin.Day extends Batman.Model
  @hasMany 'checkins',
    autoload: false

  @resourceName: 'day'
  @storageKey: 'days'

  @primaryKey: 'date'

  @persist Batman.RailsStorage

  # fields
  @encode "date", "checkin_count", "date_pretty"

  @accessor 'route', ->
    if @get('date_pretty') is "Today"
      '/'
    else
      '/checkins/by_date/' + @get('date')