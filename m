Return-Path: <virtio-dev-return-11895-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA618C76188
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 15:03:26 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 35C5D6848E
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 15:03:26 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2B8AA986599
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 15:03:26 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2011D9863E6; Mon,  3 Apr 2023 15:03:26 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 102899863ED
	for <virtio-dev@lists.oasis-open.org>; Mon,  3 Apr 2023 15:03:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: oXGDgS8zPxerCcZQLsqDow-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680534196;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sezkv9q3hnqu3PG5akZnMnJGllV7r5jnEn44qI50IlY=;
        b=dxww7VVPzGcKJBIxgJhMYT/sDmdZLTFbUyr1JLAaxzswGg1YJMDA9osDVWZi/7ptvc
         NFBUVIUp6Fq0uSmzfXYYgrE25UoPsOmmwd4JMLY/5NgQ2ckN9XqD5/hPtUC8WR0GPd/O
         zOKZpdZ3Uj/33R4jfnrVT/YltOctOc4eGmnF6y1XCqgArakJIONg/IguDWcQwnWCWSw8
         CkbhIfzmTAqbDHy2vHe8XWBcWVkPrUkFKnlQBPLezmYRZo+r8jAe6YZ4S8tQYCkadI05
         er849RF904+izb9dwtVuHRg+N91l9E9WuKrGYB4n+1Vz5P/kF4sR93AjEIJMr5LfV6H7
         +acw==
X-Gm-Message-State: AAQBX9dYZfjuRvcCRwq4OnWEVJv33q5p5pYJwtHrnzrPe6BFFOKCeniJ
	1eP+oPz4H51QE7jSpSJo+n2U4Epkyskg7y379R7L1Oe/RSORCOlUrxI63hvrYV4v42yVQ3EmQc0
	wSrPKh6V0D/WVWqF0Za+w2EqgrlRn
X-Received: by 2002:a17:906:6c88:b0:932:2282:dbd6 with SMTP id s8-20020a1709066c8800b009322282dbd6mr34678279ejr.5.1680534196452;
        Mon, 03 Apr 2023 08:03:16 -0700 (PDT)
X-Google-Smtp-Source: AKy350ag8X/hCGAh7Cyh/K9KoJhkvj6YOubqyv1VsSJBxLgawQcXkbO05DW7BI2YDq+YvfMptphLKg==
X-Received: by 2002:a17:906:6c88:b0:932:2282:dbd6 with SMTP id s8-20020a1709066c8800b009322282dbd6mr34678248ejr.5.1680534196109;
        Mon, 03 Apr 2023 08:03:16 -0700 (PDT)
Date: Mon, 3 Apr 2023 11:03:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	jasowang@redhat.com, mst@redhat.com, cohuck@redhat.com,
	sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com,
	Piotr.Uminski@intel.com, hang.yuan@intel.com
Cc: virtio@lists.oasis-open.org, Jiri Pirko <jiri@nvidia.com>,
	Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com,
	Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <f83a6a225a28909eea927575b6783c0fe238fdbd.1680533760.git.mst@redhat.com>
References: <cover.1680533760.git.mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <cover.1680533760.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] [PATCH v11 02/10] admin: introduce device group and related concepts

Each device group has a type. For now, define one initial group type:

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

There's a bit of duplication with 0x1 repeated twice and
no special section for group type identifiers.
I think it's ok to defer adding these until we have more group
types.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
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
index 0000000..04d5498
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
+			we don't expect a flood of new group types.}
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
index 8098988..04592fb 100644
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

