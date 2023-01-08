<script>
  import {
    createEventDispatcher,
  } from 'svelte';
  import {
    PowerIcon,
  } from 'svelte-feathers';

  const dispatch = createEventDispatcher();

  const handleClick = (/** @type {PointerEvent} */ pointerEvent) => {
    dispatch('createCalendarViewItem', {});
  }
</script>

<style>
  button {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    flex: 1 0 100%;
    height: 100%;

    background-color: transparent;
    pointer-events: all;
    border-radius: min(0.5vh, 0.5vw);
    padding: max(2vh, 2vw);
  }
</style>

<button on:click|preventDefault|stopPropagation={handleClick}>
  <PowerIcon color="var(--theme-light_gray_bright)" size="min(16vh, 16vw)" />
</button>