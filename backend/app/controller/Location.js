import prisma from '../../utils/PrismaClient.js'
import { LocationValidation } from '../validations/LocationValidation.js'
import { cleanLocation } from '../cleanModels/cleanLocation.js'
class Location {
  async getLocations (req, res) {
    try {
      const locations = await prisma.location.findMany({
        include: {
          type: true
        }
      })

      const cleanLocations = await Promise.all(locations.map(async location => {
        return await cleanLocation(location)
      }))

      return res.status(200).json({ code: 200, cleanLocations })
    } catch (error) {
      return res.status(500).json({ error: error.message })
    }
  }

  async getLocationById (req, res) {
    const { id } = req.params
    try {
      const location = await prisma.location.findUnique({
        where: {
          id: parseInt(id)
        }
      })
      if (!location) return res.status(404).json({ code: 404, error: 'Location not found' })

      return res.status(200).json(location)
    } catch (error) {
      return res.status(500).json({ error: error.message })
    }
  }

  async saveLocation (req, res) {
    try {
      const validations = LocationValidation.safeParse(req.body)
      if (!validations.success) {
        return res.status(400).json({ code: 400, error: validations.error })
      }

      const { latitude, longitude, typeId } = validations.data

      const existsType = await prisma.type.findUnique({
        where: {
          id: typeId
        }
      })

      if (!existsType) {
        return res.status(400).json({ code: 400, error: 'Type not found' })
      }

      await prisma.location.create({
        data: {
          latitude,
          longitude,
          typeId
        }
      })

      return res.status(201).json({ code: 201, msg: 'Location created' })
    } catch (error) {
      return res.status(500).json({ error: error.message })
    }
  }
}
export default Location
