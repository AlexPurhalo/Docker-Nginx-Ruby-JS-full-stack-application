import React from 'react'
import { render } from 'react-dom'

const App = () => (
  <div>
    <h3>Rabotaet :)</h3>
    <p>My name is Alex and this is the test application</p>
  </div>
)

render(<App/>, document.getElementById('root'))