class BatmanRailsCheckin.CheckinsController extends BatmanRailsCheckin.BaseController
  routingKey: 'checkins'

  new: (params) ->
    @authenticated =>
      @withProject params.projectId, =>
        BatmanRailsCheckin.set 'pageTitle', 'New Checkin'
        @set 'checkin', new BatmanRailsCheckin.Checkin
          project_id: params.projectId
          user_id: BatmanRailsCheckin.get('currentUser').get('id')
          created_at: new Date().toISOString()
          body: """
            #### Get Done


            #### Got Done


            #### Flags


            #### Shelf

          """

        @unset 'latest_checkin'

        myUserForThisProject = new BatmanRailsCheckin.User(projects_users_id: "" + BatmanRailsCheckin.get('currentUser').get('user_id') + "_" + params.projectId, project_id: params.projectId)
        myUserForThisProject.load (err, user) =>
          @set 'latest_checkin', user.get('checkins').get('first')

        @form = @render()

  create: (params) ->
    @authenticated =>
      @get('checkin').save (err) =>
        $('#new_checkin').attr('disabled', false)

        if err
          throw err unless err instanceof Batman.ErrorsSet
        else
          BatmanRailsCheckin.flashSuccess "Checkin created successfully!"
          @get('project').get('users').load ->
          @redirect "/projects/#{@get('project').get('id')}/users"
