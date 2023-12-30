<script lang="ts">
	//@ts-ignore
	import persianDate from 'persian-date';
	import Select from 'svelte-select/Select.svelte';
	import { createEventDispatcher } from 'svelte';
	import type { DropdownItem } from 'components/layout/dropdown.svelte';
	const disp = createEventDispatcher();
	
	export const yearRangeBefore = 50;
	export const yearRangeAfter = 50;
	
	const pdate = new persianDate() as any;
	const cur_year = pdate.year();
	export let value = cur_year;

	const startYear = cur_year  - yearRangeBefore;
	const yearList = new Array(yearRangeBefore + yearRangeAfter + 1).fill(0).map((_, i) =>
		(startYear + i).toString()
	);
	const yearOptions = yearList.map(
		(y) =>
			({
				label: y,
				value: parseInt(y)
			} as DropdownItem<any>)
	);

	$: selected_item = yearOptions.find(e=>e.value === value);

</script>

<Select clearable={false} listAutoWidth items={yearOptions} value={selected_item} on:change={(e)=>{
	disp("change",e.detail.value);
}}/>
