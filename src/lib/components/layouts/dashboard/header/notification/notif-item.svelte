<script lang="ts">
	export let href = '#';
	export let imageUrl = "";
</script>

<a
	{href}
	class="flex px-4 py-3 border-b hover:bg-gray-100 dark:hover:bg-gray-600 dark:border-gray-600"
>
	{#if imageUrl}
		<div class="flex-shrink-0">
			<img class="rounded-full w-11 h-11" src={imageUrl} alt="fakeimage" />		 
		</div>
	{/if}
	<div class="w-full pl-3">
		<slot/>
	</div>
</a>
