<script>
  import {
    browser as IsInBrowser,
  } from '$app/environment';
  import {
    onMount,
    onDestroy,
  } from 'svelte';
  import CalendarViewItem from '$lib/components/CalendarViewItem/index.svelte';

  let items = [];

  onMount(() => {
    if (IsInBrowser === true) {
      items.push({
        id: window.crypto.randomUUID(),
        title: 'samowar',
        isVirtual: false,
      });
      items.push({
        id: window.crypto.randomUUID(),
        title: undefined,
        isVirtual: true,
      });
      items.push({
        id: window.crypto.randomUUID(),
        title: null,
        isVirtual: true,
      });

      items = items;
    }
  });

  onDestroy(() => {
  });
</script>

<style>
  article {
    display: grid;
    grid-template-columns: 1fr;
    grid-template-rows: 1fr 1fr 1fr;
    gap: var(--main-grid-gap);
    height: 100%;
  }
</style>

<article>
  {#each items as item (item.id)}
    <CalendarViewItem
      id={item.id}
      title={item.title}
      isVirtual={item.isVirtual}
    />
  {/each}
</article>