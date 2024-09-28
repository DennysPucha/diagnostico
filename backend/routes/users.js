import { Router } from 'express'
import User from '../app/controller/User.js'
const router = Router()

const userController = new User()

/* GET users listing. */
router.get('/', userController.getUsers)
router.get('/:id', userController.getUserById)
router.post('/', userController.createUser)

export default router
