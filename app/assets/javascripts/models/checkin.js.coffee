class BatmanRailsCheckin.Checkin extends Batman.Model
  @belongsTo 'user',
    autoload: false

  @belongsTo 'project',
    autoload: false

  @resourceName: 'checkin'
  @storageKey: 'checkins'

  @persist Batman.RailsStorage

  @urlNestsUnder 'project'

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
    return if !@get('body')
    lines = @get('body').split("\n")
    getDoneFound = false

    for line, i in lines
      if line.match /Get Done/i then getDoneFound = true
      if getDoneFound and lines[i + 1] isnt ""
        return lines[i + 1]
      if lines[i + 1].match "####"
        return ""

    return lines[0]