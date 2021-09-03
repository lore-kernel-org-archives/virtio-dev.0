Return-Path: <virtio-dev-return-8635-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 654929865D8
	for <virtio-dev@lists.oasis-open.org>; Fri,  3 Sep 2021 08:36:06 +0000 (UTC)
From: Junji Wei <weijunji@bytedance.com>
Date: Fri,  3 Sep 2021 16:35:51 +0800
Message-Id: <20210903083551.41227-1-weijunji@bytedance.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH] Reserve device id for RDMA device
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="US-ASCII"
To: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

Use device ID 42

Signed-off-by: Junji Wei <weijunji@bytedance.com>
---
 content.tex | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/content.tex b/content.tex
index 3aeb4a4..b57c997 100644
--- a/content.tex
+++ b/content.tex
@@ -2878,6 +2878,8 @@ \chapter{Device Types}\label{sec:Device Types}
 \hline
 41         &   GPIO device \\
 \hline
+42         &   RDMA device \\
+\hline
 \end{tabular}
=20
 Some of the devices above are unspecified by this document,
--=20
2.30.1 (Apple Git-130)


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

