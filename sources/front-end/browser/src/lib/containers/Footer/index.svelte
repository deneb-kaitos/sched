<script>
  import {
    browser as IsInBrowser,
  } from '$app/environment';
  import {
    onDestroy,
  } from 'svelte';
  // import {
  //   TsStore,
  // } from '$lib/stores/ts.store.mjs';

  /** @type {Number | null} */
  let lastTs = null;

  // const unsubscribeFromTsStore = TsStore.subscribe((/** @type {string | any[]} */ newState) => {
  //   lastTs = newState.at(-1);
  // });


  onDestroy(() => {
    // unsubscribeFromTsStore();
  });
</script>

<style>
  footer {
    /* background-color: yellowgreen; */
  }
</style>

<footer>
</footer>
