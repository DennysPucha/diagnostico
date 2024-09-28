import z from 'zod'

export const LoginValidation = z.object({
  email: z.string().email(),
  password: z.string().min(6).max(255)
})
