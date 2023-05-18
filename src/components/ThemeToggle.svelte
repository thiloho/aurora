<script lang="ts">
  import Dropdown from "./Dropdown.svelte";

  let themeOptions = ["System", "Light", "Dark"];

  let theme = "System";

  function loadTheme() {
    theme = localStorage.getItem("theme");
  }

  function saveTheme() {
    localStorage.setItem("theme", theme);
  }

  loadTheme();

  $: document.documentElement.classList = theme;
</script>

<Dropdown shortcut="T">
  <svg slot="icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" class="w-6 h-6">
    <title>Toggle theme (Shift + t)</title>
    <path fill-rule="evenodd" d="M2.25 5.25a3 3 0 013-3h13.5a3 3 0 013 3V15a3 3 0 01-3 3h-3v.257c0 .597.237 1.17.659 1.591l.621.622a.75.75 0 01-.53 1.28h-9a.75.75 0 01-.53-1.28l.621-.622a2.25 2.25 0 00.659-1.59V18h-3a3 3 0 01-3-3V5.25zm1.5 0v7.5a1.5 1.5 0 001.5 1.5h13.5a1.5 1.5 0 001.5-1.5v-7.5a1.5 1.5 0 00-1.5-1.5H5.25a1.5 1.5 0 00-1.5 1.5z" clip-rule="evenodd" />
  </svg>
  <div class="theme-toggle">
    {#each themeOptions as option, index}
      <div>
        <input type="radio" id="theme-{option}" name="theme" value={option} bind:group={theme} on:change={saveTheme} />
        <label for="theme-{option}">{option}</label>
      </div>
    {/each}
  </div>
</Dropdown>

<style>
  .theme-toggle {
    position: absolute;
    inset-inline-end: 0;
    inset-block-start: var(--nav-height);
    background-color: var(--background-color);
    border: var(--standard-border);
    padding: 1rem;
    display: grid;
    gap: 0.5rem;
  }
</style>