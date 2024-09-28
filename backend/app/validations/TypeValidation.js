import z from 'zod'

export const TypeValidation = z.object({
  name: z.string()
})
