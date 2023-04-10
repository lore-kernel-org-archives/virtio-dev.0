Return-Path: <virtio-dev-return-12087-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 472E8C77B70
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Apr 2023 13:23:47 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 8F3502CAD5
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Apr 2023 13:23:46 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8B16098632A
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Apr 2023 13:23:46 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 7E5869862A5; Mon, 10 Apr 2023 13:23:46 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6F1C4986321
	for <virtio-dev@lists.oasis-open.org>; Mon, 10 Apr 2023 13:23:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 8xBhRQhEP9StGbdhjjPaqw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681133021;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nWJuh4WfFWACo4wAPNqR++rv3KFKfmsQlfqrQWr8Tnc=;
        b=AUUBm+t+r7CjxU1dWjD+3QkpVcZW7Qz60l5V+LkwH/lYcF2nXgKt+5XbUu/uK8LNkr
         BLW3Tu7iAMMvMC/qboXExioQ6Hq8MFjVvRVHwj5x884MTEdsiy9I+EzqM9arvkW6VE5I
         kNPTwdAquYPhUXLy8ilpDB2TSclkGgdvLIVPhuwedCb7IC2mMy9tm1IOTE2jSo9aypHw
         xpyXMLN9KWZij8yDY+ls8JWXiytz2cCXH/8AHllw/85HRWnv/IDT9WE2UHTehxiL2A+8
         zSTd5lvaHjkVvc3T2p1+19H+NkPf+xb/4xRdyU6qTvgqjh/FI3UklS8567rZ0XvOVAR+
         gKbQ==
X-Gm-Message-State: AAQBX9dOjbU9/MCwzERqd1aazIwYt9XI7qTq5HMQLqjLKo8CwOy9XJNh
	PGN5j9YpiXqDkny3ntNZqNMX5wLZrWpwI56CpIokxIioG8u9llD6THFukNgabREbr5t430Ps0FF
	zBwFCPnFqTJAnKAiWG3dEu38F2aQr
X-Received: by 2002:a1c:6a06:0:b0:3ed:358e:c1c2 with SMTP id f6-20020a1c6a06000000b003ed358ec1c2mr4608742wmc.18.1681133021362;
        Mon, 10 Apr 2023 06:23:41 -0700 (PDT)
X-Google-Smtp-Source: AKy350b2CsoQjB5U3R6NZloRDVJ04zo0Xgq8qHaqiwDb9ikpkn3zuFtmoZi/TUxLKomxIn64XZkLTw==
X-Received: by 2002:a1c:6a06:0:b0:3ed:358e:c1c2 with SMTP id f6-20020a1c6a06000000b003ed358ec1c2mr4608720wmc.18.1681133020985;
        Mon, 10 Apr 2023 06:23:40 -0700 (PDT)
Date: Mon, 10 Apr 2023 09:23:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com,
	stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com,
	hang.yuan@intel.com, virtio@lists.oasis-open.org,
	Jiri Pirko <jiri@nvidia.com>, Zhu Lingshan <lingshan.zhu@intel.com>,
	pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <20230410092304-mutt-send-email-mst@kernel.org>
References: <cover.1680533760.git.mst@redhat.com>
 <f83a6a225a28909eea927575b6783c0fe238fdbd.1680533760.git.mst@redhat.com>
 <ce6437c5-0cb6-f1a9-d978-b8084c95c552@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <ce6437c5-0cb6-f1a9-d978-b8084c95c552@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v11 02/10] admin: introduce device group and related
 concepts

On Wed, Apr 05, 2023 at 11:42:24PM -0400, Parav Pandit wrote:
> 
> 
> On 4/3/2023 11:03 AM, Michael S. Tsirkin wrote:
> > Each device group has a type. For now, define one initial group type:
> > 
> > SR-IOV type - PCI SR-IOV virtual functions (VFs) of a given
> > PCI SR-IOV physical function (PF). This group may contain zero or more
> > virtio devices according to NumVFs configured.
> > 
> > Each device within a group has a unique identifier. This identifier
> > is the group member identifier.
> > 
> > Note: one can argue both ways whether the new device group handling
> > functionality (this and following patches) is closer
> > to a new device type or a new transport type.
> > 
> From this point onward you can add,
> --- line. So that it doesnt go to the commit log.

I can but motivation for design choices is a good thing to have
in the commit log.

> > However, I expect that we will add more features in the near future. To
> > facilitate this as much as possible of the text is located in the new
> > admin chapter.
> > 
> > I did my best to minimize transport-specific text.
> > 
> > There's a bit of duplication with 0x1 repeated twice and
> > no special section for group type identifiers.
> > I think it's ok to defer adding these until we have more group
> > types.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> > changes in v11:
> > 	dropped Max's S.O.B.
> > 	dropped an unmatched ) as reported by Parav
> > 	document that member id is 1 to numvfs
> > 	document that vf enable must be set (will also be reflected in
> > 		the conformance section)
> > 	document that we deferred generalizing text as requested by Parav -
> > 	I think we can do it later
> > 	minor wording fixes to address comments by David
> > 	add concepts of owner and member driver. unused currently
> > 	but will come in handy later, as suggested by Stefan
> > ---
> >   admin.tex   | 63 +++++++++++++++++++++++++++++++++++++++++++++++++++++
> >   content.tex |  2 ++
> >   2 files changed, 65 insertions(+)
> >   create mode 100644 admin.tex
> > 
> > diff --git a/admin.tex b/admin.tex
> > new file mode 100644
> > index 0000000..04d5498
> > --- /dev/null
> > +++ b/admin.tex
> > @@ -0,0 +1,63 @@
> > +\section{Device groups}\label{sec:Basic Facilities of a Virtio Device / Device groups}
> > +
> > +It is occasionally useful to have a device control a group of
> > +other devices. Terminology used in such cases:
> > +
> Only one case so, singular "such case:".
> 
> > +\begin{description}
> > +\item[Device group]
> > +        or just group, includes zero or more devices.
> > +\item[Owner device]
> > +        or owner, the device controlling the group.
> > +\item[Member device]
> > +        a device within a group. The owner device itself is not
> is a device within a group.
> So that the sentence completes like above two items.
> 
> > +	a member of the group.
> > +\item[Member identifier]
> > +        each member has this identifier, unique within the group
> > +	and used to address it through the owner device.
> to form the complete sentence like rest of the items writing it as below:
> 
> uniquely identifies a member within a group and is used to address it
> through the owner device.
> 
> > +\item[Group type identifier]
> > +	specifies what kind of member devices there are in a
> > +	group, how the member identifier is interpreted
> > +	and what kind of control the owner has.
> > +	A given owner can control multiple groups
> > +	of different types but only a single group of a given type,
> > +	thus the type and the owner together identify the group.
> > +	\footnote{Even though some group types only support
> > +			specific transports, group type identifiers
> > +			are global rather than transport-specific -
> > +			we don't expect a flood of new group types.}
> As as spec, better to avoid "we .."
> How about,
> too many new group types are not expected.?
> > +\end{description}
> > +
> > +\begin{note}
> > +Each device only has a single driver, thus for the purposes of
> > +this section, "the driver" is usually unambiguous and refers to
> > +the driver of the owner device.  When there's ambiguity, "owner
> > +driver" refers to the driver of the owner device, while "member
> > +driver" refers to the driver of a member device.
> > +\end{note}
> > +
> > +The following group types, and their identifiers, are currently specified:
> > +\begin{description}
> > +\item[SR-IOV group type (0x1)]
> > +This device group has a PCI Single Root I/O Virtualization
> > +(SR-IOV) physical function (PF) device as the owner and includes
> > +all its SR-IOV virtual functions (VFs) as members (see
> > +\hyperref[intro:PCIe]{[PCIe]}).
> > +
> > +The PF device itself is not a member of the group.
> > +
> > +The group type identifier for this group is 0x1.
> > +
> > +A member identifier for this group can have a value from 0x1 to
> > +\field{NumVFs} as specified in the
> > +SR-IOV Extended Capability of the owner device
> > +and equals the SR-IOV VF number of the member device;
> > +the group only exists when the \field{VF Enable} bit
> > +in the SR-IOV Control Register within the
> > +SR-IOV Extended Capability of the owner device is set
> > +(see \hyperref[intro:PCIe]{[PCIe]}).
> > +
> > +Both owner and member devices for this group type use the Virtio
> > +PCI transport (see \ref{sec:Virtio Transport Options / Virtio Over PCI Bus}).
> > +\end{description}
> > +
> > +
> > diff --git a/content.tex b/content.tex
> > index 8098988..04592fb 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -493,6 +493,8 @@ \section{Exporting Objects}\label{sec:Basic Facilities of a Virtio Device / Expo
> >   types. It is RECOMMENDED that devices generate version 4
> >   UUIDs as specified by \hyperref[intro:rfc4122]{[RFC4122]}.
> > +\input{admin.tex}
> > +
> >   \chapter{General Initialization And Device Operation}\label{sec:General Initialization And Device Operation}
> >   We start with an overview of device initialization, then expand on the
> 
> Apart from above rewording,
> 
> Reviewed-by: Parav Pandit <parav@nvidia.com>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

