class BatmanRailsCheckin.LatestCheckinView extends Batman.View

  ready: ->
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
      $root.find("ul.get-done li").click ->
        insertGotDone($(@).text().substr(2))

      $root.find("ul.get-done li").mouseover ->
        $(@).html "&larr; " + $(@).text().substr(2)

      $root.find("ul.get-done li").mouseout ->
        $(@).html "&rarr; " + $(@).text().substr(2)

    , 100