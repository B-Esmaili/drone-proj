<script context="module" lang="ts">
	export interface CalendarEventArgs {
		year: number;
		month: number;
		day: number;
		nextYear: number;
		nextMonth: number;
		nextDay: number;
		dir: 'next' | 'prev' | 'exact';
	}
</script>

<script lang="ts">
	import DpDays from './dp-days.svelte';
	import DpMonth from './dp-month.svelte';
	import DpNext from './dp-next.svelte';
	//@ts-ignore
	import PersianDate from 'persian-date';

	import DpPrev from './dp-prev.svelte';
	import DpYear from './dp-year.svelte';
	import { createEventDispatcher } from 'svelte';
	import type { MaybePromise } from '$app/forms';
	export let value: Date | undefined = new Date();
	export let layout: 'auto' | 'fluid' = 'auto';
	export let selectable: boolean = true;
	export let onChange:
		| ((
				args: CalendarEventArgs
		  ) => MaybePromise<void>)
		| null = null;
	const disp = createEventDispatcher();
	let calendar_key = 0;

	$: currrentDate = value
		? new PersianDate(value)
		: new PersianDate(new Date());

	$: year_value = currrentDate.year();
	$: month_value = currrentDate.month();
	$: day_value = currrentDate.date();

	function updateValue() {
		value = new PersianDate([
			year_value,
			month_value,
			day_value
		]).toDate();
	}

	async function notifyChange(
		args: CalendarEventArgs
	) {
		return new Promise((resolve, reject) => {
			if (onChange) {
				Promise.resolve(onChange(args))
					.then(resolve)
					.catch(reject);
			} else {
				resolve(args);
			}
		});
	}

	async function nextMonth() {
		let next_month = new PersianDate([
			year_value,
			month_value,
			day_value
		]).add(1, 'month');

		await notifyChange({
			year: year_value,
			month: month_value,
			day: day_value,
			nextYear: next_month.year(),
			nextMonth: next_month.month(),
			nextDay: next_month.day(),
			dir: 'next'
		});

		year_value = next_month.year();
		month_value = next_month.month();
		day_value = next_month.day();
		updateValue();
	}

	async function prevMonth() {
		let prev_month = new PersianDate([
			year_value,
			month_value,
			day_value
		]).add(-1, 'month');

		await notifyChange({
			year: year_value,
			month: month_value,
			day: day_value,
			nextYear: prev_month.year(),
			nextMonth: prev_month.month(),
			nextDay: prev_month.day(),
			dir: 'prev'
		});

		year_value = prev_month.year();
		month_value = prev_month.month();
		day_value = prev_month.day();
		updateValue();
	}

	function handleDaySelect(
		e: CustomEvent<number>
	) {
		day_value = e.detail;
		updateValue();
		disp('select');
	}

	async function handleMonthchange(
		e: CustomEvent<number>
	) {
		await notifyChange({
			year: year_value,
			month: month_value,
			day: day_value,
			nextYear: year_value,
			nextMonth: e.detail,
			nextDay: day_value,
			dir: 'exact'
		});

		month_value = e.detail;
	}

	async function handleYearChange(
		e: CustomEvent<number>
	) {
		await notifyChange({
			year: year_value,
			month: month_value,
			day: day_value,
			nextYear: e.detail,
			nextMonth: month_value,
			nextDay: day_value,
			dir: 'exact'
		});

		year_value = e.detail;
	}

	export function refresh() {
		calendar_key++;
	}
</script>

<div
	class="calendar"
	class:fluid={layout === 'fluid'}
>
	<div class="header">
		<DpPrev on:click={prevMonth} />
		<div class="selections">
			<div>
				<DpMonth
					value={month_value}
					on:change={handleMonthchange}
				/>
			</div>
			<div>
				<DpYear
					value={year_value}
					on:change={handleYearChange}
				/>
			</div>
		</div>
		<DpNext on:click={nextMonth} />
	</div>
	<div class="body">
		{#key calendar_key}
			<DpDays
				year={year_value}
				{layout}
				month={month_value}
				on:select={handleDaySelect}
				on:itemdblclick
				value={day_value}
				{selectable}
				hasCellSlot={Boolean($$slots.cell)}
			>
				<svelte:fragment slot="cell" let:value>
					<slot name="cell" day={value} />
				</svelte:fragment>
			</DpDays>
		{/key}
	</div>
</div>

<style lang="scss">
	.calendar {
		width: 21em;
		&.fluid {
			width: 100%;
		}
	}
	.header {
		display: flex;
		justify-content: space-between;
	}
	.body {
		padding: 0.5em 0;
	}
	.selections {
		display: flex;
		& > div {
			margin: 0 0.5em 0.25em;
			width:100px;
		}
		& :global(.svelte-select) {
			padding-block: 0 !important;
			min-height: 0 !important;
		}
	}
</style>
