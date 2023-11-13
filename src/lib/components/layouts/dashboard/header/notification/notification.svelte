<script>
	import { Dropdown, DropdownItem, Avatar, Button } from 'flowbite-svelte';
	import { BellOutline } from 'flowbite-svelte-icons';
	import NotifItem from "./notif-item.svelte"
</script>

<Button color="none" id="notif-trigg">
	<BellOutline tabindex="-1" class="!outline-none" />
</Button>
<Dropdown triggeredBy="#notif-trigg">
	<div slot="header" class="px-4 py-2 flex justify-center">
		<span class="block truncate text-sm font-medium"> Notifications </span>
	</div>
	<div>
		<NotifItem/>
	</div>
</Dropdown>
