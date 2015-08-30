`import Ember from 'ember'`
`import FirebaseAdapter from 'emberfire/adapters/firebase'`

`const { inject } = Ember`

Adapter = FirebaseAdapter.extend
  firebase: inject.service()

`export default Adapter`
