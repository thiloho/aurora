<script lang="ts">
  export let shortcut: string;

  const possibleShortcuts = ["S", "C", "T"];

  let detailsElement: HTMLDetailsElement;
  let summaryElement: HTMLElement;

  function openMenu() {
    detailsElement.setAttribute("open", "");
  }

  export function closeMenu() {
    detailsElement.removeAttribute("open");
  }

  function handleKeydown(event: KeyboardEvent) {
    if (event.key === "Escape") closeMenu();

    if (event.key === shortcut) {
      summaryElement.focus();
      openMenu();
    } else if (possibleShortcuts.includes(event.key) && event.key !== shortcut) {
      closeMenu();
    }
  }

  function handleClick(event: MouseEvent) {
      if (!detailsElement.contains(event.target as Node)) {
        closeMenu();
      }
  }
</script>

<svelte:window on:keydown="{handleKeydown}" on:click="{handleClick}" />

<details bind:this="{detailsElement}">
  <summary bind:this="{summaryElement}">
    <slot name="icon" />
  </summary>
  <slot />
</details>

<style>
  summary {
    display: grid;
    padding: var(--size-2);
  }
</style>
