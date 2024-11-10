import 'dotenv/config'
import express from 'express'
import cors from 'cors'


const server = express()

server.use(express.json())
server.use(express.urlencoded({ extended: false }))

server.use(cors())

server.use((req, res, next) => {
    res.setHeader('Access-Controll-Allow-Origin', '*')
    res.setHeader('Access-Controll-Allow-Headers', 'Origin,X-Requested-with,Content,Accept,Content-Type,Authorization')
    res.setHeader('Access-Controll-Allow-Methods', 'GET, POST,PUT,DELETE,HEAD,PATCH')
    next()
})

server.get('/', (req, res) => {
    res.status(200).json({
        message: 'Server is Working !',
    })
})

import { usersRoutes } from './Routes/index.js'
import { signUpRoutes } from './Routes/index.js'
import { loginRoutes } from './Routes/index.js'

server.use('/users', usersRoutes)
server.use('/signUp', signUpRoutes)
server.use('/login', loginRoutes)

const PORT = process.env.PORT || 3000

server.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
})

export default server
