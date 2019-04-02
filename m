Return-Path: virtio-return-3343-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Tue, 2 Apr 2019 15:37:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190402193737.29330-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio] [PATCH] acknowledgements: fix spill over
To: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

Use a subsection instead of a title page, otherwise
list of acknowledged people spills over to the next page.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 acknowledgements.tex | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/acknowledgements.tex b/acknowledgements.tex
index b2feeaf..557874e 100644
--- a/acknowledgements.tex
+++ b/acknowledgements.tex
@@ -5,7 +5,7 @@ \chapter{Acknowledgements}\label{chap:Acknowledgements}
 
 The following individuals have participated in the creation of this specification and are gratefully acknowledged:
 
-\begin{oasistitlesection}{Participants}
+\subsection*{Participants}
 Allen Chia, Oracle	\newline
 Amit Shah,	Red Hat	\newline
 Amos Kong,	Red Hat	\newline
@@ -58,12 +58,11 @@ \chapter{Acknowledgements}\label{chap:Acknowledgements}
 Vijay Balakrishna,	Oracle	\newline
 Wei Wang, Intel	\newline
 Xin Zeng, Intel	\newline
-\end{oasistitlesection}
 
 The following non-members have provided valuable feedback on this
 specification and are gratefully acknowledged:
 
-\begin{oasistitlesection}{Reviewers}
+\subsection*{Reviewers}
 Aaron Conole,	Red Hat	\newline
 Andrew Thornton,  Google \newline
 Arun Subbarao,	LynuxWorks	\newline
@@ -103,4 +102,3 @@ \chapter{Acknowledgements}\label{chap:Acknowledgements}
 Will Deacon,	ARM	\newline
 Yuri Benditovich,	Red Hat / Daynix	\newline
 Zhoujian,	Huawei	\newline
-\end{oasistitlesection}
-- 
MST

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

