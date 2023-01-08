<script>
  import { createEventDispatcher } from "svelte";

  /** @type {String | undefined} */
  export let id;
  /** @type {String | undefined} */
  export let name;
  const dispatch = createEventDispatcher();

  const handleClick = () => {
    dispatch('click', {
      id,
      name,
    });
  }
</script>

<style>
  button {
    display: flex;
    flex-direction: column;
    justify-content: start;
    align-items: flex-start;
    font-size: 0.75rem;
    background-color: yellowgreen;

    pointer-events: all;
  }
</style>

<button {id} on:click={handleClick}>
  {name}
</button>
