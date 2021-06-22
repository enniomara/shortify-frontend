import React, { Component } from 'react'
import PropTypes from 'prop-types'
import { connect } from 'react-redux'
import { fetchEntriesIfNeeded } from '../actions'
import Entry from './Entry'

class App extends Component {
  static propTypes = {
    dispatch: PropTypes.func.isRequired,
    entries: PropTypes.array.isRequired,
    last_updated: PropTypes.number
  }

  componentDidMount() {
    const { dispatch } = this.props

    dispatch(fetchEntriesIfNeeded())
  }

  render() {
    const { entries, last_updated } = this.props
    console.log(last_updated)
    return (
      <div>
        Last updated at: {last_updated}
        {
          entries.map((current, i) =>
            <Entry key={current.name} name={current.name} />
          )
        }
      </div>
    )
  }
}

const mapStateToProps = state => {
  const { entries } = state
  return {
    entries: entries.shortify_entries,
    last_updated: entries.last_updated
  }
}

export default connect(mapStateToProps)(App)
