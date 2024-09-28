import z from 'zod'

export const LocationValidation = z.object({
  latitude: z.string().regex(/^-?([1-8]?[1-9]|[1-9]0)\.{1}\d{1,6}/),
  longitude: z.string().regex(/^-?([1-8]?[1-9]|[1-9]0)\.{1}\d{1,6}/),
  typeId: z.number().int()
})
