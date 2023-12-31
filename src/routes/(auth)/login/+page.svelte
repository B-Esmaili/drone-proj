<script lang="ts">
	import { Button, Card, Input, Label } from 'flowbite-svelte';
	import type { PageData } from './$types';
	import { superForm } from 'sveltekit-superforms/client';

	export let data: PageData;

	// Client API:
	const { form } = superForm(data.form);
</script>

<svelte:head>
	<title>Stable | Login</title>
	<meta name="description" content="SvelteKit - Lucia - Drizzle ORM Template" />
</svelte:head>
<div class="h-screen flex items-center justify-center">
	<!-- write following form using flowbite svelte -->
	<Card class="w-full max-w-md">
		<div class="flex justify-center">
			<h1 class="text-2xl font-semibold"> ورود به سیستم </h1>
		</div>
		<form method="POST">
			<div class="mb-6">
				<Label for="email" class="block mb-2">ایمیل</Label>
				<Input
					id="email"
					name="email"
					type="text"
					placeholder="ایمیل"
					class="input input-bordered"
					bind:value={$form.email}
				/>
			</div>
			<div class="mb-6">
				<Label for="password" class="block mb-2">کلمه عبور</Label>
				<Input
					id="password"
					name="password"
					type="password"
					placeholder="کلمه عبور"
					class="input input-bordered"
					bind:value={$form.password}
				/>
			</div>
			<div class="form-control mt-6">
				<Button class="btn btn-primary" type="submit">ورود</Button>
			</div>
			<div class="mt-2">
				<p>حساب کاربری ندارید ? <a href="/signup" class="text-blue-600 underline">ثبت نام کنید</a></p>
			</div>
		</form>
	</Card>
</div>
