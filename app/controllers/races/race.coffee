`import Ember from 'ember'`

Controller = Ember.Controller.extend
  userCounter: 0
  mileCounter: 1

  sortedUsers: Ember.computed ->
    @get('model').get('users').sortBy('fiveKPace')

  raceLength: Ember.computed ->
    @get('model').get('raceLength')

  raceFinished: Ember.computed 'userCounter', 'mileCounter', ->
    if @get('userCounter') == 9 && @get('mileCounter') == 13
      alert 'Race done, congrats all athletes!'

  raceDidChange: Ember.observer 'model', ->
    @resetCounters()

  resetCounters: ->
    @set('userCounter', 0)
    @set('mileCounter', 1)

  updateUser: (user, index) ->
    seconds = Math.round(Math.random()*60) + 1
    newMile = moment(user.get('fiveKPace'), "mm:ss").add(1, 'minutes').add(seconds, 'seconds').format('mm:ss')
    user.set("mile#{index}", newMile)
    #user.save().then ->
      #console.log "SAVED | mile#{index}: #{newMile} | #{user.get('first')}"

  increment: ->
    race = @get('model')
    userCounter = @get('userCounter')
    mileCounter = @get('mileCounter')
    sortedUsers = race.get('users').sortBy('fiveKPace')

    if mileCounter < 14 && userCounter <= sortedUsers.length
      user = sortedUsers.objectAt(userCounter)
      if user
        @updateUser(user, mileCounter)
        @set('userCounter', userCounter + 1)
      if @get('userCounter') == sortedUsers.length
        @set('userCounter', 0)
        @set('mileCounter', mileCounter + 1)
    else
      alert 'Race done, congrats all athletes!'

  startRace: (modifier) ->
    for index in [1..(@get('raceLength') * @get('sortedUsers').length)]
      Ember.run.later =>
        @increment()
      , index * modifier

  actions:
    startSlowRace: ->
      @startRace 100

    startFastRace: ->
      @startRace 20

    resetRace: ->
      @resetCounters()
      sortedUsers = @get('model').get('users').sortBy('fiveKPace')
      for index in [1..@get('model').get('raceLength')]
        sortedUsers.forEach (user) =>
          user.set("mile#{index}", '')
          #user.save().then -> console.log "RESET | mile: #{index} | #{user.get('fullName')}"

    loadUsers: ->
      # Get the users controller and it's userData
      userList = @controllerFor('users').get('userData')
      users = JSON.parse(userList)
      race = @get('model')

      for user in users
        if user.zipCode == race.get('zipCode')
          user = @store.createRecord 'user',
            first: user.first
            last: user.last
            zipCode: user.zipCode
            age: user.age

          race.get('users').addObject(user)

          user.save().then ->
            console.log 'User Success'
            race.save().then ->
              console.log 'Race Success'
            , (error) ->
              console.log "Race Error: #{error}"
          , (error) ->
            console.log "User Error: #{error}"

`export default Controller`
