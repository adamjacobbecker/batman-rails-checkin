class BatmanRailsCheckin.Project extends Batman.Model
  @hasMany 'checkins',
    saveInline: false
    autoload: false

  @hasMany 'users'

  @hasMany 'days'

  @resourceName: 'project'
  @storageKey: 'projects'

  @persist Batman.RailsStorage

  # fields
  @encode "name"

  @accessor 'route', ->
    '/projects/' + @get('id')

  @accessor 'newCheckinRoute', ->
    "/projects/#{@get('id')}/checkins/new"