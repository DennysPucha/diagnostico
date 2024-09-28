import { Router } from 'express'
import User from '../app/controller/User.js'

const userController = new User()
const router = Router()

/* GET home page. */
router.post('/', userController.login)

export default router
