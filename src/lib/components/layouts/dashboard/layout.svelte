<script>
	import Header from './header/header.svelte';
</script>

<Header />
<div class="flex pt-16 overflow-hidden bg-gray-50 dark:bg-gray-900">
	<slot />
</div>
