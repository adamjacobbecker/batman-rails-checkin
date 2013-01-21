class BatmanRailsCheckin.NewCollaboratorFormView extends Batman.View

  ready: ->
    $node = $(@get('node'))

    typeaheadTimeout = undefined

    $node.find("input").typeahead
      source: (query, process) ->
        typeaheadTimeout ||= setTimeout ->
          $.ajax
            url: "/users/typeahead.json"
            data:
              query: query
            success: (data) ->
              typeaheadTimeout = null
              return process(data.users)
        , 200

      minLength: 3
