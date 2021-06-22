export const REQUEST_ENTRIES = 'REQUEST_ENTRIES'
export const RECEIVE_ENTRIES = 'RECEIVE_ENTRIES'


export const receiveEntries = (json) => ({
  type: RECEIVE_ENTRIES,
  entries: json,
  receivedAt: Date.now()
})

const fetchEntries = () => dispatch => {
  return fetch('http://localhost:3031/entries')
    .then(response => response.json())
    .then(json => dispatch(receiveEntries(json)))
}

export const fetchEntriesIfNeeded = () => (dispatch, getState) => {
  return dispatch(fetchEntries("bla"))
}
