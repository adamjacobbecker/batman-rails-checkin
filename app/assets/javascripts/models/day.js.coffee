class BatmanRailsCheckin.Day extends Batman.Model
  @hasMany 'checkins'

  @resourceName: 'day'
  @storageKey: 'days'

  @primaryKey: 'date'

  @persist Batman.RailsStorage

  # fields
  @encode "date", "checkin_count", "date_pretty", "date_slashes"

  @accessor 'route', ->
    if @get('date_pretty') is "Today"
      '/'
    else
      '/checkins/by_date/' + @get('date')

  decrementCheckinCount: ->
    @set 'checkin_count', @get('checkin_count') - 1