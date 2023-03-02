Return-Path: <virtio-dev-return-11369-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86D9AC678D4
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 13:06:15 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 2B2C6157F00
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 13:05:45 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 081F898668C
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 13:05:40 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id ECFD8986672; Thu,  2 Mar 2023 13:05:39 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AB0BC98668D
	for <virtio-dev@lists.oasis-open.org>; Thu,  2 Mar 2023 13:05:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: oEIZyv5sPXqlMkRR3G3_ug-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677762314;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HayH+phs7RtbwTrSFACSfTkbn91R9EOGCYGN7n+LotY=;
        b=A10FK8lZ4URzMX/S6NWzbXdt8r10U9wGLP4pXKiiTpBwGSdM/GhA7m4YOeCLoIUCVZ
         1TI5rrGIDGLa7WPgTBNfaSEfA4Cfay0ZrzwFUPWgMprsJX8DR/4vOUFlEi1j4sqLP91k
         YvAHS6DkR8IiJOVU4vVYk3/nNs8S6N0tSS3idmPJTsIbn8laRGRRbUl+lvbL2y2s/n61
         csI8fdeGL4L7UzoJahRCwgNzTMafk14PLAh45kj52nczrkZ2J0tG0inHy9M3XNlEs6Gk
         QRSTXWmRWIlScSN4Arg7kHEW76EMHtJvgORwl0roXtMwABgklAox8o/hHpPPKRvSghMd
         qyEA==
X-Gm-Message-State: AO0yUKUg5EknlStGE9JQaJ44HgObPvCdhaWjsxuqgSMS5bemxYkyFFfn
	XjOOzN6r985caSul49w+zx5LT143UNe+m83Orwog21/Yaqs/F+wGpjS4VYTD5+f5HzOiwBLjt66
	5n0MUqMXtBt6PZQG527Ap+lEVyWkS
X-Received: by 2002:a5d:658f:0:b0:2c7:e21:4e49 with SMTP id q15-20020a5d658f000000b002c70e214e49mr7223906wru.10.1677762314171;
        Thu, 02 Mar 2023 05:05:14 -0800 (PST)
X-Google-Smtp-Source: AK7set8gu/oZ6iN8oOqtyjTGkzxmfh5xyubvtijFprAaas1DAxQYc3t5sBqHTCb9pkyoZjNWRDtsPA==
X-Received: by 2002:a5d:658f:0:b0:2c7:e21:4e49 with SMTP id q15-20020a5d658f000000b002c70e214e49mr7223896wru.10.1677762313975;
        Thu, 02 Mar 2023 05:05:13 -0800 (PST)
Date: Thu, 2 Mar 2023 08:05:10 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	jasowang@redhat.com, mst@redhat.com, cohuck@redhat.com,
	sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com,
	Piotr.Uminski@intel.com, hang.yuan@intel.com
Cc: virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>,
	pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <33b3e85facaec6d92bff6a0f70afe0b084637591.1677761896.git.mst@redhat.com>
References: <cover.1677761896.git.mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <cover.1677761896.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] [PATCH v10 05/10] pci: add admin vq registers to virtio over pci

Add new registers to the PCI common configuration structure.

These registers will be used for querying the indices of the admin
virtqueues of the owner device. To configure, reset or enable the admin
virtqueues, the driver should follow existing queue configuration/setup
sequence.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 content.tex | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/content.tex b/content.tex
index c8647c9..1076125 100644
--- a/content.tex
+++ b/content.tex
@@ -946,6 +946,10 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
         le64 queue_device;              /* read-write */
         le16 queue_notify_data;         /* read-only for driver */
         le16 queue_reset;               /* read-write */
+
+        /* About the administration virtqueue. */
+        le16 admin_queue_index;         /* read-only for driver */
+        le16 admin_queue_num;         /* read-only for driver */
 };
 \end{lstlisting}
 
@@ -1031,6 +1035,20 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
         This field exists only if VIRTIO_F_RING_RESET has been
         negotiated. (see \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}).
 
+\item[\field{admin_queue_index}]
+        The device uses this to report the index of the first administration virtqueue.
+        This field is valid only if VIRTIO_F_ADMIN_VQ has been negotiated.
+\item[\field{admin_queue_num}]
+	The device uses this to report the number of the
+	supported administration virtqueues.
+	This is a zero based value.  Virtqueues with index
+	between \field{admin_queue_index} and (\field{admin_queue_index} +
+	\field{admin_queue_num}) inclusive serve as administration
+	virtqueues.
+	Thus the number of administration virtqueues equals
+	(\field{admin_queue_num} + 1).
+	This field is valid only if VIRTIO_F_ADMIN_VQ has been
+	negotiated.
 \end{description}
 
 \devicenormative{\paragraph}{Common configuration structure layout}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Common configuration structure layout}
@@ -1117,6 +1135,14 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
 were used before the queue reset.
 (see \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}).
 
+If VIRTIO_F_ADMIN_VQ has been negotiated, and if the driver
+configures any administration virtqueues, the driver MUST
+configure the administration virtqueues using the index
+in the range \field{admin_queue_index} to
+\field{admin_queue_index} + \field{admin_queue_num} inclusive.
+The driver MAY configure less administration virtqueues than
+supported by the device.
+
 \subsubsection{Notification structure layout}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Notification capability}
 
 The notification location is found using the VIRTIO_PCI_CAP_NOTIFY_CFG
@@ -7684,6 +7710,15 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
 
   \item[VIRTIO_F_ADMIN_VQ(41)] This feature indicates that the device exposes one or more
   administration virtqueues.
+  At the moment this feature is only supported for devices using
+  \ref{sec:Virtio Transport Options / Virtio Over PCI
+	  Bus}~\nameref{sec:Virtio Transport Options / Virtio Over PCI Bus}
+	  as the transport and is reserved for future use for
+	  devices using other transports (see
+	  \ref{drivernormative:Basic Facilities of a Virtio Device / Feature Bits}
+	and
+	\ref{devicenormative:Basic Facilities of a Virtio Device / Feature Bits} for
+	handling features reserved for future use.
 
 \end{description}
 
-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

