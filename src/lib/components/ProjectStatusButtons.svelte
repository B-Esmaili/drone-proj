<script lang="ts">
	import { modifyProjectStatus } from '$lib/shared/project-utils';
	import { Button, ButtonGroup } from 'flowbite-svelte';
	import { Toast } from 'flowbite-svelte';
	import { CheckCircleSolid } from 'flowbite-svelte-icons';
	import { slide } from 'svelte/transition';
	export let projectId: number;
	export let onResult: (result: boolean) => void | undefined = undefined;
	let result: boolean | null = null;

	export let forwardLabel = 'تایید';
	export let backwardLabel = 'عدم تایید';

	const handleConfirm = (status: number) => async () => {
		if (!confirm('آیا مطمپن هستید؟')) {
			return;
		}

		let message = '';
		if (status === 0) {
			const msg = prompt('Enter message for reciepant :');
			if (!msg) {
				return;
			}
			message = msg;
		}

		const r = await modifyProjectStatus(projectId, status, message);

		alert(r ? 'عملیات با موفقیت انجام شد' : 'عملیات با خطا مواجه شد');

		onResult && onResult(r);
		result = r;
	};
</script>

<ButtonGroup>
	<Button color="green" on:click={handleConfirm(1)}>{forwardLabel}</Button>
	<Button color="red" on:click={handleConfirm(0)}>{backwardLabel}</Button>
</ButtonGroup>
