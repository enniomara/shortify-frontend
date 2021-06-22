// Fake the endpoint so that it looks like the shortify endpoint
// {
//     "entries": [{
//         "name": "abc"
//     }]
// }

let faker = require('faker')
module.exports = () => {
    const data = { entries: [] }
    for (let i =0; i < 50; i++) {
        data.entries.push({
            "name": faker.random.word()
        })
    }
    return data
}
