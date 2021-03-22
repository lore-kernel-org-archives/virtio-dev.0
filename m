Return-Path: virtio-dev-return-8122-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5CB32985EE4
	for <virtio-dev@lists.oasis-open.org>; Mon, 22 Mar 2021 19:19:24 +0000 (UTC)
MIME-Version: 1.0
From: Hao Chen <chenhaosjtuacm@google.com>
Date: Mon, 22 Mar 2021 12:19:11 -0700
Message-ID: <CABATKF_wnHQRrmBV=yKE-wrOMGXxX6=Pz=PwgZy+-DXrVQ+7ZA@mail.gmail.com>
Subject: [virtio-dev] [PATCH] Reserve device id for parameter server
Content-Type: text/plain; charset="UTF-8"
To: virtio-dev@lists.oasis-open.org
Cc: Hao Chen <chenhaosjtuacm@google.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Use device ID 37

Signed-off-by: Hao Chen <chenhaosjtuacm@google.com>
---
 content.tex | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/content.tex b/content.tex
index b72bad0..b88e606 100644
--- a/content.tex
+++ b/content.tex
@@ -2870,6 +2870,8 @@ \chapter{Device Types}\label{sec:Device Types}
 \hline
 36         &   CAN device \\
 \hline
+37         &   Parameter Server \\
+\hline
 \end{tabular}

 Some of the devices above are unspecified by this document,
--
2.31.0.rc2.261.g7f71774620-goog

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

