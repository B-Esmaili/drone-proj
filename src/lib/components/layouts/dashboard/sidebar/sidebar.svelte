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

</script>
 
<Sidebar class="h-full" {activeUrl}>
	<SidebarWrapper class="h-full">
		<SidebarGroup>
			<SidebarItem label="Dashboard" href="/dashboard">
				<svelte:fragment slot="icon">
					<ChartPieSolid
						class="w-5 h-5 text-gray-500 transition duration-75 dark:text-gray-400 group-hover:text-gray-900 dark:group-hover:text-white"
					/>
				</svelte:fragment>
			</SidebarItem>			 
		</SidebarGroup>
	</SidebarWrapper>
</Sidebar>
