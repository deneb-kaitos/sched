<script>
  import {
    browser as IsInBrowser,
  } from '$app/environment';
  import {
    onMount,
    onDestroy,
  } from 'svelte';
  import {
    Temporal,
  } from '@js-temporal/polyfill';
  import CalendarViewButton from '$lib/components/CalendarViewButton/index.svelte';
  import {
    TwoWeeksStore,
  } from '$lib/stores/TwoWeeksStore/index.mjs';

  let days = [];

  const unsubscribeFromTwoWeeksStore = TwoWeeksStore.subscribe((twoWeeksState) => {
    days = twoWeeksState;
  });

  const handleDayButtonClick = ({ detail: { id, name } }) => {
    console.log('handleDayButtonClick', id, name);
  }

  onMount(() => {

  });

  onDestroy(() => {
    if (typeof unsubscribeFromTwoWeeksStore !== 'undefined') {
      unsubscribeFromTwoWeeksStore();
    }
  });
</script>

<style>
  div.days-container {
    display: grid;
    grid-template-columns: repeat(7, 1fr);
    gap: var(--main-grid-gap);
    height: 100%;
  }
</style>

<div class='days-container'>
  
  {#each days as d}
    <CalendarViewButton
      id={d.toString()}
      on:click={handleDayButtonClick}
    />
  {/each}
</div>
