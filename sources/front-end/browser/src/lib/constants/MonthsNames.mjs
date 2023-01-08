export const MonthsNames = Object.freeze(['jan', 'feb', 'mar', 'apr', 'may', 'jun', 'jul', 'aug', 'sep', 'oct', 'nov', 'dec']);

export const getMonthNameById = (monthId) => MonthsNames[monthId - 1];