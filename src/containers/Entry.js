import React, { Component } from 'react'
import PropTypes from 'prop-types'


class Entry extends Component {
    static propTypes = {
        name: PropTypes.string.isRequired
    }

    render() {
        const { name } = this.props
        let url = `https://localhost/${name}`
        return (
            <div>
                <a href={url}>{name}</a>
            </div>
        )
    }
}

export default Entry
