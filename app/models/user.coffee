`import Ember from 'ember'`
`import DS from 'ember-data'`

attr = DS.attr()

User = DS.Model.extend
  age: attr
  last: attr
  first: attr
  zipCode: attr
  fiveKPace: DS.attr('string')

  race: DS.belongsTo 'race', async: true

  fullName: Ember.computed 'first', 'last', ->
    "#{@get('first')} #{@get('last')}"

  initMiles: (->
    [1..13].forEach (mile) =>
      Ember.defineProperty @, "mile#{mile}", Ember.computed(->
        # "#{@.get('fiveKPace')} #{mile}"
        ''
      ).property('fiveKPace')
  ).on('init')

  totalTime: Ember.computed 'mile1', 'mile2', 'mile3', 'mile4', 'mile5', 'mile6', 'mile7', 'mile8', 'mile9', 'mile10', 'mile11', 'mile12', 'mile13', ->
    total = '00:00:00'
    [1..13].forEach (mile) =>
      mileTime = @get("mile#{mile}")
      if mileTime && mileTime.length > 0
        total = moment(moment(mileTime, "mm:ss").add(moment(total, "HH:mm:ss"))).format("HH:mm:ss")
    total

  tempFiveKPace: Ember.computed ->
    #9 min = 540, 8 min = 480, 7 min = 420, 6 min = 360, 5 min = 300
    pace = Math.ceil(Math.random() * 360) + 330
    moment().startOf('day').seconds(pace).format('mm:ss')

`export default User`
