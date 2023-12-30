<script lang="ts">
	//@ts-ignore
	import PersianDate from 'persian-date';
	import { clickOutside } from './directives/on-outside-click';
	import Calendar from './calendar.svelte';
	import { createEventDispatcher } from 'svelte';
	let label: string = '';
	export let name: string | undefined = undefined;
	export let hasError = false;
	export let value: Date | undefined;
	let show = false;

	
	function handleDaySelect() {		
		show = false;
		disp('change' , value);
	}

	$: label = value
		? new PersianDate(value).format('YYYY/MM/DD')
		: '';	

	let inputRef: HTMLElement | null;

	const disp = createEventDispatcher();	

</script>

<div class="date-picker">
	<input
		type="text"
		readonly
		on:focus={() => (show = true)}
		bind:this={inputRef}
		value={label}
		aria-invalid={hasError ? true : undefined}
		class="bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full ps-10 p-2.5  dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
	/>	
	{#if name}
		<input type="hidden" {name} {value}/>
	{/if}
	{#if show}
		<div
			class="dp-container datepicker-picker inline-block rounded-lg bg-white dark:bg-gray-700 shadow-lg p-4"
			use:clickOutside={{
				callback: () => (show = false),
				ignoreList: [inputRef]
			}}
		>
		   <Calendar bind:value on:select={handleDaySelect}/>	
		</div>
	{/if}
	{#if value}
		<button class="clear" on:click={()=>value=undefined}> x </button>
	{/if}
</div>

<style lang="scss">
	.date-picker {
		position: relative;
		& :global(.selected-item){
			color:#555!important;
		}
	}
	.dp-container {
		border: solid 1px var(--dropdown-border-color); 
		padding: 1em;
		display: inline-flex;
		flex-direction: column;
		position: absolute;
		z-index: 999;
		top: 100%;
		right: 0;	
	}

	input {
		position: relative;
	}

	input:after {
		content: 'x';
		position: absolute;
	}

	.clear {
		position: absolute;
		/* background: red; */
		width: 3em;
		height: var(--line-height);
		left: 0;
		top: 10px;
		display: flex;
		justify-content: center;
		align-items: center;
		cursor: pointer;
		background:none;
		border: none!important;
		outline: none!important;		
		box-shadow: none;
		color:var(--contrast);
	} 
</style>
