Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5399B296BA2
	for <virtio-dev@lists.linux.dev>; Mon, 25 Aug 2025 21:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756156387; cv=none; b=pV/Rq6UGj1BLYQZPvrwSCyShnNYu1MPYNcIITtUP7K5FlHVsZ1aZvpJMu3Ndn6PX4nEE0/HN28iHSVQ5MMgFpM+HAcstz/3C3Qgl9kN0Y4ogmCa3YFB4SPvr5oKq6ia8gaUVJj+OfxV1Qls4uQkI7M77iAmt97OM53kyRtV11Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756156387; c=relaxed/simple;
	bh=jq6m8Rl4YKfIiiPzSdMO2t0NpB1Z8C6ZGhVZOyvUxV0=;
	h=From:Date:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KkYTGETJOBhgYmrlfZhaJ+lkf1TxG7fY2FwPoXhvjr2pymGu3aRJX6SLj6/CbhhJ05SeFJ+UMPYHPlaVPhQ7eH+qPxRXRz9sqCPCtfCcX4bBHpptaeUO0GtfcGPWJt0uq38Mbg2h5BI0v49X6geVog9OjSqAaSFui3iLIJJ14yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YOX5s0hQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YOX5s0hQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756156383;
	h=from:from:sender:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:mime-version:mime-version:
	 content-type:content-type; bh=jq6m8Rl4YKfIiiPzSdMO2t0NpB1Z8C6ZGhVZOyvUxV0=;
	b=YOX5s0hQxF99oxITRQQEPRMjTKPatn/UJ+y9BDf0bnGQq6r0HMxbS1u8bcNEXzDxBDg/sk
	tLpPPlNtW885YSyvvAtd0bIYsu25wgCdTcqBDk/3Ia/hEojdvsVvBlDNcPTtLS3Ik6hTKJ
	b3wt05ZxTRauZxFF+jQXpc54VEKTyho=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-eqSxSePWM0WmaQcwXC_7Dg-1; Mon, 25 Aug 2025 17:13:01 -0400
X-MC-Unique: eqSxSePWM0WmaQcwXC_7Dg-1
X-Mimecast-MFC-AGG-ID: eqSxSePWM0WmaQcwXC_7Dg_1756156379
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45a1b0c5366so28657275e9.3
        for <virtio-dev@lists.linux.dev>; Mon, 25 Aug 2025 14:13:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756156379; x=1756761179;
        h=content-disposition:mime-version:message-id:subject:to:date:from
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jq6m8Rl4YKfIiiPzSdMO2t0NpB1Z8C6ZGhVZOyvUxV0=;
        b=s/5f1NPMWKicWMJJNfI889WZesWBA2sUYcPFmnyOK7f/Wd/81KMRhAClNB+wISIEIT
         xg1aaK8ip6jLjXlbtA/qHkLckESuJXZM0Tr4nvOFN1B0zf3k4ClRk3LlVDPJTK1snf6m
         sOjxKOpauSmIiz9OD+QYpfdmG7cc0jBMcxnR6GfOYqL7vpTyvmoae4H66zPlbTBqo20S
         XHFq/N8/yS0/CDe7fMvDZaVrOD2M1UOxU08d77wmnD5R/WGJj9EIRFpftWLFBbsSPD2s
         ySVe08uo1iWEqFTMdrwQ5NmV5+chios53EOyfnhYwhe5NkpsZlviIrTsEarMvxUTClhy
         oR/Q==
X-Gm-Message-State: AOJu0YzdF0WCKREa6Mrqqaumy2SPqA9AFNuhDu+IQT7dRzcHNbNWt32o
	ds3R9a09uJXJU7vI0mC9gWzC6ApQiovlubxir0oKfRnIqd1tv66RhzFxpLDnnOMYZTZ/93NrHfm
	q/h1aKX21OpqIFwjzlg649HX53mFi3z8PEUSx74vbviegFHifkwy8tQD5PjiaUmeeRvdVUv+xjq
	BiMbq6QaN1DspIsJ7XF3BAK8bdJL8lio0zyiXq46yFLA77tw==
X-Gm-Gg: ASbGncuF/fYBVMK9LD+pFT8pIXbNa8fqCbw2LZL1JMhy57zcAG4xrBlwCt0iKrcuCRX
	rgazF+bxadMVYIK+GWuNCwEDESZ7dBLWjj+lx+DHY6j8kQE6bH1g8Hr22KADbawk7RYkj56+MQW
	PDfnWcm93tZgK6F1cP7JKvrZcu1xcTXzTnbEgTsiNIkYgszQyA5g/tajbRTTW6d3YYJslOG6Eep
	ZuToc19mGGyjKwKPpmJMdLTOV3OaF8FgzcMjWOSl1RRu8zWdAbZW397FGAQfdl/bvwj/j89pbu9
	MKfM+U/wn9mOKO1S8GRNBpwhAcibkXaU8iC1Fko0KbgYk3Y=
X-Received: by 2002:a05:600c:474f:b0:456:8eb:a36a with SMTP id 5b1f17b1804b1-45b5179f693mr111631025e9.13.1756156378737;
        Mon, 25 Aug 2025 14:12:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcIHbSx3HHfd5kb3GxsjPBuL1sLbh4KjHRquWOzV7o4BYkzrZfJdN1fJ4HHCpyMR5zNf3OSQ==
X-Received: by 2002:a05:600c:474f:b0:456:8eb:a36a with SMTP id 5b1f17b1804b1-45b5179f693mr111630925e9.13.1756156378244;
        Mon, 25 Aug 2025 14:12:58 -0700 (PDT)
Received: from redhat.com ([185.128.27.233])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c70ef55aabsm12780275f8f.23.2025.08.25.14.12.57
        for <virtio-dev@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 14:12:57 -0700 (PDT)
Sender: Michael Tsirkin <mtsirkin@redhat.com>
From: "Michael S. Tsirkin" <mst@redhat.com>
X-Google-Original-From: "Michael S. Tsirkin" <mst+test1082025@redhat.com>
Date: Mon, 25 Aug 2025 17:12:54 -0400
To: virtio-dev@lists.linux.dev
Subject: test1082025 pls ignore
Message-ID: <20250825171157-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 67zrQtj6bDLlkek2XFd2qJJ8nnU3Igp4e6SMfO-Jn0o_1756156379
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

sorry about the noise

