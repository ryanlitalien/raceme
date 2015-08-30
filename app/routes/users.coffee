`import Ember from 'ember'`

Route = Ember.Route.extend
  model: ->
    # Params are for Firebase
    @store.query 'user', limitToFirst: 10, orderBy: 'fiveKPace'

`export default Route`
