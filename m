Return-Path: <virtio-dev-return-12584-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7C41C77B75
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 15:41:22 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D2024EEA2E
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 15:41:05 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CA0859866C0
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 15:41:05 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id BBA899866BC; Fri,  5 May 2023 15:41:05 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9AA709866CD
	for <virtio-dev@lists.oasis-open.org>; Fri,  5 May 2023 15:40:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: SUC3f06pMIyjGKHkoxwjZA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683301251; x=1685893251;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gyzPHSvuDFmnnqIDgQOcFB1PJ1uuDf1Bt3ai0c/hK2w=;
        b=EH6LXdJHWFcKcNmSBfnyE+IIcprIrp1l5HfNwe6+WHDhPlkz5Dh/M3Yk9XHufwETKJ
         A4LQZT9VJEt1tAwod+WYnk2CyJ4MXSgpo1HHpqBDWAFTPoLBncA9JTjzwDYPZE4LTscd
         NQj5kj3/T6zLR1x5utQ5wUx1CTBB/bwyN2ZmwPmWVirHDizsnwpgX9ducAYlIb40NtZR
         ooCvNQeQpW39efzoeS7zJ8yH+nZulMD5SrEaIsxgvke+Y2BSe+GtmoeT8Sk5c4FhtiHd
         iXPKGXyfwWqk/RRKk5zuhtnGrKZugNGbae37lo5WwtnR9k7iavMtswl//P4h2WZjn7NR
         i3Ig==
X-Gm-Message-State: AC+VfDxsc6UwTphE96tF9asZCaqQPjR6ordtBSd26Fh9tCx6zk0hWjSP
	F/HTGlxljIjwpsuNnFdcSrt5pucrzCrU4rZK9cVS18R0rGus9diX09bMLMnMiDRY7iK5+HoZMoC
	B4nDU762f6LCADaSA+5jzD+Rv/re+
X-Received: by 2002:adf:d0c7:0:b0:306:372d:7891 with SMTP id z7-20020adfd0c7000000b00306372d7891mr1607056wrh.59.1683301251598;
        Fri, 05 May 2023 08:40:51 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6bTeSpKzKeHy0GRRi7ZWB5/3pxcVU36gUkoY4mnHWcWjHP9JBzzj7u4OxCrlI3clE9MFSP3w==
X-Received: by 2002:adf:d0c7:0:b0:306:372d:7891 with SMTP id z7-20020adfd0c7000000b00306372d7891mr1607042wrh.59.1683301251234;
        Fri, 05 May 2023 08:40:51 -0700 (PDT)
Date: Fri, 5 May 2023 11:40:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	jasowang@redhat.com, mst@redhat.com, cohuck@redhat.com,
	sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com,
	Piotr.Uminski@intel.com, hang.yuan@intel.com
Cc: virtio@lists.oasis-open.org, Jiri Pirko <jiri@nvidia.com>,
	Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com,
	Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <b8f17feea5f4921f89d6395d0b078f766a65e4fe.1683301091.git.mst@redhat.com>
References: <cover.1683301091.git.mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <cover.1683301091.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] [PATCH v13 04/10] admin: introduce virtio admin virtqueues

The admin virtqueues will be the first interface used to issue admin commands.

Currently the virtio specification defines control virtqueue to manipulate
features and configuration of the device it operates on:
virtio-net, virtio-scsi, etc all have existing control virtqueues. However,
control virtqueue commands are device type specific, which makes it very
difficult to extend for device agnostic commands.

Keeping the device-specific virtqueue separate from the admin virtqueue
is simpler and has fewer potential problems. I don't think creating
common infrastructure for device-specific control virtqueues across
device types worthwhile or within the scope of this patch series.

To support this requirement in a more generic way, this patch introduces
a new admin virtqueue interface.
The admin virtqueue can be seen as the virtqueue analog to a transport.
The admin queue thus does nothing device type-specific (net, scsi, etc)
and instead focuses on transporting the admin commands.

We also support more than one admin virtqueue, for QoS and
scalability requirements.

Based-on-patch-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

---

since v12:
	document that num_queues in blk excludes admin queues
	reported by Parav
changes since v11:
	ack by stefan
	queues->enqueues to address comment by parav

changes since v10:

explain ordering of commands as suggested by Stefan
dropped Max's S.O.B
reword commit log as suggested by David
minor wording fixes suggested by David
---
 admin.tex                        | 75 ++++++++++++++++++++++++++++++++
 content.tex                      |  7 ++-
 device-types/blk/description.tex |  2 +-
 3 files changed, 81 insertions(+), 3 deletions(-)

diff --git a/admin.tex b/admin.tex
index e40d14e..5acec67 100644
--- a/admin.tex
+++ b/admin.tex
@@ -182,3 +182,78 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
 \field{command_specific_data} and \field{command_specific_result}
 depends on these structures and is described separately or is
 implicit in the structure description.
+
+\section{Administration Virtqueues}\label{sec:Basic Facilities of a Virtio Device / Administration Virtqueues}
+
+An administration virtqueue of an owner device is used to submit
+group administration commands. An owner device can have more
+than one administration virtqueue.
+
+If VIRTIO_F_ADMIN_VQ has been negotiated, an owner device exposes one
+or more adminstration virtqueues. The number and locations of the
+administration virtqueues are exposed by the owner device in a transport
+specific manner.
+
+The driver enqueues requests to an arbitrary administration
+virtqueue, and they are used by the device on that same
+virtqueue. It is the responsibility of the driver to ensure
+strict request ordering for commands, because they will be
+consumed with no order constraints.  For example, if consistency
+is required then the driver can wait for the processing of a
+first command by the device to be completed before submitting
+another command depending on the first one.
+
+Administration virtqueues are used as follows:
+\begin{itemize}
+\item The driver submits the command using the \field{struct virtio_admin_cmd}
+structure using a buffer consisting of two parts: a device-readable one followed by a
+device-writable one.
+\item the device-readable part includes fields from \field{opcode}
+through \field{command_specific_data}.
+\item the device-writeable buffer includes fields from \field{status}
+through \field{command_specific_result} inclusive.
+\end{itemize}
+
+For each command, this specification describes a distinct
+format structure used for \field{command_specific_data} and
+\field{command_specific_result}, the length of these fields
+depends on the command.
+
+However, to ensure forward compatibility
+\begin{itemize}
+\item drivers are allowed to submit buffers that are longer
+than the device expects
+(that is, longer than the length of
+\field{opcode} through \field{command_specific_data}).
+This allows the driver to maintain
+a single format structure even if some structure fields are
+unused by the device.
+\item drivers are allowed to submit buffers that are shorter
+than what the device expects
+(that is, shorter than the length of \field{status} through
+\field{command_specific_result}). This allows the device to maintain
+a single format structure even if some structure fields are
+unused by the driver.
+\end{itemize}
+
+The device compares the length of each part (device-readable and
+device-writeable) of the buffer as submitted by driver to what it
+expects and then silently truncates the structures to either the
+length submitted by the driver, or the length described in this
+specification, whichever is shorter.  The device silently ignores
+any data falling outside the shorter of the two lengths. Any
+missing fields are interpreted as set to zero.
+
+Similarly, the driver compares the used buffer length
+of the buffer to what it expects and then silently
+truncates the structure to the used buffer length.
+The driver silently ignores any data falling outside
+the used buffer length reported by the device.  Any missing
+fields are interpreted as set to zero.
+
+This simplifies driver and device implementations since the
+driver/device can simply maintain a single large structure (such
+as a C structure) for a command and its result. As new versions
+of the specification are designed, new fields can be added to the
+tail of a structure, with the driver/device using the full
+structure without concern for versioning.
diff --git a/content.tex b/content.tex
index aecda0e..8761795 100644
--- a/content.tex
+++ b/content.tex
@@ -99,10 +99,10 @@ \section{Feature Bits}\label{sec:Basic Facilities of a Virtio Device / Feature B
 \begin{description}
 \item[0 to 23, and 50 to 127] Feature bits for the specific device type
 
-\item[24 to 40] Feature bits reserved for extensions to the queue and
+\item[24 to 41] Feature bits reserved for extensions to the queue and
   feature negotiation mechanisms
 
-\item[41 to 49, and 128 and above] Feature bits reserved for future extensions.
+\item[42 to 49, and 128 and above] Feature bits reserved for future extensions.
 \end{description}
 
 \begin{note}
@@ -849,6 +849,9 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
   that the driver can reset a queue individually.
   See \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}.
 
+  \item[VIRTIO_F_ADMIN_VQ(41)] This feature indicates that the device exposes one or more
+  administration virtqueues.
+
 \end{description}
 
 \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
diff --git a/device-types/blk/description.tex b/device-types/blk/description.tex
index f04c932..6fc1991 100644
--- a/device-types/blk/description.tex
+++ b/device-types/blk/description.tex
@@ -136,7 +136,7 @@ \subsection{Device configuration layout}\label{sec:Device Types / Block Device /
 bits as indicated above.
 
 The field \field{num_queues} only exists if VIRTIO_BLK_F_MQ is set. This field specifies
-the number of queues.
+the number of queues\footnote{This excludes administration virtqueues if any are supported. }.
 
 The parameters in the configuration space of the device \field{max_discard_sectors}
 \field{discard_sector_alignment} are expressed in 512-byte units if the
-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

