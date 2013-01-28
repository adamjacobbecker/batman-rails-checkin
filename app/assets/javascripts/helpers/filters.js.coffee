Batman.mixin Batman.Filters,
  momentFormatDateVerbose: (value) ->
    moment(value).format("\\a\\t h:mma \\o\\n M/D/YY")

  momentFormatDate: (value) ->
    moment(value).format("M/D/YY")

  checkinify: (value) ->
    $node = $("<div>"+value+"</div>")

    $getDone = $node.find("h4:contains('Get Done')").next("p")
    $gotDone = $node.find("h4:contains('Got Done')").next("p")
    $flags = $node.find("h4:contains('Flags')").next("p")
    $shelf = $node.find("h4:contains('Shelf')").next("p")

    newGetDoneHtml = ""
    for getDone in $getDone.text().split('\n')
      newGetDoneHtml += "<li><span>&rarr;</span> #{getDone}</li>"
    $getDone.replaceWith("<ul class='get-done'>#{newGetDoneHtml}</ul>")

    newGotDoneHtml = ""
    for gotDone in $gotDone.text().split('\n')
      newGotDoneHtml += "<li><span>&check;</span> #{gotDone}</li>"
    $gotDone.replaceWith("<ul>#{newGotDoneHtml}</ul>")

    newFlagsHtml = ""
    for flag in $flags.text().split('\n')
      newFlagsHtml += "<li>#{flag}</li>"
    $flags.replaceWith($flags = $("<ul>#{newFlagsHtml}</ul>"))

    $flags.find("li").each ->
      if matches = $(@).html().match(/^([R|Y|G])\:\s/i)
        $(@).html $(@).html().replace /^([R|Y|G])\:\s/i, "<i class='icon-flag flag-#{matches[1].toUpperCase()}'></i>"

    newShelfHtml = ""
    for shelfItem in $shelf.text().split('\n')
      newShelfHtml += "<li>#{shelfItem}</li>"
    $shelf.replaceWith("<ul>#{newShelfHtml}</ul>")

    html = $node.html()
    $node.remove()
    html
