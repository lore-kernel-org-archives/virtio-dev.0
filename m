Return-Path: <virtio-dev-return-12581-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E335C77B7F
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 15:40:55 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id AB8F63262B
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 15:40:54 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9B4BB9866E2
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 15:40:54 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 8E9549866C2; Fri,  5 May 2023 15:40:54 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 769969866E8
	for <virtio-dev@lists.oasis-open.org>; Fri,  5 May 2023 15:40:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 1xhElO9PMOC3V9zS53u6Yg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683301245; x=1685893245;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B5vvd6n3/fWZcuEu7Yz9c4kdtdKj/0AFXD2FAPiZ9lg=;
        b=DOQw3wkSPQDGSdlCL9sLnr6fZ8HrqF1zOIgDlMKXt7RkN2uffj77oo0GXZRPTXgijp
         hw4hwWiZw2JkEli3824bsMz1RBB1+iUIwYFFDZvhZDWpbSkStqpzqF0OU0O18D9XUY5g
         ogTLWqWWrI0avA2hznyNfPKxBQSNI4QZopzz1baoO9he0hS5Xb95wHw3YciXVXqiSwj3
         pcWI6Q+SVImqVYWJPJJRQzqkLoVeCl6vTE1EYLD1O/zyxBcEaycL0g2I2s3KDmBYtEwH
         /YgzGK2pLF4rYcIm99rxFG/LH5VVc0AsIVXZw02QHUPPyeZ3Ws4Arm7AKNjJgrKH093B
         P6/Q==
X-Gm-Message-State: AC+VfDxfbzVX0wmW74Maj6i/j7mxN5NEOrSuj0I9+wL5bhXTuCpyUbgI
	ytbB3JTesQGcongIGq39jQA0S6NNZaEA72kaq93EXA8T0vRm+GQ40JhBYRp1Xf5i7pmzAgdEHIG
	WBzjswslAA+yRyhmYDQvxa1fENurv
X-Received: by 2002:a05:600c:24ce:b0:3f2:51e7:f1f4 with SMTP id 14-20020a05600c24ce00b003f251e7f1f4mr1461548wmu.10.1683301244799;
        Fri, 05 May 2023 08:40:44 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5Wkkwv1nAUpAwVZfzOKUCENsITj8jhbzpJhtciq5OJ7yEjOZxWvgy4Hq/DwlTOttFXLKNt3Q==
X-Received: by 2002:a05:600c:24ce:b0:3f2:51e7:f1f4 with SMTP id 14-20020a05600c24ce00b003f251e7f1f4mr1461533wmu.10.1683301244480;
        Fri, 05 May 2023 08:40:44 -0700 (PDT)
Date: Fri, 5 May 2023 11:40:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	jasowang@redhat.com, mst@redhat.com, cohuck@redhat.com,
	sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com,
	Piotr.Uminski@intel.com, hang.yuan@intel.com
Cc: virtio@lists.oasis-open.org, Jiri Pirko <jiri@nvidia.com>,
	Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com,
	Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <d12263629be44bda17b8e12beea69bc6ef82eeb1.1683301091.git.mst@redhat.com>
References: <cover.1683301091.git.mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <cover.1683301091.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] [PATCH v13 02/10] admin: introduce device group and related concepts

Each device group has a type. For now, define one initial group type:

SR-IOV type - PCI SR-IOV virtual functions (VFs) of a given
PCI SR-IOV physical function (PF). This group may contain zero or more
virtio devices according to NumVFs configured.

Each device within a group has a unique identifier. This identifier
is the group member identifier.

Note: one can argue both ways whether the new device group handling
functionality (this and following patches) is closer
to a new device type or a new transport type.

However, it's expected that we will add more features in the near
future. To facilitate this as much as possible of the text is located in
the new admin chapter.

Effort was made to minimize transport-specific text.

There's a bit of duplication with 0x1 repeated twice and
no special section for group type identifiers.
It seems ok to defer adding these until we have more group
types.

Based-on-patch-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
changes in v12:
	stefan's ack
	minor commit log tweaks, Parav
	use neutral tone, Parav

changes in v11:
	dropped Max's S.O.B.
	dropped an unmatched ) as reported by Parav
	document that member id is 1 to numvfs
	document that vf enable must be set (will also be reflected in
		the conformance section)
	document that we deferred generalizing text as requested by Parav -
	I think we can do it later
	minor wording fixes to address comments by David
	add concepts of owner and member driver. unused currently
	but will come in handy later, as suggested by Stefan
---
 admin.tex   | 63 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 content.tex |  2 ++
 2 files changed, 65 insertions(+)
 create mode 100644 admin.tex

diff --git a/admin.tex b/admin.tex
new file mode 100644
index 0000000..05d506a
--- /dev/null
+++ b/admin.tex
@@ -0,0 +1,63 @@
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
+	group, how the member identifier is interpreted
+	and what kind of control the owner has.
+	A given owner can control multiple groups
+	of different types but only a single group of a given type,
+	thus the type and the owner together identify the group.
+	\footnote{Even though some group types only support
+			specific transports, group type identifiers
+			are global rather than transport-specific -
+			a flood of new group types is not expected.}
+\end{description}
+
+\begin{note}
+Each device only has a single driver, thus for the purposes of
+this section, "the driver" is usually unambiguous and refers to
+the driver of the owner device.  When there's ambiguity, "owner
+driver" refers to the driver of the owner device, while "member
+driver" refers to the driver of a member device.
+\end{note}
+
+The following group types, and their identifiers, are currently specified:
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
+A member identifier for this group can have a value from 0x1 to
+\field{NumVFs} as specified in the
+SR-IOV Extended Capability of the owner device
+and equals the SR-IOV VF number of the member device;
+the group only exists when the \field{VF Enable} bit
+in the SR-IOV Control Register within the
+SR-IOV Extended Capability of the owner device is set
+(see \hyperref[intro:PCIe]{[PCIe]}).
+
+Both owner and member devices for this group type use the Virtio
+PCI transport (see \ref{sec:Virtio Transport Options / Virtio Over PCI Bus}).
+\end{description}
+
+
diff --git a/content.tex b/content.tex
index 4ec2d76..aecda0e 100644
--- a/content.tex
+++ b/content.tex
@@ -493,6 +493,8 @@ \section{Exporting Objects}\label{sec:Basic Facilities of a Virtio Device / Expo
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

