Return-Path: virtio-dev-return-6336-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F2D31985CE6
	for <virtio-dev@lists.oasis-open.org>; Mon, 18 Nov 2019 05:58:44 +0000 (UTC)
From: Huang Yang <yang.huang@intel.com>
Date: Mon, 18 Nov 2019 14:05:10 +0800
Message-Id: <1574057110-18854-1-git-send-email-yang.huang@intel.com>
Subject: [virtio-dev] [PATCH] Reserve device id 28 for virtio RPMB device
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
To: virtio-dev@lists.oasis-open.org
Cc: mst@redhat.com, cohuck@redhat.com, bing.zhu@intel.com, tomas.winkler@intel.com, peter.fang@intel.com, kai.z.wang@intel.com, Huang Yang <yang.huang@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Signed-off-by: Huang Yang <yang.huang@intel.com>
---
 content.tex | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/content.tex b/content.tex
index 2573bd5..7f54f94 100644
--- a/content.tex
+++ b/content.tex
@@ -2717,6 +2717,8 @@ \chapter{Device Types}\label{sec:Device Types}
 \hline
 27         &   PMEM device \\
 \hline
+28         &   RPMB device \\
+\hline
 \end{tabular}
=20
 Some of the devices above are unspecified by this document,
--=20
2.7.4


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

