class BatmanRailsCheckin.Preference extends Batman.Model
  @resourceName: 'preference'
  @storageKey: 'preferences'

  @persist Batman.LocalStorage

  # fields
  @encode "sidebarViewBy"
