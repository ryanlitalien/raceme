`import Ember from 'ember'`

Component = Ember.Component.extend
  miles: [1..13]
  sortProperties: ['age', 'fiveKPace']
  sortAscending: true
  arrangedContent: Ember.computed.sort 'content', 'sortProperties'

  flipped: false
  toggleAge: false
  toggleFirst: true
  toggleLast: true
  toggleFiveKPace: false
  toggleTotalTime: false

  sortByDesc: (prop) ->
    if @get(prop) then '' else 'desc'

  actions:
    # You could meta these actions
    sortAge: ->
      @set 'sortProperties', ["age:#{@sortByDesc 'toggleAge'}"]
      @toggleProperty 'toggleAge'
    sortFirst: ->
      @set 'sortProperties', ["first:#{@sortByDesc 'toggleFirst'}"]
      @toggleProperty 'toggleFirst'
    sortLast: ->
      @set 'sortProperties', ["last:#{@sortByDesc 'toggleLast'}"]
      @toggleProperty 'toggleLast'
    sortFiveKPace: ->
      @set 'sortProperties', ["fiveKPace:#{@sortByDesc 'toggleFiveKPace'}"]
      @toggleProperty 'toggleFiveKPace'
    sortTotalTime: ->
      @set 'sortProperties', ["totalTime:#{@sortByDesc 'toggleTotalTime'}"]
      @toggleProperty 'toggleTotalTime'

    save5k: ->
      for user in @get('arrangedContent')
        if user.age >= 50
          pace = moment(user.get('tempFiveKPace'), 'mm:ss').add(1, 'minutes').format('mm:ss')
        else
          pace = user.get('tempFiveKPace')

        user.set('fiveKPace', pace)

        user.save().then ->
          console.log 'User Success'
        , (error) ->
          console.log "User Error: #{error}"

`export default Component`
