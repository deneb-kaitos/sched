<script>
  import TwoWeekView from '$lib/components/TwoWeekView/index.svelte';
  import InitCalendarViewItem from '$lib/components/InitCalendarViewItem/index.svelte';
  /** @type {String | undefined} */
  export let id;
  /** @type {String | undefined} */
  export let title;
  /** @type {boolean} */
  export let isVirtual = true;

  const handleCreateCalendarViewItem = (/** @type {CustomEvent} */ customEvent) => {
    const {
      detail,
    } = customEvent;

    console.log('handleCreateCalendarViewItem', detail);
  };
</script>

<style>
  section {
    display: grid;
    grid-template-columns: 1fr;
    grid-template-rows: 1fr 4fr;
    grid-template-areas:
      'title-container'
      'two-week-view-container'
    ;
  }

  section > div {
    padding: 0 var(--main-grid-gap);
  }
  
  .isVirtual {
    display: flex;
    flex-direction: column;
    flex: 1 0 100%;
    justify-content: center;
    align-items: center;

    background-color: #e5e5f7;
    opacity: 0.8;
    background: repeating-linear-gradient( -45deg, var(--theme-gray), var(--theme-gray) 1px, transparent 1px, transparent 5px );
  }
  
  .title-container {
    grid-area: title-container;
    display: flex;
    justify-content: center;
    align-items: center;
    /* background-color: cornflowerblue; */
  }

  .two-week-view-container {
    grid-area: two-week-view-container;
  }
</style>

<section {id} class:isVirtual>
  <div class='title-container'>
    {isVirtual ? '' : title}
  </div>
  <div class='two-week-view-container'>
    {#if isVirtual === false}
      <TwoWeekView />
    {:else}
      <InitCalendarViewItem
        on:createCalendarViewItem={handleCreateCalendarViewItem}
      />
    {/if}
  </div>
</section>