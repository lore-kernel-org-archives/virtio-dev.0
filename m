Return-Path: <virtio-dev-return-12588-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D26AC77B75
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 15:42:02 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 5DEE8600AC
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 15:41:46 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 979009867E6
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 15:41:45 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 28F229866F6; Fri,  5 May 2023 15:41:45 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0D68B986758
	for <virtio-dev@lists.oasis-open.org>; Fri,  5 May 2023 15:41:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: sijwLOzsNzmNBTRoOFAIxw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683301255; x=1685893255;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PX/EXCm14WLIS6TD6POoC7BgMmh/5jePyj2HrqcvxOg=;
        b=ZO/49e+Z0MXf7jXTxdhUdeo3kWled0532YReUCdNh4wFdU54QCpW9UVpKtNNx7Saii
         54c/40bsirzGUJWGMcicXeVlcbtKLaIgVqggOEoYJluPj9B8YE0QRcxuuAGiCf+2XmAv
         YLfRd4zI5rG+V/mtpeBfct1MdHJAs8YGs4c8s4YFtuS0646uVJBY6whirTJ4B0vN6FL4
         hlVmGpb5KpMXzEeGbltSzUasKumd1F/OqhQ+34Lb1A5Y0jqPUmduxui+yUXxVMjtXguC
         Eg+lBjVJMww0laiPgL5Axyu+35sfYy88v1pX4wC0AyZi7d24xV+JVCxYID8LEqWu4u1T
         zLzA==
X-Gm-Message-State: AC+VfDxCQQvE0up5CQjxGxTqaQ4/gz6U0DhpFJrr3dRXCgP4B01BVtSu
	gB8rMaG6WHDQO3OEyEdoy3sGrk+6LrtT9cVfCDcpgzkl7hJ3NoChKTVXvg5Ot0MK0dGzwm+DRdr
	lfnWnDqn2CM615Zwjdca7W3NyC/Xi
X-Received: by 2002:a05:600c:2299:b0:3f1:a71b:d46b with SMTP id 25-20020a05600c229900b003f1a71bd46bmr1328382wmf.41.1683301254782;
        Fri, 05 May 2023 08:40:54 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ68bfAlwP8EHpNvXACv4wWn97B2WAPP1jMpt5GN16+0xumuHHncjAoeqX/P0Wj7hvJf9zZbRQ==
X-Received: by 2002:a05:600c:2299:b0:3f1:a71b:d46b with SMTP id 25-20020a05600c229900b003f1a71bd46bmr1328368wmf.41.1683301254527;
        Fri, 05 May 2023 08:40:54 -0700 (PDT)
Date: Fri, 5 May 2023 11:40:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	jasowang@redhat.com, mst@redhat.com, cohuck@redhat.com,
	sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com,
	Piotr.Uminski@intel.com, hang.yuan@intel.com
Cc: virtio@lists.oasis-open.org, Jiri Pirko <jiri@nvidia.com>,
	Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com,
	Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <778cbbfc75b5d5c779c539ace5fb04fa5cd0480a.1683301091.git.mst@redhat.com>
References: <cover.1683301091.git.mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <cover.1683301091.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] [PATCH v13 05/10] pci: add admin vq registers to virtio over pci

Add new registers to the PCI common configuration structure.

These registers will be used for querying the indices of the admin
virtqueues of the owner device. To configure, reset or enable the admin
virtqueues, the driver should follow existing queue configuration/setup
sequence.

Based-on-patch-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

---

since v11:
	document that admin vqs are not counted with regular vqs
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Zhu Lingshan <lingshan.zhu@intel.com>

dropped Max's S.O.B
make queue_num not 0 based
---
 content.tex       |  9 +++++++++
 transport-pci.tex | 26 ++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/content.tex b/content.tex
index 8761795..1986e98 100644
--- a/content.tex
+++ b/content.tex
@@ -851,6 +851,15 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
 
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
 
diff --git a/transport-pci.tex b/transport-pci.tex
index 5d98467..ec012b3 100644
--- a/transport-pci.tex
+++ b/transport-pci.tex
@@ -321,6 +321,10 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
         le64 queue_device;              /* read-write */
         le16 queue_notify_data;         /* read-only for driver */
         le16 queue_reset;               /* read-write */
+
+        /* About the administration virtqueue. */
+        le16 admin_queue_index;         /* read-only for driver */
+        le16 admin_queue_num;         /* read-only for driver */
 };
 \end{lstlisting}
 
@@ -347,6 +351,7 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
 
 \item[\field{num_queues}]
         The device specifies the maximum number of virtqueues supported here.
+        This excludes administration virtqueues if any are supported.
 
 \item[\field{device_status}]
         The driver writes the device status here (see \ref{sec:Basic Facilities of a Virtio Device / Device Status Field}). Writing 0 into this
@@ -406,6 +411,19 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
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
@@ -492,6 +510,14 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
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
-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

