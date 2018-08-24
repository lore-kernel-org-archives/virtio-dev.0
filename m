Return-Path: virtio-dev-return-4790-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CF316985E8F
	for <virtio-dev@lists.oasis-open.org>; Fri, 24 Aug 2018 00:43:57 +0000 (UTC)
From: "Longpeng(Mike)" <longpeng2@huawei.com>
Date: Fri, 24 Aug 2018 08:43:36 +0800
Message-ID: <1535071416-212072-3-git-send-email-longpeng2@huawei.com>
In-Reply-To: <1535071416-212072-1-git-send-email-longpeng2@huawei.com>
References: <1535071416-212072-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [virtio-dev] [PATCH v25 2/2] virtio-crypto: Add conformance clauses
To: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org
Cc: mst@redhat.com, cohuck@redhat.com, stefanha@redhat.com, denglingli@chinamobile.com, Jani.Kokkonen@huawei.com, Ola.Liljedahl@arm.com, Varun.Sethi@freescale.com, xin.zeng@intel.com, brian.a.keating@intel.com, liang.j.ma@intel.com, john.griffin@intel.com, agraf@suse.de, jasowang@redhat.com, vincent.jardin@6wind.com, arei.gonglei@huawei.com, pasic@linux.vnet.ibm.com, weidong.huang@huawei.com, wangxinxin.wang@huawei.com, jianjay.zhou@huawei.com, "Longpeng(Mike)" <nimisolo@gmail.com>, "Longpeng(Mike)" <longpeng2@huawei.com>
List-ID: <virtio-dev.lists.oasis-open.org>

From: "Longpeng(Mike)" <nimisolo@gmail.com>

Add the conformance targets and clauses for
virtio-crypto device.

Signed-off-by: Gonglei <arei.gonglei@huawei.com>
Signed-off-by: Zhoujian <jianjay.zhou@huawei.com>
Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
---
 conformance.tex | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/conformance.tex b/conformance.tex
index e4efe33..5638eae 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -147,6 +147,21 @@ An SCSI host driver MUST conform to the following normative statements:
 \item \ref{drivernormative:Device Types / SCSI Host Device / Device Operation / Device Operation: eventq}
 \end{itemize}
 
+\subsection{Crypto Driver Conformance}\label{sec:Conformance / Driver Conformance / Crypto Driver Conformance}
+
+A Crypto driver MUST conform to the following normative statements:
+
+\begin{itemize}
+\item \ref{drivernormative:Device Types / Crypto Device / Device configuration layout}
+\item \ref{drivernormative:Device Types / Crypto Device / Device Initialization}
+\item \ref{drivernormative:Device Types / Crypto Device / Device Operation / Control Virtqueue / Session operation / Session operation: create session}
+\item \ref{drivernormative:Device Types / Crypto Device / Device Operation / Control Virtqueue / Session operation / Session operation: destroy session}
+\item \ref{drivernormative:Device Types / Crypto Device / Device Operation / HASH Service operation}
+\item \ref{drivernormative:Device Types / Crypto Device / Device Operation / MAC Service operation}
+\item \ref{drivernormative:Device Types / Crypto Device / Device Operation / Symmetric algorithms Operation}
+\item \ref{drivernormative:Device Types / Crypto Device / Device Operation / AEAD Service operation}
+\end{itemize}
+
 \section{Device Conformance}\label{sec:Conformance / Device Conformance}
 
 A device MUST conform to the following normative statements:
@@ -268,6 +283,20 @@ An SCSI host device MUST conform to the following normative statements:
 \item \ref{devicenormative:Device Types / SCSI Host Device / Device Operation / Device Operation: eventq}
 \end{itemize}
 
+\subsection{Crypto Device Conformance}\label{sec:Conformance / Device Conformance / Crypto Device Conformance}
+
+A Crypto device MUST conform to the following normative statements:
+
+\begin{itemize}
+\item \ref{devicenormative:Device Types / Crypto Device / Device configuration layout}
+\item \ref{devicenormative:Device Types / Crypto Device / Device Operation / Control Virtqueue / Session operation / Session operation: create session}
+\item \ref{devicenormative:Device Types / Crypto Device / Device Operation / Control Virtqueue / Session operation / Session operation: destroy session}
+\item \ref{devicenormative:Device Types / Crypto Device / Device Operation / HASH Service operation}
+\item \ref{devicenormative:Device Types / Crypto Device / Device Operation / MAC Service operation}
+\item \ref{devicenormative:Device Types / Crypto Device / Device Operation / Symmetric algorithms Operation}
+\item \ref{devicenormative:Device Types / Crypto Device / Device Operation / AEAD Service operation}
+\end{itemize}
+
 \section{Legacy Interface: Transitional Device and
 Transitional Driver Conformance}\label{sec:Conformance / Legacy
 Interface: Transitional Device and 
-- 
1.8.3.1



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

