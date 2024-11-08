import 'dotenv/config'
import express from 'express'
import cors from 'cors'

const server = express()

server.use(express.json)
server.use(express.urlencoded({ extended: false }))
var corsOptions = {
    origin: 'http://localhost:3000',
    methods: 'GET,HEAD,PUT,PATCH,POST,DELETE',
}
server.use(cors(corsOptions))

// server.use((req, res, next) => {
//     res.setHeader('Access-Controll-Allow-Origin', '*')
//     res.setHeader('Access-Controll-Allow-Headers', 'Origin,X-Requested-with,Content,Accept,Content-Type,Authorization')
//     res.setHeader('Access-Controll-Allow-Methods', 'GET, POST,PUT,DELETE,HEAD,PATCH')
//     next()
// })

server.get('./', (req, res) => {
    res.status(200).json({
        message: 'Server is Working !',
    })
})

server.listen(process.env.PORT, (error) => {
    if (!error) {
        console.log('http://localhost:' + process.env.PORT)
    } else {
        console.log("Error occurred, server can't start", error)
    }
})

export default server
