`import Ember from 'ember'`

Route = Ember.Route.extend

  model: (params) ->
    Ember.RSVP.hash
      race: @store.find('race', params.race_id)
      # Only show 30 of the race users for now
      users: @store.find('race', params.race_id).then (race) ->
        race.get('users').then (users) -> users.slice(0, 30)

  setupController: (controller, model) ->
    controller.set 'model', model.race
    controller.set 'model.users', model.users

`export default Route`
