import { combineReducers } from 'redux'
import {
  RECEIVE_ENTRIES

} from '../actions'

const initialState = {
  shortify_entries: [],
  last_updated: -1
}

const entries = (state = initialState, action) => {
  switch (action.type) {
    case RECEIVE_ENTRIES:
      return {
        ...state,
        shortify_entries: action.entries,
        last_updated: action.receivedAt,
      }
    default:
      return state
  }
}

const rootReducer = combineReducers({
  entries
})

export default rootReducer
