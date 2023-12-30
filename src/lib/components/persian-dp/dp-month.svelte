<script lang="ts">
	//@ts-ignore
	import persianDate from 'persian-date';
	import Select from 'svelte-select/Select.svelte';
	import { createEventDispatcher } from 'svelte';
	const fakeDate = new persianDate();
	//@ts-ignore
	const months = fakeDate.rangeName().months;
	//@ts-ignore
	export let value = 0;

	const disp = createEventDispatcher();

	$: monthOptions = months.map((m : string , i:number)=>({label : m , value : i + 1}))
	$: selectedItem = monthOptions.find((e:any)=>e.value === value);

</script>

<Select clearable={false} listAutoWidth={true} items={monthOptions} value={selectedItem} on:change={(e)=>{
	disp("change",e.detail.value);
}}/> 