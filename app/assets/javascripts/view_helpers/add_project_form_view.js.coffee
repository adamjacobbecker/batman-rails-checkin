class BatmanRailsCheckin.AddProjectFormView extends Batman.View

  @::on 'appear', (node) ->
    $(node).find("input").focus()