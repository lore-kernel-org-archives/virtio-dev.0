Return-Path: <virtio-dev-return-11404-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1DC0C678D4
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 23:44:42 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 0C0C068477
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 23:44:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 058DE9866D9
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 23:44:41 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id EFF31984091; Thu,  2 Mar 2023 23:44:40 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CDDD3986799
	for <virtio-dev@lists.oasis-open.org>; Thu,  2 Mar 2023 23:44:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: xqe31BtlMUCXE4PqD_c1bA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677800674;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yq/7PrczznqLAWgCuOTvfcvduXoEHur67+So17bmB5Y=;
        b=q/NzMCnyRxLRYZUfaoatd0dQuZZy3cMu1ofLclUMwC1oE/Qvgj7Bb7J6k+Pp8smZHZ
         IL0bwS4fRxMovQqq4YwCtQ4QXfJDleG13ptkFRoJVoApA0Qbe/Hekl4C/yiTf5ctJ0Pm
         kqCxx96KuvbDWPvKHboJVYJYNK/wFzyjkv2gdpxV3cIS8YldHpq8GiiisUwZTUq6/iyK
         aPyzZmIlRzLUGBdKvIqzZeMpraWahgZahRLYgWHgmblGMU6J6+4Vw3jghKs5QDGy3sjm
         fGafUz7+waLIi2Vy/mjzu8lstY5sph2F6/Qxvr5rRt8qg7PccW2VuYyHdSGDfFDGdz0R
         osfQ==
X-Gm-Message-State: AO0yUKULzjpmwCfMYQKdjO4fUeQsYNqPxjZjkCuRGZHgy3RR7L+6Cqpv
	7hSKbRgFhp5qvkKVEd+iSJVCrTsZ1N2sXuSFctKbU9mdixKVbejcNVwDuPsvM8t2by3HlM7IVHh
	Mxt0mw3ggI/iwQf/mbOnsYsrCUELI
X-Received: by 2002:a05:600c:3c9d:b0:3eb:598d:6494 with SMTP id bg29-20020a05600c3c9d00b003eb598d6494mr2628347wmb.16.1677800674634;
        Thu, 02 Mar 2023 15:44:34 -0800 (PST)
X-Google-Smtp-Source: AK7set8eXlNDL2eW2vfAM1ckl68ymYu36Sl4WoiMwNhD/TM5UgyJtJuogC4dlrr3ZDV/SB+Cy6Ei3Q==
X-Received: by 2002:a05:600c:3c9d:b0:3eb:598d:6494 with SMTP id bg29-20020a05600c3c9d00b003eb598d6494mr2628326wmb.16.1677800674285;
        Thu, 02 Mar 2023 15:44:34 -0800 (PST)
Date: Thu, 2 Mar 2023 18:44:30 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"sgarzare@redhat.com" <sgarzare@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	"nrupal.jani@intel.com" <nrupal.jani@intel.com>,
	"Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>,
	"hang.yuan@intel.com" <hang.yuan@intel.com>,
	"virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>,
	Zhu Lingshan <lingshan.zhu@intel.com>,
	"pasic@linux.ibm.com" <pasic@linux.ibm.com>,
	Shahaf Shuler <shahafs@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <20230302184408-mutt-send-email-mst@kernel.org>
References: <cover.1677761896.git.mst@redhat.com>
 <2d232eba17d75c5dad2db17dc297f34a3612c33e.1677761896.git.mst@redhat.com>
 <PH0PR12MB5481AF533A3C9FC0EFEB46DDDCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481AF533A3C9FC0EFEB46DDDCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v10 02/10] admin: introduce device group and related
 concepts

On Thu, Mar 02, 2023 at 06:39:47PM +0000, Parav Pandit wrote:
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Thursday, March 2, 2023 8:05 AM
> > 
> > Each device group has a type. For now, define one initial group:
> > 
> > SR-IOV type - PCI SR-IOV virtual functions (VFs) of a given PCI SR-IOV physical
> > function (PF). This group may contain zero or more virtio devices according to
> > NumVFs configured.
> > 
> > Each device within a group has a unique identifier. This identifier is the group
> > member identifier.
> > 
> > Note: one can argue both ways whether the new device group handling
> > functionality (this and following patches) is closer to a new device type or a
> > new transport type.
> > 
> > However, I expect that we will add more features in the near future. To
> > facilitate this as much as possible of the text is located in the new admin
> > chapter.
> > 
> > I did my best to minimize transport-specific text.
> > 
> > Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  admin.tex   | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
> >  content.tex |  2 ++
> >  2 files changed, 51 insertions(+)
> >  create mode 100644 admin.tex
> > 
> You missed addressing the comments of [1].
> Can you please fix them?
> 
> [1] https://lists.oasis-open.org/archives/virtio-dev/202302/msg00235.html

Hmm oh ok. At least ): one for sure.

> > diff --git a/admin.tex b/admin.tex
> > new file mode 100644
> > index 0000000..3dc47be
> > --- /dev/null
> > +++ b/admin.tex
> > @@ -0,0 +1,49 @@
> > +\section{Device groups}\label{sec:Basic Facilities of a Virtio Device /
> > +Device groups}
> > +
> > +It is occasionally useful to have a device control a group of other
> > +devices. Terminology used in such cases:
> > +
> > +\begin{description}
> > +\item[Device group]
> > +        or just group, includes zero or more devices.
> > +\item[Owner device]
> > +        or owner, the device controlling the group.
> > +\item[Member device]
> > +        a device within a group. The owner device itself is not
> > +	a member of the group.
> > +\item[Member identifier]
> > +        each member has this identifier, unique within the group
> > +	and used to address it through the owner device.
> > +\item[Group type identifier]
> > +	specifies what kind of member devices there are in a
> > +	group, how is the member identifier is interpreted
> > +	and what kind of control the owner has.
> > +	A given owner can control a single group of a given type,
> > +	thus the type and the owner together identify the group.
> > +	\footnote{Even though some group types only support
> > +			specific transports, group type identifiers
> > +			are global rather than transport-specific -
> > +			we don't expect a flood of new group types.}
> > \end{description}
> > +
> > +The following group types, and their identifiers, are currently specified):
> > +\begin{description}
> > +\item[SR-IOV group type (0x1)]
> > +This device group has a PCI Single Root I/O Virtualization
> > +(SR-IOV) physical function (PF) device as the owner and includes all
> > +its SR-IOV virtual functions (VFs) as members (see
> > +\hyperref[intro:PCIe]{[PCIe]}).
> > +
> > +The PF device itself is not a member of the group.
> > +
> > +The group type identifier for this group is 0x1.
> > +
> > +A member identifier for this group can have a value from 0x1 to 0xFFFF
> > +and equals the SR-IOV VF number of the member device (see
> > +\hyperref[intro:PCIe]{[PCIe]}).
> > +
> > +Both owner and member devices for this group type use the Virtio PCI
> > +transport (see \ref{sec:Virtio Transport Options / Virtio Over PCI Bus}).
> > +\end{description}
> > +
> > +
> > diff --git a/content.tex b/content.tex
> > index 0c2d917..ffe45c4 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -491,6 +491,8 @@ \section{Exporting Objects}\label{sec:Basic Facilities of
> > a Virtio Device / Expo  types. It is RECOMMENDED that devices generate
> > version 4  UUIDs as specified by \hyperref[intro:rfc4122]{[RFC4122]}.
> > 
> > +\input{admin.tex}
> > +
> >  \chapter{General Initialization And Device Operation}\label{sec:General
> > Initialization And Device Operation}
> > 
> >  We start with an overview of device initialization, then expand on the
> > --
> > MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

