import prisma from '../../utils/PrismaClient.js'
import { UserValidation } from '../validations/UserValidation.js'
import { LoginValidation } from '../validations/LoginValidation.js'
class User {
  async login (req, res) {
    try {
      const validations = LoginValidation.safeParse(req.body)
      if (!validations.success) {
        // Extraemos el primer mensaje de error desde issues
        const firstErrorMessage = validations.error.issues[0]?.message || 'Validation error'

        return res.status(400).json({
          code: 400,
          msg: firstErrorMessage
        })
      }

      const { email, password } = validations.data

      const user = await prisma.user.findFirst({
        where: {
          email,
          password
        }
      })

      if (!user) {
        return res.status(404).json({ code: 404, msg: 'User not found' })
      }

      return res.status(200).json({ code: 200, msg: 'User logged in' })
    } catch (error) {
      return res.status(500).json({ code: 500, msg: error.message })
    }
  }

  async getUsers (req, res) {
    try {
      const users = await prisma.user.findMany()
      return res.status(200).json({ code: 200, users })
    } catch (error) {
      return res.status(500).json({ error: error.message })
    }
  }

  async getUserById (req, res) {
    const { id } = req.params
    try {
      const user = await prisma.user.findUnique({
        where: {
          id: parseInt(id)
        }
      })
      if (!user) return res.status(404).json({ code: 404, error: 'User not found' })

      return res.status(200).json(user)
    } catch (error) {
      return res.status(500).json({ error: error.message })
    }
  }

  async createUser (req, res) {
    try {
      const validations = UserValidation.safeParse(req.body)
      if (!validations.success) {
        return res.status(400).json({ code: 400, error: validations.error })
      }

      const { name, email, password } = validations.data

      const emailAlreadyExists = await prisma.user.findFirst({
        where: {
          email
        }
      })

      if (emailAlreadyExists) {
        return res.status(400).json({ code: 400, error: 'Email already exists' })
      }

      await prisma.user.create({
        data: {
          name,
          email,
          password
        }
      })

      return res.status(201).json({ code: 201, msg: 'User created' })
    } catch (error) {
      return res.status(500).json({ error: error.message })
    }
  }
}
export default User
