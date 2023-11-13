<script>
	import { Card, DarkMode, Navbar } from 'flowbite-svelte';
	import Branding from './branding.svelte';
	import UserArea from './user-area.svelte';
	import Notification from './notification/notification.svelte';
	let darkmodebtn =
		'text-gray-500 dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-700 focus:outline-none focus:ring-4 focus:ring-gray-200 dark:focus:ring-gray-700 rounded-lg text-lg p-2.5 right-4 top-2 z-50';
</script>

<nav class="fixed z-30 w-full border-b border-gray-200 dark:bg-gray-800 dark:border-gray-700">
	<div class="px-3 py-3 lg:px-5 lg:pl-3 flex items-center justify-between">
		<Branding />
		<div class="flex gap-2 items-center flex-row-reverse">
			<UserArea/>
			<DarkMode btnClass={darkmodebtn} />
			<Notification/>
		</div>
	</div>
</nav>
