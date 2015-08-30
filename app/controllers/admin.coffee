`import Ember from 'ember'`

Controller = Ember.Controller.extend

  raceData: '[{"name":"San Francisco Marathon","zipCode":"94110"},{"name":"Boston Marathon","zipCode":"02111"},{"name":"NYC Marathon","zipCode":"10001"}]'

  actions:
    addUser: (first, last) ->
      # Create the user
      user = @store.createRecord 'user',
        first: first
        last: last
        age: 20
        fiveKPace: '09:00'
        zipCode: ['94110', '10001', '02111'][Math.floor(Math.random() * 3)]

      # Save the user
      user.save().then (user) ->
        alert "Saved user: #{user.get('first')} #{user.get('last')} with random age + zipCode"
      , (error) ->
        console.log "Error: #{error}"

    loadRaces: (data) ->
      races = JSON.parse(data)
      for race in races
        race = @store.createRecord 'race',
          name: race.name
          zipCode: race.zipCode

        race.save().then ->
          console.log 'Race Success'
        , (error) ->
          console.log "Race Error: #{error}"

`export default Controller`
