<script lang="ts">
	import { formatDate, formatPrice } from '$lib/utils/utils';
	import type { PageData } from './$types';
	import {
		Badge,
		Table,
		TableBody,
		TableBodyCell,
		TableBodyRow,
		TableHead,
		TableHeadCell
	} from 'flowbite-svelte';

	export let data: PageData;
</script>

<Table>
	<TableHead>
		<TableHeadCell>مشتری</TableHeadCell>
		<TableHeadCell>پایلوت</TableHeadCell>
		<TableHeadCell>منابع</TableHeadCell>
		<TableHeadCell>زمان</TableHeadCell>
		<TableHeadCell>مکان</TableHeadCell>
	</TableHead>
	<TableBody class="divide-y">
		{#each data.projects as project}
			<TableBodyRow>
				<TableBodyCell>{project.customer.displayName}</TableBodyCell>
				<TableBodyCell>{project.pilot.displayName}</TableBodyCell>
				<TableBodyCell
					>{#each project.invoices as invoice}
						<Badge color="green"
							>{invoice.resource.name} ({formatPrice(invoice.resource.price)})
						</Badge>
					{/each}</TableBodyCell
				>
				<TableBodyCell>{formatDate(project.time)}</TableBodyCell>
				<TableBodyCell>{project.location}</TableBodyCell>
			</TableBodyRow>
		{/each}
	</TableBody>
</Table>
