<script lang="ts">
	import { Checkbox, Heading, Toggle } from 'flowbite-svelte';
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

	const handleStatusChange = (project: any) => async (e) => {
		const status = e.target.checked;
		const pid = project.id;

		const resp = await fetch('/api/project', {
			method: 'POST',
			headers: {
				'Content-Type': 'application/json'
			},
			body: JSON.stringify({
				status,
				pid
			})
		});
		if (resp.status !== 200) {
			alert('error occured!');
			return;
		}

		const res = await resp.json();

		if (res.ok) {
            if (status){
			  alert('Project Confirmed!');
            }else{
			  alert('Project Rejected!');
            }
		} else {
			alert('error occured!');
		}
	};
</script>

<Heading tag="h3">پروژه های من</Heading>

<br />

<Table>
	<TableHead>
		<TableHeadCell>مشتری</TableHeadCell>
		<TableHeadCell>پایلوت</TableHeadCell>
		<TableHeadCell>منابع</TableHeadCell>
		<TableHeadCell>زمان</TableHeadCell>
		<TableHeadCell>مکان</TableHeadCell>
		<TableHeadCell>تایید شده</TableHeadCell>
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
				<TableBodyCell>{@html formatDate(project.time, "date-time-semantic")}</TableBodyCell>
				<TableBodyCell>{project.location}</TableBodyCell>
				<TableBodyCell
					><Toggle
						checked={project.confirmed}
						on:change={handleStatusChange(project)}
					/></TableBodyCell
				>
			</TableBodyRow>
		{/each}
	</TableBody>
</Table>
