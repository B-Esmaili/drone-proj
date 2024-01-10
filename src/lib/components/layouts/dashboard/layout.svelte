<script>
	import { Card } from 'flowbite-svelte';
	import Header from './header/header.svelte';
	import Sidebar from './sidebar/sidebar.svelte';
</script>

<Header />
<div
	class="flex
			pt-16
			overflow-hidden
			bg-gray-50
			dark:bg-gray-900
			min-h-screen"
>
	<div
		id="sidebar"
		class="fixed
	 			h-[calc(100vh-4em)]
				h-screen
				w-64
				-translate-x-full
				[&.show]:translate-x-0
				md:translate-x-0
				transition-transform
				ease-in-out
				"
	>
		<Sidebar />
	</div>
	<div class="flex-1 md:ms-64 p-6" style="width:calc(100% - 16rem)">
		<Card class="w-full max-w-none">
				<slot />
		</Card>
	</div>
</div>
