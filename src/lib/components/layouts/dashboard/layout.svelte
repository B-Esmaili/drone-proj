<script>
	import Header from './header/header.svelte';
	import Sidebar from './sidebar/sidebar.svelte';
</script>

<Header />
<div class="flex 
			pt-16
			overflow-hidden
			bg-gray-50
			dark:bg-gray-900
			min-h-screen">
	<div class="fixed h-[calc(100vh-4em)] h-screen w-64 -translate-x-full md:translate-x-0">
		<Sidebar />
	</div>
	<div class="flex-1 md:ms-64 p-6">
		<slot />
	</div>
</div>
