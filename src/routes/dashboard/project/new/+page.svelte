<script lang="ts">
	import { Label, MultiSelect, Select } from 'flowbite-svelte';
	import type { PageData } from './$types';

	export let data: PageData;

	$: resourceOptions = data.resources.map(({ id, name, price }) => ({
		name: name ?? '',
		price,
		value: id
	}));
</script>

<form>
	<Label for="with_helper" class="pb-2">
        منابع
		<MultiSelect class="mt-2" items={resourceOptions} />
	</Label>
</form>
