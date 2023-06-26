Return-Path: <virtio-dev-return-13072-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74B80EB64D7
	for <virtio-dev@archiver.kernel.org>; Mon, 26 Jun 2023 06:22:25 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id B679471C8E
	for <virtio-dev@archiver.kernel.org>; Mon, 26 Jun 2023 06:22:24 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A972F9863BA
	for <virtio-dev@archiver.kernel.org>; Mon, 26 Jun 2023 06:22:24 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 9D56F985FDB; Mon, 26 Jun 2023 06:22:24 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 85F58986364;
	Mon, 26 Jun 2023 06:22:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R601e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VlwK59e_1687760530;
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtio-comment@lists.oasis-open.org
Cc: virtio-dev@lists.oasis-open.org,
	mst@redhat.com,
	parav@nvidia.com
Date: Mon, 26 Jun 2023 14:22:10 +0800
Message-Id: <20230626062210.49020-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
MIME-Version: 1.0
X-Git-Hash: 41b3253
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] [RFC PATCH] admin-queue: bind the group member to the device

The VFs of the SR-IOV are created by the user inside the guest OS, so the virtio
devices don't know about these VFs. Because each VF may be assigned a different role
by the user, the virtio device can not choose one VF to bind random.
So only the user knows how to bind the virtio devices to the VFs.
On the other hand, generally the virtio devices are not created by the user
inside the guest OS. This requires some management platform to participate.

So the usage of this command:
1. The user purchases a virtio network card on the management platform,
   and sets the ip, queue number, etc. The user obtains the identity of
   the network card.
2. The user creates a VF with echo 8 > sriov_numvfs
3. The user binds the net crad to a VF with identity through the command
   of the patch

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 admin.tex | 41 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/admin.tex b/admin.tex
index 2efd4d7..64d0667 100644
--- a/admin.tex
+++ b/admin.tex
@@ -115,7 +115,8 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
 \hline \hline
 0x0000 & VIRTIO_ADMIN_CMD_LIST_QUERY & Provides to driver list of commands supported for this group type    \\
 0x0001 & VIRTIO_ADMIN_CMD_LIST_USE & Provides to device list of commands used for this group type \\
-0x0002 - 0x7FFF & - & Commands using \field{struct virtio_admin_cmd}    \\
+0x0002 & VIRTIO_ADMIN_CMD_BIND_DEVICE & Bind the device to one group member \\
+0x0003 - 0x7FFF & - & Commands using \field{struct virtio_admin_cmd}    \\
 \hline
 0x8000 - 0xFFFF & - & Reserved for future commands (possibly using a different structure)    \\
 \hline
@@ -429,6 +430,44 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
 \field{VF Enable} refer to registers within the SR-IOV Extended
 Capability as specified by \hyperref[intro:PCIe]{[PCIe]}.
 
+\subsubsection{Bind the device for member}
+
+The VFs of the SR-IOV are created by the user inside the guest OS, so the virtio
+devices don't know about these VFs. Because each VF may be assigned a different role
+by the user, the virtio device can not choose one VF to bind random.
+So only the user knows how to bind the virtio devices to the VFs.
+On the other hand, generally the virtio devices are not created by the user
+inside the guest OS. This requires some management platform to participate.
+
+So we introduce a new admin queue command to bind the VFs and the virtio
+devices.
+
+\begin{lstlisting}
+struct virtio_admin_cmd_bind {
+    u64 identity;
+};
+\end{lstlisting}
+
+The user got the \field{identity} from the management platform, that is not
+included by this spec.
+
+\drivernormative{\paragraph}{Group administration commands}{Basic Facilities of a Virtio Device / Device groups / Group administration commands / Bind the device for member}
+
+VIRTIO_ADMIN_CMD_BIND_DEVICE requires that the \field{group_member_id} MUST be set.
+
+The \field{identity} is passed by the user. It is the identity of the virtio
+device.
+
+\devicenormative{\paragraph}{Group administration commands}{Basic Facilities of a Virtio Device / Device groups / Group administration commands / Bind the device for member}
+
+Every device MUST have one unique \field{identity} in the host.
+
+If the PF device can not find the device by the \field{identity},
+the \field{status} MUST be set to VIRTIO_ADMIN_STATUS_EINVAL.
+
+If the device is found by the \field{identity}, the device MUST work as the
+device of this group member specified by the \field{group_member_id}.
+
 \section{Administration Virtqueues}\label{sec:Basic Facilities of a Virtio Device / Administration Virtqueues}
 
 An administration virtqueue of an owner device is used to submit
-- 
2.32.0.3.g01195cf9f


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

