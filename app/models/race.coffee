`import DS from 'ember-data'`

attr = DS.attr()

Race = DS.Model.extend
  name: attr
  zipCode: attr
  raceLength: 13

  users: DS.hasMany 'user', async: true

`export default Race`
