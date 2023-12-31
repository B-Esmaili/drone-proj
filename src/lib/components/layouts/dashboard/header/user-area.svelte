<script>
	import { page } from '$app/stores';
	import {
		Dropdown,
		DropdownItem,
		Avatar,
	} from 'flowbite-svelte';

	const email = $page.data.user.email;
    
</script>

<Avatar class="acs"    
 />
 
<Dropdown triggeredBy=".acs">
	<div slot="header" class="px-4 py-2">
		<!-- <span class="block text-sm text-gray-900 dark:text-white">Bonnie Green</span> -->
		<span class="block truncate text-sm font-medium">{email}</span>
	</div>
	<DropdownItem slot="footer" href="/logout">Sign out</DropdownItem>
</Dropdown>
