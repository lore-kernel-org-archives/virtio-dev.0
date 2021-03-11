Return-Path: virtio-dev-return-8109-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 29E71986523
	for <virtio-dev@lists.oasis-open.org>; Thu, 11 Mar 2021 00:48:13 +0000 (UTC)
MIME-Version: 1.0
From: Hao Chen <chenhaosjtuacm@google.com>
Date: Wed, 10 Mar 2021 16:47:58 -0800
Message-ID: <CABATKF8Nks7tDZWMJ+ZnTtc6WX46JiCVPhqF7NZ_0knyZVBKEQ@mail.gmail.com>
Subject: [virtio-dev] [PATCH] Reserve device id for parameter server
Content-Type: text/plain; charset="UTF-8"
To: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

Use device ID 36
Signed-off-by: Hao Chen <chenhaosjtuacm@google.com>
---
 content.tex | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/content.tex b/content.tex
index 620c0e2..6bfbba1 100644
--- a/content.tex
+++ b/content.tex
@@ -2846,6 +2846,8 @@ Device ID  &  Virtio Device    \\
 \hline
 35         &   Watchdog \\
 \hline
+36         &   Parameter Server \\
+\hline
 \end{tabular}

 Some of the devices above are unspecified by this document,
--
2.31.0.rc2.261.g7f71774620-goog

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

