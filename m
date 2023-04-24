Return-Path: <virtio-dev-return-12376-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C2C9C77B73
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Apr 2023 16:46:01 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id E4A8042B6A
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Apr 2023 16:45:27 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5F5EF986662
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Apr 2023 16:45:27 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 4A51C9866FF; Mon, 24 Apr 2023 16:45:27 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5CD6E986663
	for <virtio-dev@lists.oasis-open.org>; Mon, 24 Apr 2023 16:45:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: _mlcURZFMfuswZoB75oi_w-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682354677; x=1684946677;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EddzCnHZXFxYszrFhMDSvIXLk65eRndLFWSDTr4rCCU=;
        b=RBYvWYNikn5fnPwFqNMyzYMJZJFbwpyyGacierRweNs1JvrgwAFUrq77QNHfM/AGXX
         fgbcxJPy+uiJiIFy1KqZfKgn38tPnGJdOPXOBJrklOfOAAfe1MjKb881uZbkOyZRi7sg
         KFmX0NnCaTWJDuaVeZDgE8J3ekE1pa0UWLR2dqYtse/TGZQw2LBPYU5D5h6lFl6I+Of1
         ZQCi/vVDol7i29psM23lfrmUPCq9IZtq/wNS1/ARCoj7hhVsDCFv4STKeJcAatlKMg+X
         6aQD/ETdpESlDlrUN0SxduFItEjMi00owcKqfl+460Cpl+ybKjWV8ga1LC9mdFWi9t1p
         208w==
X-Gm-Message-State: AAQBX9f544FNR9F/CxGn7K7cV+EA9JnA+gjkWOTgQwqw2KDuA5WqYZ5L
	O1L0DfQ2G9l18JD4z+1aCUPLr067UgsniT9W8XbVMBj/uhSdJc3c6uObyNHjOJWfItuI8rU4nXr
	E3NzSQ3hG1QjhWo8FYi2g9RY8Sg63
X-Received: by 2002:a05:600c:ac8:b0:3ea:ed4d:38eb with SMTP id c8-20020a05600c0ac800b003eaed4d38ebmr7955209wmr.24.1682354676852;
        Mon, 24 Apr 2023 09:44:36 -0700 (PDT)
X-Google-Smtp-Source: AKy350Ytdk6414+5idDBoLr9eoPYXE4wBZgwGUDBdP6FbaBs3zth8RX1iOTFRHwWgafmMNRh7fanDA==
X-Received: by 2002:a05:600c:ac8:b0:3ea:ed4d:38eb with SMTP id c8-20020a05600c0ac800b003eaed4d38ebmr7955198wmr.24.1682354676548;
        Mon, 24 Apr 2023 09:44:36 -0700 (PDT)
Date: Mon, 24 Apr 2023 12:44:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	jasowang@redhat.com, mst@redhat.com, cohuck@redhat.com,
	sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com,
	Piotr.Uminski@intel.com, hang.yuan@intel.com
Cc: virtio@lists.oasis-open.org, Jiri Pirko <jiri@nvidia.com>,
	Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com,
	Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <8a3435860747eeaa038ece4ff896c1cdd441c185.1682354275.git.mst@redhat.com>
References: <cover.1682354275.git.mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <cover.1682354275.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] [PATCH v12 05/10] pci: add admin vq registers to virtio over pci

Add new registers to the PCI common configuration structure.

These registers will be used for querying the indices of the admin
virtqueues of the owner device. To configure, reset or enable the admin
virtqueues, the driver should follow existing queue configuration/setup
sequence.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

---
dropped Max's S.O.B
make queue_num not 0 based

squash! pci: add admin vq registers to virtio over pci

since v11:
	document that admin vqs are not counted with regular vqs
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Zhu Lingshan <lingshan.zhu@intel.com>
---
 content.tex | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/content.tex b/content.tex
index 2eb15fa..bcbc06d 100644
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
 
@@ -974,6 +978,7 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
 
 \item[\field{num_queues}]
         The device specifies the maximum number of virtqueues supported here.
+        This excludes administration virtqueues if any are supported.
 
 \item[\field{device_status}]
         The driver writes the device status here (see \ref{sec:Basic Facilities of a Virtio Device / Device Status Field}). Writing 0 into this
@@ -1033,6 +1038,19 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
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
@@ -1119,6 +1137,14 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
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
@@ -7686,6 +7712,15 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
 
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

