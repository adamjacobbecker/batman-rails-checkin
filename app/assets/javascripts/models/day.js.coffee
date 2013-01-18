class BatmanRailsCheckin.Day extends Batman.Model
  @hasMany 'checkins'

  @resourceName: 'day'
  @storageKey: 'days'

  @primaryKey: 'date'

  @persist Batman.RailsStorage

  # fields
  @encode "date", "checkin_count"

  @accessor 'route', ->
    if @get('date') is moment().format('YYYY-MM-DD')
      '/'
    else
      '/checkins/by_date/' + @get('date')

  @accessor 'date_pretty', ->
    switch @get('date')
      when moment().format('YYYY-MM-DD') then "Today"
      when moment().subtract('days', 1).format('YYYY-MM-DD') then "Yesterday"
      else moment(@get('date')).format('dddd, MMM DD')

  decrementCheckinCount: ->
    @set 'checkin_count', @get('checkin_count') - 1