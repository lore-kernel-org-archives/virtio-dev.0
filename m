Return-Path: <xuanzhuo@linux.alibaba.com>
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH v1 1/2] Reserve device id for ISM device
Date: Tue,  1 Nov 2022 20:04:27 +0800
Message-Id: <20221101120428.9500-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20221101120428.9500-1-xuanzhuo@linux.alibaba.com>
References: <20221101120428.9500-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
To: virtio-dev@lists.oasis-open.org
Cc: hans@linux.alibaba.com, herongguang@linux.alibaba.com, zmlcc@linux.alibaba.com, dust.li@linux.alibaba.com, tonylu@linux.alibaba.com, zhenzao@linux.alibaba.com, helinguo@linux.alibaba.com, gerry@linux.alibaba.com, xuanzhuo@linux.alibaba.com, mst@redhat.com, cohuck@redhat.com, jasowang@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

Use device ID 43

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
Signed-off-by: Dust Li <dust.li@linux.alibaba.com>
Signed-off-by: Tony Lu <tonylu@linux.alibaba.com>
Signed-off-by: Helin Guo <helinguo@linux.alibaba.com>
Signed-off-by: Hans Zhang <hans@linux.alibaba.com>
Signed-off-by: He Rongguang <herongguang@linux.alibaba.com>
---
 content.tex | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/content.tex b/content.tex
index e863709..cd006c3 100644
--- a/content.tex
+++ b/content.tex
@@ -2990,6 +2990,8 @@ \chapter{Device Types}\label{sec:Device Types}
 \hline
 42         &   RDMA device \\
 \hline
+43         &   ISM device \\
+\hline
 \end{tabular}
 
 Some of the devices above are unspecified by this document,
-- 
2.32.0.3.g01195cf9f

