<script lang="ts">
	import ProjectStatusView from '$lib/components/ProjectStatusView.svelte';
	import { ProjectStatus } from '$lib/models';
	import { formatDate, formatPrice } from '$lib/utils/utils';
	import type { PageData } from './$types';
	import {
		Alert,
		Badge,
		Button,
		Heading,
		Table,
		TableBody,
		TableBodyCell,
		TableBodyRow,
		TableHead,
		TableHeadCell,
		Toggle
	} from 'flowbite-svelte';
	import ProjectStatusButtons from '../../../../lib/components/ProjectStatusButtons.svelte';
	import { invalidateAll } from '$app/navigation';

	export let data: PageData;
</script>

<Table hoverable={true}>
	<TableHead>
		<TableHeadCell>مشتری</TableHeadCell>
		<TableHeadCell>پایلوت</TableHeadCell>
		<TableHeadCell>منابع</TableHeadCell>
		<TableHeadCell>زمان شروع</TableHeadCell>
		<TableHeadCell>زمان پایان</TableHeadCell>
		<TableHeadCell>مکان</TableHeadCell>
		<TableHeadCell class="w-2">توضیحات پروژه</TableHeadCell>
		<TableHeadCell>پیام کاربر</TableHeadCell>
		<TableHeadCell>وضعیت پروژه</TableHeadCell> 
	</TableHead>
	<TableBody class="divide-y">
		{#each data.projects as project}
			<TableBodyRow  color={project.isTaget ? 'yellow' : undefined}>
				<TableBodyCell>{project.customer.displayName}</TableBodyCell>
				<TableBodyCell>{project.pilot.displayName}</TableBodyCell>
				<TableBodyCell tdClass="w-50"
					>{#each project.invoices as invoice}
						<Badge color="green"
							>{invoice.resource.name} ({formatPrice(invoice.resource.price)})
						</Badge>
					{/each}</TableBodyCell
				>
				<TableBodyCell>{@html formatDate(project.time, 'date-time-semantic')}</TableBodyCell>
				<TableBodyCell>{@html formatDate(project.endTime, 'date-time-semantic')}</TableBodyCell>
				<TableBodyCell>{project.location}</TableBodyCell>
				<TableBodyCell tdClass="w-4">
					<div>
						{project.desc}
					</div>
				</TableBodyCell>
				<TableBodyCell>
					<Alert color="red">
						{project.message}
					</Alert>
				</TableBodyCell>
				<TableBodyCell>
					{#if project.status === ProjectStatus.AdminReview}
						<ProjectStatusButtons projectId={project.id} onResult={invalidateAll} />
					{:else if project.status === ProjectStatus.AdminFinalize}
						<ProjectStatusButtons
							onResult={invalidateAll}
							projectId={project.id}
							forwardLabel="تایید نهایی"
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
