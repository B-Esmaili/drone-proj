<script lang="ts">
	import { goto } from '$app/navigation';
	import { Button, Card, Helper, Input, Label, Select } from 'flowbite-svelte';
	import type { PageData } from './$types';
	import { superForm } from 'sveltekit-superforms/client';

	export let data: PageData;

	// Client API:
	const { form, message, enhance, errors } = superForm(data.form, {
		dataType: 'json',
		onResult: (result) => {
			if (result.result.status === 200) {
				setTimeout(() => {
					goto('/login');
				}, 10);
			}
		}
	});

	const hourOptions: any = [
		{
			name: 'پایلوت',
			value: 1
		},
		{
			name: 'مشتری',
			value: 2
		},
		{
			name: 'شهرداری',
			value: 3
		}
	];
</script>

<svelte:head>
	<title>Stable | Sign Up</title>
	<meta name="description" content="SvelteKit - Lucia - Drizzle ORM Template" />
</svelte:head>

<div class="h-screen flex items-center justify-center">
	<Card class="w-full max-w-md bg-white">
		<div class="flex justify-center">
			<h1 class="text-2xl font-semibold">ایجاد حساب کاربری</h1>
		</div>
		<form method="POST" use:enhance>
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
				{#if $errors.email}
					<Helper class="mt-2" color="red">لطفا ایمیل را وارد کنید</Helper>
				{/if}
			</div>
			<div class="mb-6">
				<Label for="password" class="block mb-2">کلمه عبور</Label>
				<Input
					id="password"
					name="password"
					type="password"
					autocomplete="off"
					placeholder="کلمه عبور"
					class="input input-bordered"
					bind:value={$form.password}
				/>
				{#if $errors.password}
					<Helper class="mt-2" color="red">لطفا کلمه عبور را وارد کنید</Helper>
				{/if}
			</div>
			<div>
				<Label for="type" class="block mb-2">نوع کاربر</Label>
				<Select
					items={hourOptions}
					bind:value={$form.type}
					placeholder="نوع کاربری را انتخاب کنید"
				/>
			</div>
			<br />
			<div>
				<Label for="type" class="block mb-2">نام نمایشی</Label>
				<Input bind:value={$form.displayName} placeholder="نوع کاربری را انتخاب کنید" />
				{#if $errors.displayName}
					<Helper class="mt-2" color="red">لطفا نام نمایشی را وارد کنید</Helper>
				{/if}
			</div>
			<div class="form-control mt-6">
				<Button class="btn btn-primary" type="submit">ثبت نام</Button>
			</div>
		</form>
		<div class="mt-2">
			<p>قبلا حساب کاربری دارید؟ <a href="/login" class="text-blue-600 underline">ورود</a></p>
		</div>
	</Card>
</div>
