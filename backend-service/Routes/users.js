import express from 'express'
const router = express.Router()

import { usersController } from '../Controllers/index.js'

router.get('/', usersController.getAll)

export default router
