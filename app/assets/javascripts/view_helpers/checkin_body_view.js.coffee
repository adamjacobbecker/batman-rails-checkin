class BatmanRailsCheckin.CheckinBodyView extends Batman.View

  ready: ->
    $node = $(@get('node'))

    $getDone = $node.find("h4:contains('Get Done')").next("p")
    $gotDone = $node.find("h4:contains('Got Done')").next("p")
    $flags = $node.find("h4:contains('Flags')").next("p")
    $shelf = $node.find("h4:contains('Shelf')").next("p")

    newGetDoneHtml = ""
    for getDone in $getDone.text().split('\n')
      newGetDoneHtml += "<li><span>&rarr;</span> #{getDone}</li>"
    $getDone.replaceWith("<ul>#{newGetDoneHtml}</ul>")

    newGotDoneHtml = ""
    for gotDone in $gotDone.text().split('\n')
      newGotDoneHtml += "<li><span>&check;</span> #{gotDone}</li>"
    $gotDone.replaceWith("<ul>#{newGotDoneHtml}</ul>")

    newFlagsHtml = ""
    for flag in $flags.text().split('\n')
      newFlagsHtml += "<li>#{flag}</li>"
    $flags.replaceWith($flags = $("<ul>#{newFlagsHtml}</ul>"))

    $flags.find("li").each ->
      $(@).html $(@).html().replace(/^([R|Y|G])\:\s/, "<i class='icon-flag flag-$1'></i>")

    newShelfHtml = ""
    for shelfItem in $shelf.text().split('\n')
      newShelfHtml += "<li>#{shelfItem}</li>"
    $shelf.replaceWith("<ul>#{newShelfHtml}</ul>")
