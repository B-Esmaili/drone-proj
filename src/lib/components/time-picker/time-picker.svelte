<script context="module" lang="ts">
	export interface TimeValue {
		hour: number;
		minute: number;
		second?: number;
	}
</script>

<script lang="ts">
	import Select from 'svelte-select/Select.svelte';
	import TimeIcon from './time-icon.svelte';

	export let value: TimeValue = {
		hour: 0,
		minute: 0,
		second: 0
	};

	const hourOptions = new Array(24).fill(0).map((_, value: number) => ({
		label: value.toString().padStart(2, '0'),
		value
	}));

	const minOptions = new Array(60).fill(0).map((_, value: number) => ({
		label: value.toString().padStart(2, '0'),
		value: value
	}));
</script>

<div class="time-picker">
	<TimeIcon />
	<div class="element">
		<label for="hour"> ساعت </label>
		<Select
			items={hourOptions}
			bind:justValue={value.hour}
			value={hourOptions.find((v) => v.value === value.hour)}
			containerStyles="width:fit-content"
			clearable={false}
		/>
	</div>
	<div class="element">
		<label for="hour"> دقیقه </label>
		<Select
			items={minOptions}
			bind:justValue={value.minute}
			value={minOptions.find((v) => v.value === value.minute)}
			containerStyles="width:fit-content"
			clearable={false}
		/>
	</div>
</div>

<style lang="scss">
	.time-picker {
		display: flex;
		flex-direction: row-reverse;
		align-items: center;
		gap:0.5em;
		& > :global(*) {
			margin-bottom: 0 !important;
		}
		& > :global(*:first-child) {
			margin-inline-start: 0.5em !important;
		}

		& :global(.svelte-select) {
			background-color: rgb(55 65 81 / var(--tw-bg-opacity))!important;
		}
	}

	.element {
		display: flex;
		flex-direction: column;
		align-items: center;
	}
</style>
