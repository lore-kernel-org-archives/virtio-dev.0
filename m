Return-Path: <virtio-dev-return-14266-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31552C47DDB
	for <virtio-dev@archiver.kernel.org>; Tue, 23 Jan 2024 17:32:17 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 6C5A82B01E
	for <virtio-dev@archiver.kernel.org>; Tue, 23 Jan 2024 17:32:16 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 549E59866FB
	for <virtio-dev@archiver.kernel.org>; Tue, 23 Jan 2024 17:32:16 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 39A469866D7; Tue, 23 Jan 2024 17:32:16 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 281879866D8
	for <virtio-dev@lists.oasis-open.org>; Tue, 23 Jan 2024 17:32:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706031134; x=1706635934;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vf4kYw2zodMz/klA48TVXihaCTfY5itoR/q3XhkHKYA=;
        b=py039tGs12LWWi6Z4Gd9JZ9YNDXU+RPtv4WTlSJzUpQgZbbWC2uM7rGskp/LtKd7Kw
         YT/nEMrdxKROprJFpynpaDCW3QdGpVFsYY+PGPUbgEJF7BwNvabA5BwDjReUXBEV/6rN
         wq3rhlo9I6yu4UYysvO5KK6WaWkGwBtELD47MKBkHXfjEj14LPIHFDgWrPllIaJ+eTBW
         qahSkuBwLppDSnT7dv+4gsdDdH3Ay38KeXQmycQFtaLX+tLa+4fHz9Uy7WPEhRbR98cT
         rKdIFTbwjWm4CLAQB5EUyvjqETfFROk/g/R83ZtRZftWkuB47s8bi8GW+gb+ibTsn5gb
         JUBQ==
X-Gm-Message-State: AOJu0YzZOiE5c9hvvdvl0oe4+T3/YgDlZMp3M1PLrxqUZEZWiIExlIdi
	M/yUgT2W0a+ZXm2nJPR62WbVLv+XHMbmnLmPxSDmA4v5tCUZBoIYglA3JFuXeySZoEeBp/YdJhA
	bVhMpAGUQze8L9FlhgE7NfuR7Yd/4JDIw3K6L7HKkXQpU6qWQ/brtPwg=
X-Google-Smtp-Source: AGHT+IFlIxFOxHiR+68eAWK4oDq5Dt5P3t1LyqNbbeyyCPbia6pfaF315DXsTxJJ/QHesVHEm6L9b3fRboW+sGGnSn8=
X-Received: by 2002:a17:907:2d88:b0:a2f:7c68:e043 with SMTP id
 gt8-20020a1709072d8800b00a2f7c68e043mr141377ejc.6.1706031134101; Tue, 23 Jan
 2024 09:32:14 -0800 (PST)
MIME-Version: 1.0
From: Shujun Xue <shujunxue@google.com>
Date: Tue, 23 Jan 2024 09:32:01 -0800
Message-ID: <CAB6OiKgcWwH_qprNv6Z=F4=Hc2PckoCqQEJCGgkgNVL9Xx4k5A@mail.gmail.com>
To: virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org
Cc: Shujun Xue <shujunxue@google.com>, Slava Malyugin <slavamn@google.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [virtio-dev] [PATCH] Define the DEVICE ID of Virtio Cpu balloon device as 47.

The Virtio CPU balloon device is a primitive device for managing guest
CPU capacity: the device asks for certain CPU cores to be online,
offline or throttled, and the driver performs the requested operation.
This allows the guest to adapt to changes in allowance of underlying
CPU capacity.

Signed-off-by: Shujun Xue <shujunxue@google.com>
---
 content.tex | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/content.tex b/content.tex
index 0a62dce..87f0238 100644
--- a/content.tex
+++ b/content.tex
@@ -739,6 +739,8 @@ \chapter{Device Types}\label{sec:Device Types}
 \hline
 45         &   SPI master \\
 \hline
+47         &   CPU balloon device \\
+\hline
 \end{tabular}

 Some of the devices above are unspecified by this document,
-- 
2.43.0.429.g432eaa2c6b-goog

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

