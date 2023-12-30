<script lang="ts">
	import { DayType, type Day } from './type';
	import { store, type DPStore } from './store';
	import { createEventDispatcher } from 'svelte';
	const disp = createEventDispatcher();

	export let active: boolean;
	export let value: Day;
	export let layout: string;
	export let selectable = true;
	export let hasCellSlot = false;

	let storeValue: DPStore;
	store.subscribe((s) => {
		storeValue = s;
	});

	const handleSelect = (day: Day) => () => {
		if (day.type !== DayType.CurrentMonth) {
			return;
		}
		disp('select', day.value);
	};

	const itemDblClick = (day:Day)=> ()=>{
		if (day.type !== DayType.CurrentMonth) {
			return;
		}
		disp('itemdblclick', day);
	}
</script>

{#if storeValue}
	<!-- svelte-ignore a11y-click-events-have-key-events -->
	<div
		class="dp-day"
		class:fluid={layout === 'fluid'}
		class:prev={value.type === DayType.PrevMonth}
		class:next={value.type === DayType.NextMonth}
		class:selectable
		class:active
		class:dayname={value.type === DayType.DayName}
		style="--primary-color:{storeValue.theme
			.primaryColor}; --secondary-color:{storeValue
			.theme.secondaryColor}"
		on:click={handleSelect(value)}
		on:dblclick={itemDblClick(value)}
	>
		<div class="cell">
			{#if !hasCellSlot}
				<div>{value.value}</div>
			{/if}
			<slot name="cell" value={value} />
		</div>
	</div>
{/if}

<style lang="scss">
	.dp-day {
		&.prev,
		&.next {
			color: rgb(189, 189, 189);
			& .cell {
				background-color: transparent;
			}
		}
		width: 14.28%;
		aspect-ratio: 1;
		display: inline-flex;
		flex-direction: column;
		align-items: center;
		justify-content: center;
		font-weight: bold;
		cursor: pointer;
		box-sizing: border-box;
		cursor: pointer;
		& .cell {
			width: 90%;
			height: 90%;
			background-color: var(
				--dropdown-hover-background-color
			);
			display: flex;
			flex-direction: column;
			align-items: center;
			justify-content: center;
			& :global(.holiday) {
				border-radius: 100%;
				background-color: #f00;
				color:#fff;
				padding:0 0.5em;
			}
		}
		&.selectable:not(.prev, .next) {
			&:hover {
				background-color: var(--primary-color);
			}
		}
		&.active .cell {
			background-color: var(--primary-color);
		}
		&.fluid {
			aspect-ratio: unset;
			min-height: 4em;
			padding: 0;
			& .cell {
				width: 100% !important;
				height: 100% !important;
				border: solid 1px var(--dropdown-border-color);
			}
			&:not(.dayname) .cell {
				align-items: start;
				justify-content: start;
				padding: 0.5em;
			}
		}
		&.dayname {
			margin-bottom: 0.5em;
			height: 2em;
			min-height: unset;
		}
		&.dayname .cell {
			background-color: var(--secondary);
		}		
	}
</style>
