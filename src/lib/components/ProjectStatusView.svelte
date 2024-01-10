<script lang="ts">
	import { ProjectStatus } from '$lib/models';

	export let value: ProjectStatus | number | null;

	const map: Record<any, any> = {
		[ProjectStatus.AdminReview]: 'منتظر تایید مدیر',
		[ProjectStatus.MunicipalReview]: 'منتظر تایید شهرداری',
		[ProjectStatus.PilotReview]: 'منتظر تایید پایلوت',
		[ProjectStatus.CustomerPay]: 'منتظر پرداخت مشتری',
		[ProjectStatus.CustomerEdit]: 'ویرایش توسط کاربر',
		[ProjectStatus.AdminFinalize]: 'منتظر تایید نهایی توسط مدیر',
		[ProjectStatus.Cancel]: 'لغو شده توسط کاربر',
		[ProjectStatus.Final]: 'تایید نهایی',
		[ProjectStatus.CancelByAdmin]: 'ابطال توسط مدیر'
	};
</script>

{value ? map[value] : '-'}
