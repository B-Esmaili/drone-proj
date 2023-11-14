<script>
	import { Dropdown, DropdownItem, Avatar, Button } from 'flowbite-svelte';
	import { BellOutline } from 'flowbite-svelte-icons';
	import NotifItem from './notif-item.svelte';
</script>

<Button color="none" id="notif-trigg">
	<BellOutline tabindex="-1" class="!outline-none" />
</Button>
<Dropdown triggeredBy="#notif-trigg" class="flex max-h-96 w-screen max-w-xl">
	<div slot="header" class="px-4 py-2 flex justify-center">
		<span class="block truncate text-sm font-medium"> Notifications </span>
	</div>
	<div class="flex-1 overflow-auto">
		<NotifItem imageUrl="/fake/notif/boonie-green.png">
			<div class="text-gray-500 font-normal text-sm mb-1.5 dark:text-gray-400">
				New message from <span class="font-semibold text-gray-900 dark:text-white"
					>Bonnie Green</span
				>: "Hey, what's up? All set for the presentation?"
			</div>
			<div class="text-xs font-medium text-primary-700 dark:text-primary-400">
				a few moments ago
			</div>
		</NotifItem>		
	</div>
</Dropdown>
