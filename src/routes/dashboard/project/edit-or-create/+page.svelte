<script lang="ts">
	import {
		Button,
		Datepicker,
		Heading,
		Helper,
		Input,
		Label,
		MultiSelect,
		Select,
		Spinner
	} from 'flowbite-svelte';
	import type { PageData } from './$types';
	import { formatPrice } from '$lib/utils/utils';
	import { superForm } from 'sveltekit-superforms/client';
	import SuperDebug from 'sveltekit-superforms/client/SuperDebug.svelte';
	import DatePicker from '$lib/components/persian-dp/date-picker.svelte';
	import TimePicker from '$lib/components/time-picker/time-picker.svelte';

	export let data: PageData;
	let saving: boolean = false;

	$: resourceOptions = data.resources.map(({ id, name, price }) => ({
		name: `${name} (${formatPrice(price)})`,
		price,
		value: id
	}));

	$: pilotOptions = data.pilots.map(({ id, displayName }) => ({
		name: displayName ?? '',
		value: id
	}));

	$: customerOptions = data.customers.map(({ id, displayName }) => ({
		name: displayName ?? '',
		value: id
	}));

	// let total = 0;

	// $: {
	// 	debugger
	// 	if (resourceOptions.length){
	// 		total = resourceOptions.reduce((p,c)=> p + parseInt(c.value) ,0)
	// 	}
	// }

	const { form, enhance, errors } = superForm(data.form, {
		dataType: 'json',
		onSubmit: () => {
			saving = true;
		},
		onResult: () => {
			saving = false;
		}
	});
</script>

<Heading tag="h4">ایجاد پروژه جدید</Heading>

<br />

<form method="post" use:enhance>
	<Label for="with_helper" class="pb-2">
		منابع
		<MultiSelect color="red" class="mt-2" items={resourceOptions} bind:value={$form.resourceIds} />
		{#if $errors.resourceIds}
			<Helper class="mt-2" color="red">لطفا منابع را انتخاب کنید</Helper>
		{/if}
	</Label>
	<Label for="with_helper" class="pb-2">
		مشتری
		<Select
			class="mt-2"
			items={customerOptions}
			bind:value={$form.customerId}
			placeholder="انتخاب کنید..."
		/>
		{#if $errors.customerId}
			<Helper class="mt-2" color="red">لطفا مشتری را انتخاب کنید</Helper>
		{/if}
	</Label>
	<Label for="with_helper" class="pb-2">
		پایلوت
		<Select
			class="mt-2"
			items={pilotOptions}
			bind:value={$form.pilotId}
			placeholder="انتخاب کنید..."
			erro
		/>
		{#if $errors.pilotId}
			<Helper class="mt-2" color="red">لطفا پایلوت را انتخاب کنید</Helper>
		{/if}
	</Label>
	<Label for="time">
		زمان
		<div class="date-time-picker">
			<div>
				<DatePicker bind:value={$form.dateValue} />
			</div>
			<div>
				<TimePicker bind:value={$form.timeValue} />
			</div>
		</div>
		{#if $errors.dateValue}
			<Helper class="mt-2" color="red">لطفا زمان را انتخاب کنید</Helper>
		{/if}
	</Label>
	<Label for="location">
		مکان
		<div>
			<Input bind:value={$form.location} />
		</div>
		{#if $errors.dateValue}
			<Helper class="mt-2" color="red">لطفا زمان را انتخاب کنید</Helper>
		{/if}
	</Label>
	<br />
	<!-- {total} -->
	<div>
		<Button primary load type="submit">
			{#if saving}
				<Spinner class="me-3" size="4" color="white" />
				در حال ذخیره سازی
			{:else}
				ذخیره
			{/if}
		</Button>
	</div>
	<!-- <div style="direction:ltr">
		<SuperDebug data={$form} />
	</div> -->
</form>

<style lang="scss">
	.date-time-picker {
		display: flex;
		align-items: center;
		gap: 1em;
		& > div:nth-child(1) {
			flex: 1;
			margin-top: 1em;
		}
	}
</style>
