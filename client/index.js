import React, { Component } from 'react'
import { render } from 'react-dom'

class App extends Component {
  state = {
    notes: [],
    note: '',
    loading: false
  }

  componentDidMount () {
    this.setState({ loading: true })

    fetch('http://127.0.0.1/server/api/v1/notes')
      .then(res => res.json())
      .then(res => {
        const notes = res
        const loading = false

        this.setState({ notes, loading })
      })
  }

  handleNoteChange = (note) => {
    return this.setState({ note })
  }

  handleNoteSubmit = (e) => {
    e.preventDefault()

    this.setState({ loading: true })
    const method = 'POST'
    const headers = { 'Accept': 'application/json', 'Content-Type': 'application/json' }
    const body = JSON.stringify({ body: this.state.note })

    fetch("http://127.0.0.1/server/api/v1/notes", { method, headers, body })
      .then((res) => res.json())
      .then((data) => this.setState({ notes: data, loading: false }))
  }

  render () {
    const { loading, notes, note } = this.state

    if (loading) return <div>...loading</div>

    return (
      <div>
        <h1>Notes App</h1>
        <ul>
          {notes.map(({ body, id }) => (
            <li key={id}>{body}</li>
          ))}
        </ul>

        <form onSubmit={this.handleNoteSubmit}>
          <label>
            Name:
            <input
              type="text"
              value={note}
              onChange={e => this.handleNoteChange(e.target.value)}
            />
          </label>
          <input type="submit" value="Submit" />
        </form>
      </div>
    )
  }
}

render(<App/>, document.getElementById('root'))