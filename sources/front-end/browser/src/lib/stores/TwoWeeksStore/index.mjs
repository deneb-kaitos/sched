import {
  writable,
} from 'svelte/store';
import {
  Temporal,
} from '@js-temporal/polyfill';
import {
  DaysOfWeekNames,
} from '$lib/constants/DaysOfWeekNames.mjs';
import {
  MonthsNames,
} from '$lib/constants/MonthsNames.mjs';

console.log({
  now: Temporal.Now,
  zonedDateTimeISO: Temporal.Now.zonedDateTimeISO(),
  calendar: Temporal.Now.zonedDateTimeISO().calendar.id,
  day: Temporal.Now.zonedDateTimeISO().day,
  dayOfWeek: Temporal.Now.zonedDateTimeISO().dayOfWeek,
  daysInMonth: Temporal.Now.zonedDateTimeISO().daysInMonth,
  daysInWeek: Temporal.Now.zonedDateTimeISO().daysInWeek,
  month: Temporal.Now.zonedDateTimeISO().month,
  monthCode: Temporal.Now.zonedDateTimeISO().monthCode,
  year: Temporal.Now.zonedDateTimeISO().year,
});

const currentDayOfWeekName = DaysOfWeekNames[Temporal.Now.zonedDateTimeISO().dayOfWeek - 1];
const currentMonthName = MonthsNames[Temporal.Now.zonedDateTimeISO().month - 1];
const currentWeekMondayDay = Temporal.Now.zonedDateTimeISO().day - Temporal.Now.zonedDateTimeISO().daysInWeek + 1;

console.log({ currentDayOfWeekName, currentMonthName, currentWeekMondayDay, date: `${Temporal.Now.zonedDateTimeISO().year}-${Temporal.Now.zonedDateTimeISO().month}-${Temporal.Now.zonedDateTimeISO().day}` });

let currentMondayDateTime = Temporal.ZonedDateTime.from({
  timeZone: Temporal.Now.zonedDateTimeISO().timeZone,
  year: Temporal.Now.zonedDateTimeISO().year,
  month: Temporal.Now.zonedDateTimeISO().month,
  day: currentWeekMondayDay,
  hour: 0,
  minute: 0,
  second: 0,
  millisecond: 0,
  microsecond: 0,
  nanosecond: 0,
});

console.log({ currentMondayDateTime: currentMondayDateTime.toString() });

const twoWeeks = [];

twoWeeks.push(currentMondayDateTime);

for (let i = 0; i < (Temporal.Now.zonedDateTimeISO().daysInWeek * 2) - 1; i += 1) {
  currentMondayDateTime = currentMondayDateTime.add({ days: 1 });

  twoWeeks.push(currentMondayDateTime);
}

function createTwoWeeksStore() {
  const {
    subscribe,
  } = writable(twoWeeks);

  return {
    subscribe,
  }
}

export const TwoWeeksStore = createTwoWeeksStore();
