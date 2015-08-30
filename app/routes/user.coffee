`import Ember from 'ember'`

Route = Ember.Route.extend
  model: (params) ->
    @store.query('user', params.user_id)

`export default Route`
