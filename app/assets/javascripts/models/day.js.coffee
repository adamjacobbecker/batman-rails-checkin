class BatmanRailsCheckin.Day extends Batman.Model
  @hasMany 'checkins'

  @belongsTo 'project'

  @resourceName: 'day'
  @storageKey: 'days'

  @primaryKey: 'date'

  @persist Batman.RailsStorage

  @urlNestsUnder 'project'

  # fields
  @encode "date", "checkin_count", "project_id"

  @accessor 'route', ->
    if @get('date') is moment().format('YYYY-MM-DD')
      "/projects/#{@get('project_id')}"
    else
      "/projects/#{@get('project_id')}/checkins/by_date/#{@get('date')}"

  @accessor 'date_pretty', ->
    switch @get('date')
      when moment().format('YYYY-MM-DD') then "Today"
      when moment().subtract('days', 1).format('YYYY-MM-DD') then "Yesterday"
      else moment(@get('date')).format('dddd, MMM DD')

  decrementCheckinCount: ->
    @set 'checkin_count', @get('checkin_count') - 1