import { z, defineCollection } from "astro:content";

export const collections = {
  blog: defineCollection({
    schema: ({ image }) => z.object({
      cover: image().refine((img) => img.width >= 1080, {
        message: "Cover image must be at least 1080 pixels wide!",
      }),
      coverAlt: z.string(),
      title: z.string(),
      publicationDate: z.date(),
      description: z.string(),
    }),
  }),
};
