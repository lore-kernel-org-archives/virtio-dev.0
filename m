Return-Path: virtio-dev-return-5666-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 634B3985A46
	for <virtio-dev@lists.oasis-open.org>; Mon, 15 Apr 2019 06:22:49 +0000 (UTC)
From: Pankaj Gupta <pagupta@redhat.com>
Date: Mon, 15 Apr 2019 11:52:39 +0530
Message-Id: <20190415062239.19717-1-pagupta@redhat.com>
Subject: [virtio-dev] [PATCH v2] content: reserve device ID for virtio-pmem devices
To: virtio-dev@lists.oasis-open.org
Cc: mst@redhat.com, stefanha@redhat.com, cohuck@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

We need a device ID for virtio-pmem devices. As 25 is requested by
audio device and 26 is requested by virtio-fs, so requesting
next available(27). Also, updated the previously requested github
issue[1] for voting.

[1] https://github.com/oasis-tcs/virtio-spec/issues/38

Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
---
v2:
 Use device ID 27
 
 content.tex | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/content.tex b/content.tex
index 193b6e1..aef7476 100644
--- a/content.tex
+++ b/content.tex
@@ -2634,6 +2634,8 @@ \chapter{Device Types}\label{sec:Device Types}
 \hline
 24         &   Memory device \\
 \hline
+27         &   PMEM device \\
+\hline
 \end{tabular}
 
 Some of the devices above are unspecified by this document,
-- 
2.14.5


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

