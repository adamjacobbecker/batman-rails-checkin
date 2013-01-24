class BatmanRailsCheckin.LatestCheckinView extends Batman.View

  ready: ->
    $node = $(@get('node'))

    insertGotDone = (text) ->
      linesArray = $("#post_content").val().split(/\n/)
      newLinesArray = []

      for line in linesArray
        newLinesArray.push line
        newLinesArray.push(text) if line is "#### Got Done"

      newValue = newLinesArray.join("\n")

      $("#post_content").val newValue

    setTimeout =>
      $root = $(@get('node')).closest("#new-checkin")
      $node.on "click", "ul.get-done li", ->
        insertGotDone($(@).text().substr(2))

      $node.on "mouseover", "ul.get-done li", ->
        $(@).html "&larr; " + $(@).text().substr(2)

      $node.on "mouseout", "ul.get-done li", ->
        $(@).html "&rarr; " + $(@).text().substr(2)

    , 100