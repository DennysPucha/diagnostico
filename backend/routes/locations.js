import { Router } from 'express'
import Location from '../app/controller/Location.js'
const router = Router()

const locationController = new Location()

router.get('/', locationController.getLocations)
router.get('/:param', locationController.getLocation)
router.post('/', locationController.saveLocation)

export default router
