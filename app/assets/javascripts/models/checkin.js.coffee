class BatmanRailsCheckin.Checkin extends Batman.Model
  @belongsTo 'user',
    autoload: false

  @resourceName: 'checkin'
  @storageKey: 'checkins'

  @persist Batman.RailsStorage

  # fields
  @encode "body", "body_html", "date", "date_slashes", "date_pretty", "time_pretty",

  @encode "created_at", "RailsDate"

  @encode "user_id", ->
    null

  # validations
  @validate "body", presence: true

  @accessor 'dateRoute', ->
    if @get('date_pretty') is "Today"
      '/'
    else
      '/checkins/by_date/' + @get('date')

  @accessor 'firstGetDone', ->
    lines = @get('body').split("\n")

    for line, i in lines
      if line.match /Get Done/i then return lines[i + 1]

    return lines[0]