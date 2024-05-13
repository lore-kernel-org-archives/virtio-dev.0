Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F74F84A31
	for <virtio-dev@lists.linux.dev>; Mon, 13 May 2024 21:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715637233; cv=none; b=UpNhiM5Emb4T6IrWhA1JDlFZFKBOskDruNZVGnwnLh/bjp85unsyIQHj8i+HYaBX5+L6aW3cSLTKuq9xpVEVsrAxwGE7TcqUhUne2z7mIaW21U67u2/zGuNno75bQ86jQPO9WwcrSFaMT2jyhwrqTJeFlmwYOTq2o/23Vwp6oYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715637233; c=relaxed/simple;
	bh=enq+I3M6j1qSOYoAW9qRNPTj6zEZU2ap8EG2e4x5gcY=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tnUI/Vjq7d5n5ZUuEjGXAznsKMorV0HMOQFMLd7J1KbQddMi54LgTuKcN7ASIB31+l6Q84cDxCS6wEkw0OWsdQBQpWSGQkd9e0/74W9ldalAhvspaD5cQeB1XUdv6iS3DLZMDbicPCFz4l2FZudQIx0nopfyn0/9Xo+3MATF9sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=A0i4liEI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="A0i4liEI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBB39C2BD11;
	Mon, 13 May 2024 21:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715637232;
	bh=enq+I3M6j1qSOYoAW9qRNPTj6zEZU2ap8EG2e4x5gcY=;
	h=Date:From:To:Subject:From;
	b=A0i4liEItJY4bqrM8KKPTZ3i2YJ59DPcpqoXq9RjZCxxGLd2R4IM4NVXWhRUpZcPW
	 EJgbZDNN9dFMle5IFt/OoluZHEErS/9vJWxyOXJqfzgiEaJNzDssF0X73Q8GVcE3ES
	 GTkEAgO5irLEh6DY1PC/Cw/z6Je3srw3pJ3+DDN4=
Date: Mon, 13 May 2024 17:53:48 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: virtio-dev@lists.linux.dev
Subject: Test archive propagation
Message-ID: <20240513-fluorescent-friendly-scorpion-b2f4bb@meerkat>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Testing archive propagation. Please ignore.

-K
