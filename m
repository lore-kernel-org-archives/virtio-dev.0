Return-Path: <weijunji@bytedance.com>
From: Junji Wei <weijunji@bytedance.com>
Subject: [PATCH] Reserve device id for RDMA device
Date: Fri,  3 Sep 2021 16:03:03 +0800
Message-Id: <20210903080303.39915-1-weijunji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
To: virtio-dev@lists.oasis-open.org
Cc: weijunji@bytedance.com, dledford@redhat.com, jgg@ziepe.ca, mst@redhat.com, jasowang@redhat.com, yuval.shaia.ml@gmail.com, marcel.apfelbaum@gmail.com, cohuck@redhat.com, hare@suse.de, xieyongji@bytedance.com, chaiwen.cc@bytedance.com, dingtao.darren@bytedance.com, duanxiongchun@bytedance.com
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
 
 Some of the devices above are unspecified by this document,
-- 
2.30.1 (Apple Git-130)

