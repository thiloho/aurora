<script lang="ts">
  import type { MarkdownHeading } from "astro";

  export let headings: MarkdownHeading[] = [];

  import Dropdown from "./Dropdown.svelte";
</script>

<Dropdown shortcut="C">
  <svg slot="icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" class="icon">
    <title>Table of contents (Shift + c)</title>
    <path fill-rule="evenodd" d="M2.625 6.75a1.125 1.125 0 112.25 0 1.125 1.125 0 01-2.25 0zm4.875 0A.75.75 0 018.25 6h12a.75.75 0 010 1.5h-12a.75.75 0 01-.75-.75zM2.625 12a1.125 1.125 0 112.25 0 1.125 1.125 0 01-2.25 0zM7.5 12a.75.75 0 01.75-.75h12a.75.75 0 010 1.5h-12A.75.75 0 017.5 12zm-4.875 5.25a1.125 1.125 0 112.25 0 1.125 1.125 0 01-2.25 0zm4.875 0a.75.75 0 01.75-.75h12a.75.75 0 010 1.5h-12a.75.75 0 01-.75-.75z" clip-rule="evenodd" />
  </svg>
  <ul>
    {#each headings.filter(({ depth }) => depth === 2) as { slug, text }}
      <li>
        <a href="#{slug}">{text}</a>
      </li>
    {/each}
  </ul>
</Dropdown>

<style>
  ul {
    position: absolute;
    border: var(--standard-border);
    background-color: var(--background-color);
    inset-block-start: var(--nav-height);
    margin: 0;
    padding: 0;
    list-style: none;
    inset-inline-end: 0;
    max-block-size: calc(100vh - var(--nav-height) * 2);
    overflow-y: auto;
  }

  a {
    display: block;
    padding-inline: var(--size-3);
    padding-block: var(--size-1);
  }
</style>
