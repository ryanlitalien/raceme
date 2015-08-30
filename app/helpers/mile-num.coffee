`import Ember from 'ember'`

mileNum = (index) ->
  # Add one because of indexing at 0
  "mile#{index[0] + 1}"

MileNumHelper = Ember.Helper.helper mileNum

`export { mileNum }`

`export default MileNumHelper`
