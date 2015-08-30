`import Ember from 'ember'`
`import config from './config/environment'`

Router = Ember.Router.extend
  location: config.locationType

Router.map ->
  @route 'users', ->
    @route 'user', path: '/:user_id'
  @route 'races', ->
    @route 'race', path: '/:race_id'
  @route 'admin'

`export default Router`
