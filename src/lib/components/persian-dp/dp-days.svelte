<script lang="ts">
	//@ts-ignore
	import PersianDate from 'persian-date';
	import { createEventDispatcher } from 'svelte';
	import DpDay from './dp-day.svelte';
	import { DayType, type Day } from './type';
	const disp = createEventDispatcher();

	export let year: number;
	export let month: number;
	export let value: number;
	export let layout: 'auto' | 'fluid';
	export let selectable = true;
	export let hasCellSlot = false;

	const pd = new PersianDate(year, month, 1);
	$: prevMonth = pd.add(-1, 'month');
	$: num_days = pd.daysInMonth(year, month);
	$: num_days_prev_month = pd.daysInMonth(
		year,
		prevMonth.month()
	);
	$: firstDayOfMonth = pd.getFirstWeekDayOfMonth(
		year,
		month
	);	

	$: thisMonthdays = new Array(num_days)
		.fill(0)
		.map(
			(_, i) =>
				({
					value: i + 1,
					type: DayType.CurrentMonth,
					date: new PersianDate([
						year,
						month,
						i + 1
					]).toDate()
				} as Day)
		);

	$: prevMonthDays = new Array(
		firstDayOfMonth - 1
	)
		.fill(0)
		.map(
			(_, i) =>
				({
					value:
						num_days_prev_month -
						(firstDayOfMonth - 2) +
						i,
					type: DayType.PrevMonth
				} as Day)
		);

	$: num_prev_curent =
		7 - ((num_days + (firstDayOfMonth - 1)) % 7);

	$: nextMonthDays =
		num_prev_curent != 7
			? new Array(num_prev_curent).fill(0).map(
					(_, i) =>
						({
							value: i + 1,
							type: DayType.NextMonth
						} as Day)
			  )
			: [];

	$: allDyas = [
		...prevMonthDays,
		...thisMonthdays,
		...nextMonthDays
	];

	function handleDaySelect(
		e: CustomEvent<number>
	) {
		disp('select', e.detail);
	}

	const abbrDayNames = [
		'ش',
		'ی',
		'د',
		'س',
		'چ',
		'پ',
		'ج'
	];
</script>

<div class="dp-day-list">
	{#each abbrDayNames as dayName}
		<DpDay
			value={{
				type: DayType.DayName,
				value: dayName
			}}
			active={false}
			{layout}>{dayName}</DpDay
		>
	{/each}
	{#each allDyas as day}
		<DpDay
			value={day}
			{layout}
			on:select={handleDaySelect}
			on:itemdblclick
			{selectable}
			active={selectable
				? day.value === value &&
				  day.type === DayType.CurrentMonth
				: false}
			{hasCellSlot}
		>
			<svelte:fragment slot="cell" let:value>
				<slot name="cell" {value} />
			</svelte:fragment>
		</DpDay>
	{/each}
</div>

<style lang="scss">
	.dp-day-list {
		display: flex;
		flex-wrap: wrap;
	}
</style>
