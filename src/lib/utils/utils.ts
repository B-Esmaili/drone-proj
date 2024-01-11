export const formatPrice = (price: number | string) => {
	return (price ?? 0).toLocaleString('fa-IR', {
		style: 'currency',
		currency: 'IRR',
		minimumFractionDigits : 0
	});
};

export type DateFormats =
	| 'date'
	| 'date-time'
	| 'date-semantic'
	| 'date-time-semantic'
	| "time";


export const formatDate = (
	date: Date | string | null,
	type: DateFormats = 'date'
) => {
	if (!date) {
		return '-';
	}
	if (typeof date === 'string') {
		date = new Date(date as string);
	}

	let formatted = '';

	const getTime = (d : Date)=>{ 

		const hour = new Intl.DateTimeFormat(
			'fa-IR',
			{
				hour: '2-digit'
			}
		).format(d);

		const min = new Intl.DateTimeFormat(
			'fa-IR',
			{
				minute: '2-digit'
			}
		).format(d);

		return `${min} : ${hour}`
	};

	if (type ==="time"){
		return getTime(date);
	}

	if (
		type === 'date-semantic' ||
		type === 'date-time-semantic'
	) {
		const weekday = new Intl.DateTimeFormat(
			'fa-IR',
			{
				weekday: 'long'
			}
		).format(date);

		const day = new Intl.DateTimeFormat('fa-IR', {
			day: 'numeric'
		}).format(date);

		const month_name = new Intl.DateTimeFormat(
			'fa-IR',
			{
				month: 'long'
			}
		).format(date);

		const year = new Intl.DateTimeFormat(
			'fa-IR',
			{
				year: 'numeric'
			}
		).format(date); 
		

		formatted = `${weekday} ${day} ام ${month_name} ${year}`;

		if (type === "date-time-semantic"){
			formatted = `${formatted} &nbsp &nbsp ${getTime(date)}`;
		}
	} else {
		formatted = new Intl.DateTimeFormat('fa-IR', {
			year: 'numeric',
			month: '2-digit',
			day: '2-digit',
			hour:
				type === 'date-time'
					? '2-digit'
					: undefined,
			minute:
				type === 'date-time'
					? '2-digit'
					: undefined,
			second:
				type === 'date-time'
					? '2-digit'
					: undefined
		}).format(date);
	}

	return formatted;
};