<script lang="ts">
    import type { CollectionEntry } from "astro:content";

    export let articles: CollectionEntry<"blog">[] = [];

    import Dropdown from "./Dropdown.svelte";

    let searchTerm = "";

    $: filteredArticles = articles.filter(article => {
      const searchTermWords = searchTerm.trim().replace(/\s+/g, " ").toLowerCase().split(' ');
      const articleTitle = article.data.title.trim().replace(/\s+/g, " ").toLowerCase();

      return searchTermWords.every(word => articleTitle.includes(word)) && searchTerm.trim() !== "";
    });
</script>

<Dropdown shortcut="S">
    <svg slot="icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" class="icon">
      <title>Search for an article (Shift + s)</title>
      <path fill-rule="evenodd" d="M10.5 3.75a6.75 6.75 0 100 13.5 6.75 6.75 0 000-13.5zM2.25 10.5a8.25 8.25 0 1114.59 5.28l4.69 4.69a.75.75 0 11-1.06 1.06l-4.69-4.69A8.25 8.25 0 012.25 10.5z" clip-rule="evenodd" />
    </svg>
    <div class="article-search">
      <label for="article-search">Search for an article:</label>
      <input type="search" id="article-search" placeholder="first po..." bind:value={searchTerm} />
      {#if filteredArticles.length > 0}
        <p>Results: <strong>{filteredArticles.length}</strong></p>
          <ul>
            {#each filteredArticles as article}
              <li>
                <a href="/{article.slug}">{article.data.title}</a>
              </li>
            {/each}
          </ul>
      {:else if searchTerm.trim() !== ""}
        <p>No results found</p>
      {/if}
    </div>
</Dropdown>

<style>
  .article-search {
    padding: var(--size-3);
    position: absolute;
    inset-inline: 0;
    border: var(--standard-border);
    inset-block-start: var(--nav-height);
    background-color: var(--background-color);
    display: grid;
    max-block-size: calc(100vh - var(--nav-height) * 2);
    overflow-y: auto;
  }

  input[type="search"] {
    position: sticky;
    inset-block-start: 0;
  }

  ul {
    margin-block-start: 0;
  }

  input {
    inline-size: 100%;
    margin-block-start: var(--size-1);
  }
</style>
