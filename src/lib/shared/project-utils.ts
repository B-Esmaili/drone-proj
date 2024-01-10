export const modifyProjectStatus = async (projectId: number, status: number , message:string) => {
	const data = {
		projectId,
		status,
		message
	};

	const resp = await fetch('/api/project/status', {
		method: 'POST',
		headers: {
			'Content-Type': 'application-json'
		},
		body: JSON.stringify(data)
	});

	if (resp.status !== 200) {
		return false;
	}

	const result = await resp.json();

	if (!result) {
		return false;
	}

	return true;
};
