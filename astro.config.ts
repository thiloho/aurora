import { defineConfig } from "astro/config";
import { rehypeHeadingIds } from "@astrojs/markdown-remark";
import rehypeAutolinkHeadings from "rehype-autolink-headings";
import svelte from "@astrojs/svelte";

// https://astro.build/config
export default defineConfig({
  site: "https://aurora.thilohohlt.com",
  compressHTML: true,
  scopedStyleStrategy: "class",
  markdown: {
    rehypePlugins: [
      rehypeHeadingIds,
      [
        rehypeAutolinkHeadings,
        {
          behavior: "wrap",
          properties: {
            class: "heading-linker",
          },
        },
      ],
    ],
  },
  integrations: [svelte()],
});
