import { z, defineCollection } from "astro:content";

export const collections = {
  home: defineCollection({
    schema: z.object({
      title: z.string(),
      description: z.string(),
    }),
  }),
  blog: defineCollection({
    schema: z.object({
      title: z.string(),
      publicationDate: z.date(),
      description: z.string(),
      workInProgress: z.boolean().default(false),
    }),
  }),
};
