<script>
  import TwoWeekView from '$lib/components/TwoWeekView/index.svelte';
  /** @type {String | undefined} */
  export let id;
  /** @type {String | undefined} */
  export let title;
  /** @type {boolean} */
  export let isVirtual = true;
</script>

<style>
  section {
    display: grid;
    grid-template-columns: 1fr;
    grid-template-rows: 1fr 4fr 0.5fr;
    grid-template-areas:
      'title-container'
      'two-week-view-container'
      'status-container'
    ;
    gap: var(--main-grid-gap);

  }

  section > div {
    padding: 0 var(--main-grid-gap);
  }
  
  .isVirtual {
    filter: opacity(0.5) blur(1px) contrast(0.5);
  }
  
  .title-container {
    grid-area: title-container;
    display: flex;
    justify-content: center;
    align-items: center;
    /* background-color: cornflowerblue; */
  }

  .status-container {
    grid-area: status-container;
    display: flex;
    justify-content: start;
    align-items: center;
    /* background-color: cornflowerblue; */
    font-size: 0.75rem;
  }
</style>

<section id={id} class:isVirtual>
  <div class='title-container'>
    {title ? title : ''}
  </div>
  <!-- <div class='two-week-view-container'> -->
    <TwoWeekView />
  <!-- </div> -->
  <div class='status-container'>
    status-container
  </div>
</section>