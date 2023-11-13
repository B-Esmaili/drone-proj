<script lang="ts">
	import { goto } from '$app/navigation';
	import { Button, Card, Input, Label } from 'flowbite-svelte';
	import type { PageData } from './$types';
	import { superForm } from 'sveltekit-superforms/client';

	export let data: PageData;

	// Client API:
	const { form, message, enhance } = superForm(data.form, {
		onResult: (result) => {
			if (result.result.status === 200) {
				setTimeout(() => {
					goto('/login');
				}, 10);
			}
		}
	});
</script>

<svelte:head>
	<title>Stable | Sign Up</title>
	<meta name="description" content="SvelteKit - Lucia - Drizzle ORM Template" />
</svelte:head>

<div class="h-screen flex items-center justify-center">
	<Card class="w-full max-w-md">
		<div class="flex justify-center">
			<h1 class="text-2xl font-semibold">Create Account</h1>
		</div>
		<form method="POST" use:enhance>
			<div class="mb-6">
				<Label for="email" class="block mb-2">Email</Label>
				<Input
					id="email"
					name="email"
					type="text"
					placeholder="email"
					class="input input-bordered"
					bind:value={$form.email}
				/>
			</div>
			<div class="mb-6">
				<Label for="password" class="block mb-2">Password</Label>
				<Input
					id="password"
					name="password"
					type="text"
					placeholder="password"
					class="input input-bordered"
					bind:value={$form.password}
				/>
			</div>
			<div class="form-control mt-6">
				<Button class="btn btn-primary" type="submit">Sign Up</Button>
			</div>
		</form>
		<div class="mt-2">
			<p>Already have an account? <a href="/login" class="text-blue-600 underline">LogIn</a></p>
		</div>
	</Card>
</div>
