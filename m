Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A74816EB44
	for <virtio-dev@lists.linux.dev>; Mon,  1 Jul 2024 17:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719855370; cv=none; b=jecUQJr+xJ5stCceQGVDCszOv/Atzejhi57q6ewXOL6r7s0NdBlXKfRVS+Cdgn03Je5H6kIW77bKXOm4FZcfp3Alley48tOcznUkmvZsjLU+i9FZLhd9dVEWLIVfLNbX/xBnhd1oPk1nebyS3eI9/DvRJyMruvAvPLckfy2QTbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719855370; c=relaxed/simple;
	bh=fcrZJE8ycpsnCI+jLJak2NHth7MRmFjeow/a/aktzvM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=M8efm6mHfJwRTYP+/tWClnoVILGN+fC0cT7iAf6EJCqDmgmCXjkICS10aqGffGRmNd81BjMta+BM1nXIysX7cudiU17SGVKTHJXT4DlKUOSZZ40bS57Yw2nxEbBToMn+H/3OZrdFm2hp4QLq9XOV+sxLjingdflZL/GgLtP/f68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WEgMJMdc; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WEgMJMdc"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fa901ad6f3so343095ad.0
        for <virtio-dev@lists.linux.dev>; Mon, 01 Jul 2024 10:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719855368; x=1720460168; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fcrZJE8ycpsnCI+jLJak2NHth7MRmFjeow/a/aktzvM=;
        b=WEgMJMdczv1Fb+c1g0LM4RYYa2a/z/BEchEKTb9EdOJBDTfky5AWnbv5uwtFDgo7fe
         7F1uUY8AO7n7RU1VB4qjWcjKsFr7WwxiSs6oUUcqrjmslv4Hj02vXXwr8QbJzzUezZF+
         DEj0rPwy+cMSPq5nrgrwnCm5j2vSXkxd3yTp4GgHBmftusQtuUsk1YW/GTCJsFfeWUfc
         rzduiGb4C/eAvKPEGk1YBJRya2fukrsiDl3T1pmlctoaRlPFz4rAhHyunnFVJOeTGGhK
         +0J38I4iJD6o1ACrTeEGLCfPWJ8lLJc8tguY6bLQgcWvoEaeH7EIvmCveaeBhOUUTK7E
         cYfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719855368; x=1720460168;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fcrZJE8ycpsnCI+jLJak2NHth7MRmFjeow/a/aktzvM=;
        b=s2NhoEjqTx6L3iZgrZzRgGUTxaxfwAWFRjmJ3dajKup9PeMnmsI3hI2nKASWAzCFRB
         t0Yu5gGV8eRvaUbHj4zeuTSPtrod4Tb7Qvwe+XPzJu1potD0GVQUWE8q+I64ayazGLlW
         Q4WXlMYrgzBz/y+JS+jQsyZrkl9dVGw5VNtk0vNduUFhK+Jt2btWvWguc9R5AbBjHMde
         PDDHGO7IbQJxpVXuIp+ClhbP7a+A37w7Kz/rv49EPhMDIJwIQuxWodIZW2O3cXSJ7TGi
         cbI+sZxLWWIR2eolkvTxyCD6tiotWr5p05mrf0J8ApEeTfgJVLZ5FJ1aEkUDmaRsNM11
         wpIQ==
X-Gm-Message-State: AOJu0YyyK2w8M8gSuJsRmiftnGv5hziVyudE6PFLeAzDqZ//l1oN3oI0
	DYqmA+nPK16XY3fDm9CQpwcbeQO4Fs95Q3U4P1ETHDdudhfNihkYeHFD7hwbnK6EZ3QmFWJBvA4
	k785IRNZg+WRaEuLP/hC1qkF+dL7AKyt9Qzmy7YTtItoz6dcuduLr
X-Google-Smtp-Source: AGHT+IEwxdtutj8Lpt1yV93SEf6X/1qLosdq5LGuK9mB2S4jFFWOCXn/C8sN5JyQ2TYHi4jTDLXEmqxWoxc4+VJeMto=
X-Received: by 2002:a17:902:e995:b0:1f4:b896:c9ce with SMTP id
 d9443c01a7336-1fad81f1a9bmr5840065ad.26.1719855368142; Mon, 01 Jul 2024
 10:36:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Roman Kiryanov <rkir@google.com>
Date: Mon, 1 Jul 2024 10:35:57 -0700
Message-ID: <CAOGAQepPkUDF8vmzRiG41xOGhFdDuq8-EHmdTrdVrK6E346G7A@mail.gmail.com>
Subject: VIRTIO_VSOCK_OP_REQUEST with the same src_port from a guest
To: virtio-dev@lists.linux.dev
Cc: JP Cottin <jpcottin@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi virtio-dev,

we (Android Studio Emulator) have our own implementation of
virtio-vsock and we recently found that the virtio spec does not cover
the situation if a guest sends a VIRTIO_VSOCK_OP_REQUEST packet with
the same src_port that is already registered on the device side.

This sounds like an error to me and I don't think I ever saw this
happening, but it would be nice if the spec explicitly mentioned how
this situation should be handled on the device side.

The spec does mention "A VIRTIO_VSOCK_OP_RST reply is sent if ... the
destination has insufficient resources to establish the connection",
but I am not sure if this includes the duplicate src_port case. I
think this means the previously established connection will be broken.

Thank you.

Regards,
Roman.
