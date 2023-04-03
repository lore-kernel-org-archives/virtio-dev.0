Return-Path: <virtio-dev-return-11897-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38230C761A6
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 15:03:58 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id BAE661318C7
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 15:03:54 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AE82798640A
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 15:03:54 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id A33219863DD; Mon,  3 Apr 2023 15:03:54 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4135D9865A1
	for <virtio-dev@lists.oasis-open.org>; Mon,  3 Apr 2023 15:03:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: __Y3hVceMUe2GgVPjFnkZQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680534217;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jhxYRP0RK9D29CXVLY4oSlCxDzL6YZmprZKh3z15/ZE=;
        b=kCl41+otNq6SDPaQtO67s0ByyRp0sdfxuKlbW54HQ9V6FqlbWWPx0zBINvfMNEA2Kk
         orLf52u+J+XzA77cu6bZyP6YMBWQKzBCZn4uDDKP2GTt50P2y0zrYpPSIgoH2t5JXbFN
         fiKk3DtSwBvdI3mlSJxiI8TNVtsHJ/R6nWhdTjC9rVHO9L+pBzB16GeuFtglk+4t6oPQ
         R5SyMy9FeiMlm0OlN2ztq79UedQ5jbmSVswlusGoXsWWj4I+hwC/WORjFhOUxQU1PCs/
         pmcJ8+n14PMHimGRUqlfV3RRHuf9+r93KowCBgAZ17uSKmnEPA1s38hLU3+FEMXGDchg
         bRdA==
X-Gm-Message-State: AAQBX9eiR9ZqHUD2Gy9SC01b6SFHRE7nAQb1VfZFDrgVqXcseXEirsJ2
	vsK1G1IaPFPTfJ6JllSRHnBi6NOWMAnw4Ir/kGc77Pa7oG+AOvv/i+i39vpNaI0QMVhB1BFQKf5
	9qGTPAPAPEtizO42u/j7poVR3Efq1NrAWPeDiR0v82g==
X-Received: by 2002:a05:6402:2c6:b0:4fd:236f:7d4d with SMTP id b6-20020a05640202c600b004fd236f7d4dmr32411183edx.18.1680534216804;
        Mon, 03 Apr 2023 08:03:36 -0700 (PDT)
X-Google-Smtp-Source: AKy350b2psEm7VuH3YEtDIwhEGBZFB7dtX0QtcRNH96t61mTmX5KQWSMCpEzeI7L9yhNxGqa753dKA==
X-Received: by 2002:a05:6402:2c6:b0:4fd:236f:7d4d with SMTP id b6-20020a05640202c600b004fd236f7d4dmr32411157edx.18.1680534216520;
        Mon, 03 Apr 2023 08:03:36 -0700 (PDT)
Date: Mon, 3 Apr 2023 11:03:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	jasowang@redhat.com, mst@redhat.com, cohuck@redhat.com,
	sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com,
	Piotr.Uminski@intel.com, hang.yuan@intel.com
Cc: virtio@lists.oasis-open.org, Jiri Pirko <jiri@nvidia.com>,
	Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com,
	Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <fbf6f659974884f7430ec7ef68028305d7acee0c.1680533760.git.mst@redhat.com>
References: <cover.1680533760.git.mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <cover.1680533760.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] [PATCH v11 05/10] pci: add admin vq registers to virtio over pci

Add new registers to the PCI common configuration structure.

These registers will be used for querying the indices of the admin
virtqueues of the owner device. To configure, reset or enable the admin
virtqueues, the driver should follow existing queue configuration/setup
sequence.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

---
dropped Max's S.O.B
make queue_num not 0 based
---
 content.tex | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/content.tex b/content.tex
index 2eb15fa..5057df2 100644
--- a/content.tex
+++ b/content.tex
@@ -948,6 +948,10 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
         le64 queue_device;              /* read-write */
         le16 queue_notify_data;         /* read-only for driver */
         le16 queue_reset;               /* read-write */
+
+        /* About the administration virtqueue. */
+        le16 admin_queue_index;         /* read-only for driver */
+        le16 admin_queue_num;         /* read-only for driver */
 };
 \end{lstlisting}
 
@@ -1033,6 +1037,19 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
         This field exists only if VIRTIO_F_RING_RESET has been
         negotiated. (see \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}).
 
+\item[\field{admin_queue_index}]
+        The device uses this to report the index of the first administration virtqueue.
+        This field is valid only if VIRTIO_F_ADMIN_VQ has been negotiated.
+\item[\field{admin_queue_num}]
+	The device uses this to report the number of the
+	supported administration virtqueues.
+	Virtqueues with index
+	between \field{admin_queue_index} and (\field{admin_queue_index} +
+	\field{admin_queue_num} - 1) inclusive serve as administration
+	virtqueues.
+	The value 0 indicates no supported administration virtqueues.
+	This field is valid only if VIRTIO_F_ADMIN_VQ has been
+	negotiated.
 \end{description}
 
 \devicenormative{\paragraph}{Common configuration structure layout}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Common configuration structure layout}
@@ -1119,6 +1136,14 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
 were used before the queue reset.
 (see \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}).
 
+If VIRTIO_F_ADMIN_VQ has been negotiated, and if the driver
+configures any administration virtqueues, the driver MUST
+configure the administration virtqueues using the index
+in the range \field{admin_queue_index} to
+\field{admin_queue_index} + \field{admin_queue_num} - 1 inclusive.
+The driver MAY configure less administration virtqueues than
+supported by the device.
+
 \subsubsection{Notification structure layout}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Notification capability}
 
 The notification location is found using the VIRTIO_PCI_CAP_NOTIFY_CFG
@@ -7686,6 +7711,15 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
 
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

