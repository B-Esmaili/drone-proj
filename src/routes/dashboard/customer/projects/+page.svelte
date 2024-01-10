<script lang="ts">
	import { Button, Checkbox, Heading, Toggle } from 'flowbite-svelte';
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
	import ProjectStatusView from '$lib/components/ProjectStatusView.svelte';
	import { ProjectStatus } from '$lib/models';
	import ProjectStatusButtons from '$lib/components/ProjectStatusButtons.svelte';
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
			if (status) {
				alert('Project Confirmed!');
			} else {
				alert('Project Rejected!');
			}
		} else {
			alert('error occured!');
		}
	};
</script>

<div class="toolbar">
	<Heading tag="h3">پروژه های من</Heading>
	<Button href="/dashboard/customer/edit-or-create-project">ایجاد پروژه جدید</Button>
</div>

<br />

<Table>
	<TableHead>
		<TableHeadCell>مشتری</TableHeadCell>
		<TableHeadCell>پایلوت</TableHeadCell>
		<TableHeadCell>منابع</TableHeadCell>
		<TableHeadCell>زمان</TableHeadCell>
		<TableHeadCell>مکان</TableHeadCell>
		<TableHeadCell>وضعیت</TableHeadCell>
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
				<TableBodyCell>{@html formatDate(project.time, 'date-time-semantic')}</TableBodyCell>
				<TableBodyCell>{project.location}</TableBodyCell>
				<TableBodyCell>
					{#if project.status && [ProjectStatus.CustomerEdit].includes(project.status)}
						<ProjectStatusButtons
							projectId={project.id}
							forwardLabel="در خواست بازبینی"
							backwardLabel="ابطال"
						/>
					{:else if ProjectStatus.CustomerPay === project.status}
						<ProjectStatusButtons
							projectId={project.id}
							forwardLabel="پرداخت"
							backwardLabel="ابطال"
						/>
					{:else}
						<ProjectStatusView value={project.status} />
					{/if}
				</TableBodyCell>
			</TableBodyRow>
		{/each}
	</TableBody>
</Table>

<style lang="scss">
	.toolbar {
		display: flex;
		align-items: center;
		justify-content: space-between;
		& :global(a) {
			width: 160px !important;
		}
	}
</style>
