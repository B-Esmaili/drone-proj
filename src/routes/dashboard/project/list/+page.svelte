<script lang="ts">
	import ProjectStatusView from '$lib/components/ProjectStatusView.svelte';
import { ProjectStatus } from '$lib/models';
	import { formatDate, formatPrice } from '$lib/utils/utils';
	import type { PageData } from './$types';
	import {
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

	export let data: PageData;
</script>

<div class="toolbar">
	<Heading tag="h3">پروژه ها</Heading>
	<Button href="/dashboard/project/edit-or-create">ایجاد پروژه جدید</Button>
</div>

<br />

<Table>
	<TableHead>
		<TableHeadCell>مشتری</TableHeadCell>
		<TableHeadCell>پایلوت</TableHeadCell>
		<TableHeadCell>منابع</TableHeadCell>
		<TableHeadCell>زمان</TableHeadCell>
		<TableHeadCell>مکان</TableHeadCell>
		<TableHeadCell>وضعیت پروژه</TableHeadCell>
		<TableHeadCell />
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
				<TableBodyCell> 
				{#if project.status === ProjectStatus.AdminReview}
					<ProjectStatusButtons projectId={project.id}/>
				 {:else}
				    <ProjectStatusView value={project.status}/>
				{/if}	
				</TableBodyCell>
				<TableBodyCell>
					<Button href={`/dashboard/project/edit-or-create?id=${project.id}`}>ویرایش</Button>
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
			width: 160px!important;
		}
	}
</style>
