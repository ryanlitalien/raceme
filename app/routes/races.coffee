`import Ember from 'ember'`

Route = Ember.Route.extend
  model: (params) ->
    @store.findAll('race')

`export default Route`
