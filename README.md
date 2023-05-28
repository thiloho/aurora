# aurora

## About

aurora is a minimal blog theme built with Astro, Svelte and plain CSS. It is focused on accessibility and usability.

All the interactiveness of the website is packed into three dropdowns that are located at the right of the top navigation bar. Every menu can be opened with a simple keyboard shortcut:

- Table of contents: **Shift + c**
- Search for an article: **Shift + s**
- Theme toggle: **Shift + t**
- Close menu: Escape (**Esc**)

The styles are simple, there are small improvements for some elements to keep everything consistent and responsive.

### Table of contents

Secondary headings (`<h2>`) are listed here, so each page is easy to navigate.

### Search

I wrote a simple algorithm for the search, and the matching works well. You can write the blog title words in any order, leave letters out, have multiple spaces between words, and more.

### Theme toggle

There are three websites themes: Light, Dark and System (inherits the theme of your browser or operating system).

## Make the theme yours

Replace the domain specified for the `site` property in the `astro.config.ts` file with your own domain:

```ts
site: "https://aurora.thilohohlt.com"
```

Change the `title` and `description` props in `/src/pages/index.astro` to match your website's content:

```html
<PageLayout title="aurora" description="Minimalistic blog theme built with Astro, focused on accessibility and usability.">
```

For the components `Head.astro` and `Footer.astro`, replace *Your Name* with your actual name:

```html
<meta name="author" content="Your Name" />
```

```html
<small>Copyright &copy; {currentDateYear} Your Name<br><a href="https://aurora.thilohohlt.com/">Astro aurora theme</a></small>
```

The about section on the main page can be modified by adjusting the markdown text in the file `src/content/about/about.md`:

```md
## About

aurora is a minimal blog theme built with Astro, Svelte and plain CSS. It is focused on accessibility and usability.
...
```

The cover image (the image people see embedded when you send a link to your website) can be changed by altering the file `/public/cover.jpg`.

Blog articles are created using Astro content collections, images for individual articles are stored in `/src/assets/blog/article-name/image-name.jpg`. You can take a look at the example articles in this repository to see how it all works out.
