<script>
  import {
    browser as IsInBrowser,
  } from '$app/environment';
  import {
    onMount,
  } from 'svelte';
  import CalendarViewButton from '$lib/components/CalendarViewButton/index.svelte';

  const dayNames = ['mo', 'tu', 'we', 'th', 'fr', 'sa', 'su'];
  let days = [];

  const handleDayButtonClick = ({ detail: { id, name } }) => {
    console.log('handleDayButtonClick', id, name);
  }

  onMount(() => {
    if (IsInBrowser === true) {
      for (let d = 0; d < 14; d += 1) {
        days.push({
          id: window.crypto.randomUUID(),
          name: dayNames[d % 7],
        });
      }
  
      days = days;
    }
  });
</script>

<style>
  div.days-container {
    display: grid;
    grid-template-columns: repeat(7, 1fr);
    gap: var(--main-grid-gap);
  }
</style>

<div class='days-container'>
  {#each days as day (day.id)}
    <CalendarViewButton
      id={day.id}
      name={day.name}
      on:click={handleDayButtonClick}
    />
  {/each}
</div>
