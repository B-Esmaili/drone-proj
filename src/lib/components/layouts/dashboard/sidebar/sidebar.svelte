<script>
	import { page } from '$app/stores';
	import {
		Sidebar,
		SidebarGroup,
		SidebarItem,
		SidebarWrapper,
		SidebarDropdownItem,
		SidebarDropdownWrapper
	} from 'flowbite-svelte';
	import {
		ChartPieSolid,
		GridSolid,
		ShoppingCartSolid,
		MailBoxSolid,
		UserSolid,
		ArrowRightToBracketSolid,
		FileEditSolid
	} from 'flowbite-svelte-icons';
	let spanClass = 'flex-1 ml-3 whitespace-nowrap';
	$: activeUrl = $page.url.pathname;

	$: isMayor = $page.data.user.type === 3;
	$: isAdmin = $page.data.user.type === 0;
	$: isCustomer = $page.data.user.type === 2;
</script>

<Sidebar class="h-full" {activeUrl}>
	<SidebarWrapper class="h-full">
		<SidebarGroup>
			<!-- <SidebarItem label="داشبورد" href="/dashboard">
				<svelte:fragment slot="icon">
					<ChartPieSolid
						class="w-5 h-5 text-gray-500 transition duration-75 dark:text-gray-400 group-hover:text-gray-900 dark:group-hover:text-white"
					/>
				</svelte:fragment>
			</SidebarItem> -->
			{#if isMayor}
				<SidebarItem label="پروژه ها" href="/dashboard/mayor/projects">
					<svelte:fragment slot="icon">
						<ChartPieSolid
							class="w-5 h-5 text-gray-500 transition duration-75 dark:text-gray-400 group-hover:text-gray-900 dark:group-hover:text-white"
						/>
					</svelte:fragment>
				</SidebarItem>
			{/if}
			{#if isAdmin}
				<SidebarItem label="پروژه ها" href="/dashboard/project/list">
					<svelte:fragment slot="icon">
						<ChartPieSolid
							class="w-5 h-5 text-gray-500 transition duration-75 dark:text-gray-400 group-hover:text-gray-900 dark:group-hover:text-white"
						/>
					</svelte:fragment>
				</SidebarItem>
			{/if}
			{#if isCustomer}
				<SidebarItem label="پروژه ها" href="/dashboard/customer/projects">
					<svelte:fragment slot="icon">
						<ChartPieSolid
							class="w-5 h-5 text-gray-500 transition duration-75 dark:text-gray-400 group-hover:text-gray-900 dark:group-hover:text-white"
						/>
					</svelte:fragment>
				</SidebarItem>
			{/if}
		</SidebarGroup>
	</SidebarWrapper>
</Sidebar>
