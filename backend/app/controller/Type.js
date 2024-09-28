import prisma from '../../utils/PrismaClient.js'
import { TypeValidation } from '../validations/TypeValidation.js'
class Type {
  async getTypes (req, res) {
    try {
      const types = await prisma.type.findMany()
      return res.status(200).json({ code: 200, types })
    } catch (error) {
      return res.status(500).json({ error: error.message })
    }
  }

  async getTypeById (req, res) {
    const { id } = req.params
    try {
      const type = await prisma.type.findUnique({
        where: {
          id: parseInt(id)
        }
      })
      if (!type) return res.status(404).json({ code: 404, error: 'Type not found' })

      return res.status(200).json(type)
    } catch (error) {
      return res.status(500).json({ error: error.message })
    }
  }

  async saveType (req, res) {
    try {
      const validations = TypeValidation.safeParse(req.body)
      if (!validations.success) {
        return res.status(400).json({ code: 400, error: validations.error })
      }

      const { name } = validations.data

      const typeAlreadyExists = await prisma.type.findFirst({
        where: {
          name
        }
      })

      if (typeAlreadyExists) {
        return res.status(400).json({ code: 400, error: 'Type already exists' })
      }

      await prisma.type.create({
        data: {
          name
        }
      })

      return res.status(201).json({ code: 201, msg: 'Type created' })
    } catch (error) {
      return res.status(500).json({ error: error.message })
    }
  }
}

export default Type
