import { Router } from 'express'
import Type from '../app/controller/Type.js'
const router = Router()

const typeController = new Type()

router.get('/', typeController.getTypes)
router.get('/:id', typeController.getTypeById)
router.post('/', typeController.saveType)

export default router
