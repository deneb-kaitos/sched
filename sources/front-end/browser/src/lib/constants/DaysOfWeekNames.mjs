import {
  Temporal,
} from '@js-temporal/polyfill';

export const DaysOfWeekNames = Object.freeze(['mo', 'tu', 'we', 'th', 'fr', 'sa', 'su']);
export const getWeekDayNameById = (weekDayId) => DaysOfWeekNames[(weekDayId - 2) % Temporal.Now.zonedDateTimeISO().daysInWeek];
