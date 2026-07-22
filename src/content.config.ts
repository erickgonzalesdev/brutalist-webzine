import { defineCollection, z } from "astro:content";
import { glob } from "astro/loaders";

const articles = defineCollection({
  loader: glob({ pattern: "**/*.mdx", base: "./src/content/articles" }),
  schema: z.object({
    title: z.string(),
    author: z.string(),
    issue: z.string(),
    date: z.string(),
    order: z.number(),
    heroImage: z.string(),
    articleImage: z.string(),
    articleImageCaption: z.string().optional(),
  }),
});

export const collections = { articles };
