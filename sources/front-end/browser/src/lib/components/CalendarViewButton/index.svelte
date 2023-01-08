<script>
  import { createEventDispatcher } from "svelte";
  import {
    Temporal,
  } from '@js-temporal/polyfill';
  import {
    getMonthNameById,
  } from '$lib/constants/MonthsNames.mjs';
  import {
    getWeekDayNameById,
  } from '$lib/constants/DaysOfWeekNames.mjs';

  /** @type {String | undefined} */
  export let id;

  /** @type {Temporal.ZonedDateTime | undefined} */
  let currentMondayDateTime;

  const dispatch = createEventDispatcher();

  const handleClick = () => {
    dispatch('click', {
      id,
    });
  }

  $: if (id) {
    /** @type {Temporal.ZonedDateTime} */
    currentMondayDateTime = Temporal.ZonedDateTime.from(id);
  }
</script>

<style>
  button {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    grid-template-rows: 0.5fr 2.5fr min(1vh, 1vw);
    grid-template-areas:
      'weekDay weekDay weekDay'
      'monthDate monthDate monthDate'
      'substitution-req . .'
    ;
    font-size: 0.75rem;
    background-color: hsl(0, 0%, 66%);
    padding: 0;
    border-radius: min(0.5vh, 0.5vw);

    filter: contrast(0.5) opacity(0.5);

    pointer-events: all;
  }

  .weekDay {
    grid-area: weekDay;
  }

  .monthDate {
    grid-area: monthDate;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    height: 100%;
    font-size: 4vh;
  }

  .substitution-req {
    grid-area: substitution-req;
  }
</style>

<button {id} on:click={handleClick}>
  <div class='weekDay'>
    {getWeekDayNameById(currentMondayDateTime?.day)}
  </div>
  <div class='monthDate'>
    {currentMondayDateTime?.day}
  </div>
  <div class='substitution-req' />
</button>
