class BatmanRailsCheckin.Project extends Batman.Model
  @hasMany 'checkins',
    saveInline: false
    autoload: false

  @hasMany 'users',
    saveInline: false

  @resourceName: 'project'
  @storageKey: 'projects'

  @persist Batman.RailsStorage

  # fields
  @encode "name", "owner_id", "campfire_subdomain", "campfire_token", "campfire_room"

  @accessor 'route', ->
    '/projects/' + @get('id')

  @accessor 'newCheckinRoute', ->
    "/projects/#{@get('id')}/checkins/new"