<script lang="ts">
	import { page } from '$app/stores';
	import { Dropdown, DropdownItem, Avatar } from 'flowbite-svelte';

	const email = $page.data.user.email;
	const displayName = $page.data.user.display_name;

	let userType = $page.data.user.type;

	let map: Record<number, string> = {
		0: 'مدیر کل',
		2: 'مشتری',
		3: 'شهرداری',
		1: 'پایلوت'
	};

	$: userTYpeName = map[$page.data.user.type];
</script>

<div class="user-menu">
	<Avatar class="acs" />
	<div>
		{$page.data.user.displayName} ({userTYpeName})
	</div>
</div>
<Dropdown triggeredBy=".acs">
	<div slot="header" class="px-4 py-2">
		<!-- <span class="block text-sm text-gray-900 dark:text-white">Bonnie Green</span> -->
		<span class="block truncate text-sm font-medium">{email}</span>
	</div>
	<DropdownItem slot="footer" href="/logout">Sign out</DropdownItem>
</Dropdown>

<style lang="scss">
	.user-menu {
		display: flex;
		align-items: center;
		gap: 1em;
		flex-direction: row-reverse;
	}
</style>
