Return-Path: <virtio-dev-return-11366-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42E0AC678D4
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 13:05:58 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 12C0A9258D
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 13:05:38 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1C02098687E
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 13:05:36 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 952E09867D9; Thu,  2 Mar 2023 13:05:34 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CEB3698667E
	for <virtio-dev@lists.oasis-open.org>; Thu,  2 Mar 2023 13:05:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: -tqmbbyHMziwobe4jYhJ8Q-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677762302;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LUpbJZsJabWUhEUX9xqo9dpaiS5/YsIeXbOx58Ii3uo=;
        b=bhJVTdT8Aol+BD7Nb3BOV+e+kH04jQItYaa8CYrIX2fmkAIjeOQzwRO5gmpiSTaVp0
         Sf1/ZQWzQACt/FD/GcALopa12sT7LIZAHCjv15a1i9CYOjuleXXjgKHr72zL+edFdwmX
         8K7yeyEuTzwNnpIOnKeFGAYkpuSnlrqZ/kVldSEb2PZxwFRY1J79WBgNUrkschdAJ1sX
         HOZ7sb+IxO8r2AJCiS6DailfpdgaqVoW+DI06TYhP/2Z1O4tVN1IZjJIoEUNJlsrsec7
         XdoPWz+JarE06LjcSbbgF7vZktZK2b/tXpJzQ7qt5jP+vZdN4PKWXdT8JW0Vzq66Pi+h
         Gcdg==
X-Gm-Message-State: AO0yUKWXpOMCKjY8yZkLtWcOywbuqUIzQL3Z/V+bikQqjASY4YXbj7Ul
	aG7Yg8ZwsRS2JaMNfT9JFfN4BSkDOIdbI5+5Zm04rDhfxBp5nBviIwLhIRyQFM2zIVi+CnNZK8N
	xXlryCzMA3nvUNS7fo14qWZfIsBb3
X-Received: by 2002:adf:e790:0:b0:2cb:c370:77f9 with SMTP id n16-20020adfe790000000b002cbc37077f9mr8159950wrm.9.1677762302180;
        Thu, 02 Mar 2023 05:05:02 -0800 (PST)
X-Google-Smtp-Source: AK7set+YzK8+0yLyPPmXQulhGYFKwX8rAMmMlKsQ/qqevWf568uKRRpbqChkuImEyC4nNu0dcnhbGQ==
X-Received: by 2002:adf:e790:0:b0:2cb:c370:77f9 with SMTP id n16-20020adfe790000000b002cbc37077f9mr8159932wrm.9.1677762301935;
        Thu, 02 Mar 2023 05:05:01 -0800 (PST)
Date: Thu, 2 Mar 2023 08:04:57 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	jasowang@redhat.com, mst@redhat.com, cohuck@redhat.com,
	sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com,
	Piotr.Uminski@intel.com, hang.yuan@intel.com
Cc: virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>,
	pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <2d232eba17d75c5dad2db17dc297f34a3612c33e.1677761896.git.mst@redhat.com>
References: <cover.1677761896.git.mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <cover.1677761896.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] [PATCH v10 02/10] admin: introduce device group and related concepts

Each device group has a type. For now, define one initial group:

SR-IOV type - PCI SR-IOV virtual functions (VFs) of a given
PCI SR-IOV physical function (PF). This group may contain zero or more
virtio devices according to NumVFs configured.

Each device within a group has a unique identifier. This identifier
is the group member identifier.

Note: one can argue both ways whether the new device group handling
functionality (this and following patches) is closer
to a new device type or a new transport type.

However, I expect that we will add more features in the near future. To
facilitate this as much as possible of the text is located in the new
admin chapter.

I did my best to minimize transport-specific text.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 admin.tex   | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 content.tex |  2 ++
 2 files changed, 51 insertions(+)
 create mode 100644 admin.tex

diff --git a/admin.tex b/admin.tex
new file mode 100644
index 0000000..3dc47be
--- /dev/null
+++ b/admin.tex
@@ -0,0 +1,49 @@
+\section{Device groups}\label{sec:Basic Facilities of a Virtio Device / Device groups}
+
+It is occasionally useful to have a device control a group of
+other devices. Terminology used in such cases:
+
+\begin{description}
+\item[Device group]
+        or just group, includes zero or more devices.
+\item[Owner device]
+        or owner, the device controlling the group.
+\item[Member device]
+        a device within a group. The owner device itself is not
+	a member of the group.
+\item[Member identifier]
+        each member has this identifier, unique within the group
+	and used to address it through the owner device.
+\item[Group type identifier]
+	specifies what kind of member devices there are in a
+	group, how is the member identifier is interpreted
+	and what kind of control the owner has.
+	A given owner can control a single group of a given type,
+	thus the type and the owner together identify the group.
+	\footnote{Even though some group types only support
+			specific transports, group type identifiers
+			are global rather than transport-specific -
+			we don't expect a flood of new group types.}
+\end{description}
+
+The following group types, and their identifiers, are currently specified):
+\begin{description}
+\item[SR-IOV group type (0x1)]
+This device group has a PCI Single Root I/O Virtualization
+(SR-IOV) physical function (PF) device as the owner and includes
+all its SR-IOV virtual functions (VFs) as members (see
+\hyperref[intro:PCIe]{[PCIe]}).
+
+The PF device itself is not a member of the group.
+
+The group type identifier for this group is 0x1.
+
+A member identifier for this group can have a value from 0x1 to 0xFFFF
+and equals the SR-IOV VF number of the member device (see
+\hyperref[intro:PCIe]{[PCIe]}).
+
+Both owner and member devices for this group type use the Virtio
+PCI transport (see \ref{sec:Virtio Transport Options / Virtio Over PCI Bus}).
+\end{description}
+
+
diff --git a/content.tex b/content.tex
index 0c2d917..ffe45c4 100644
--- a/content.tex
+++ b/content.tex
@@ -491,6 +491,8 @@ \section{Exporting Objects}\label{sec:Basic Facilities of a Virtio Device / Expo
 types. It is RECOMMENDED that devices generate version 4
 UUIDs as specified by \hyperref[intro:rfc4122]{[RFC4122]}.
 
+\input{admin.tex}
+
 \chapter{General Initialization And Device Operation}\label{sec:General Initialization And Device Operation}
 
 We start with an overview of device initialization, then expand on the
-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

