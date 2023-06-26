Return-Path: <virtio-dev-return-13077-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD8CEEB64D7
	for <virtio-dev@archiver.kernel.org>; Mon, 26 Jun 2023 08:20:55 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id EB9B886429
	for <virtio-dev@archiver.kernel.org>; Mon, 26 Jun 2023 08:20:54 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E3D9B986407
	for <virtio-dev@archiver.kernel.org>; Mon, 26 Jun 2023 08:20:54 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id D84E9985FDB; Mon, 26 Jun 2023 08:20:54 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C5D63986364;
	Mon, 26 Jun 2023 08:20:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R441e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VlyjXVQ_1687767647;
Message-ID: <1687766994.5635917-1-xuanzhuo@linux.alibaba.com>
Date: Mon, 26 Jun 2023 16:09:54 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>
Cc: virtio-dev@lists.oasis-open.org,
 mst@redhat.com,
 parav@nvidia.com,
 virtio-comment@lists.oasis-open.org
References: <20230626062210.49020-1-xuanzhuo@linux.alibaba.com>
 <1ddd572b-a1d0-74eb-1e31-abb6dafdef3d@intel.com>
 <1687763309.2985258-1-xuanzhuo@linux.alibaba.com>
 <0a3cc0d7-638b-a49c-d846-8a4ba6e5501f@intel.com>
In-Reply-To: <0a3cc0d7-638b-a49c-d846-8a4ba6e5501f@intel.com>
Subject: [virtio-dev] Re: [virtio-comment] [RFC PATCH] admin-queue: bind the group member to the device

On Mon, 26 Jun 2023 15:57:33 +0800, "Zhu, Lingshan" <lingshan.zhu@intel.com> wrote:
>
>
> On 6/26/2023 3:08 PM, Xuan Zhuo wrote:
> > On Mon, 26 Jun 2023 14:43:17 +0800, "Zhu, Lingshan" <lingshan.zhu@intel.com> wrote:
> >>
> >> On 6/26/2023 2:22 PM, Xuan Zhuo wrote:
> >>> The VFs of the SR-IOV are created by the user inside the guest OS, so the virtio
> >>> devices don't know about these VFs. Because each VF may be assigned a different role
> >>> by the user, the virtio device can not choose one VF to bind random.
> >>> So only the user knows how to bind the virtio devices to the VFs.
> >>> On the other hand, generally the virtio devices are not created by the user
> >>> inside the guest OS. This requires some management platform to participate.
> >>>
> >>> So the usage of this command:
> >>> 1. The user purchases a virtio network card on the management platform,
> >>>      and sets the ip, queue number, etc. The user obtains the identity of
> >>>      the network card.
> >>> 2. The user creates a VF with echo 8 > sriov_numvfs
> >>> 3. The user binds the net crad to a VF with identity through the command
> >>>      of the patch
> >>>
> >>> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> >>> ---
> >>>    admin.tex | 41 ++++++++++++++++++++++++++++++++++++++++-
> >>>    1 file changed, 40 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/admin.tex b/admin.tex
> >>> index 2efd4d7..64d0667 100644
> >>> --- a/admin.tex
> >>> +++ b/admin.tex
> >>> @@ -115,7 +115,8 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
> >>>    \hline \hline
> >>>    0x0000 & VIRTIO_ADMIN_CMD_LIST_QUERY & Provides to driver list of commands supported for this group type    \\
> >>>    0x0001 & VIRTIO_ADMIN_CMD_LIST_USE & Provides to device list of commands used for this group type \\
> >>> -0x0002 - 0x7FFF & - & Commands using \field{struct virtio_admin_cmd}    \\
> >>> +0x0002 & VIRTIO_ADMIN_CMD_BIND_DEVICE & Bind the device to one group member \\
> >>> +0x0003 - 0x7FFF & - & Commands using \field{struct virtio_admin_cmd}    \\
> >>>    \hline
> >>>    0x8000 - 0xFFFF & - & Reserved for future commands (possibly using a different structure)    \\
> >>>    \hline
> >>> @@ -429,6 +430,44 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
> >>>    \field{VF Enable} refer to registers within the SR-IOV Extended
> >>>    Capability as specified by \hyperref[intro:PCIe]{[PCIe]}.
> >>>
> >>> +\subsubsection{Bind the device for member}
> >>> +
> >>> +The VFs of the SR-IOV are created by the user inside the guest OS, so the virtio
> >> If the VFs are create in a guest OS, I assume that means the user has
> >> passthrough-ed the
> >> PF to the guest. For nested, I am not sure whether this is a security
> >> issue(affects host pci).
> >
> > No care about the passthrough, we always created VFs by the PF.
> >
> > I should not say "inside the guest OS". I just want to say that the VF is create
> > by the user in the OS. The devices does not know about it.
> OK, perhaps just say create VFs from a PF in the OS?

YES.


> >
> >
> >>> +devices don't know about these VFs. Because each VF may be assigned a different role
> >>> +by the user, the virtio device can not choose one VF to bind random.
> >> I failed to understand this, once a VF is created, it has a personality,
> >> e.g.,
> >> create a virtio-net VF from a virtio-net PF, and PF knows that.
> >>
> >> I am not familiar with the background, What do you mean by virtio device
> >> choose
> >> one VF to bind?
> >
> > On the cloud, the nic is created by the management platform, the
> > user can not create a new nic inside the OS.
> >
> > So after echo sriov_numvfs, the user just got some VFs,
> > there is not backend virtio-net devices.
> I think it is not a "user" mange the VFs, the VFs usually provisioned by
> the orchestration software and it assign properly selected a VF to a
> guest on demands.


Yes, but we do not need to care about the guest. Because VF may only be used
in host, such as docker.

The problem is that the user (you can think of this as the orchestration
software) creates some VFs, these are only some PCI devices, which virtio
devices will work on these VFs. I think that creating a vf and creating a
virtio-net device are two different things. One is done by user in the OS, one
is done on the management platform.  So we need to bind them together.

Thanks.



>
> So I am confused what the intention of this patch.
> >
> > Thanks.
> >
> >
> >>> +So only the user knows how to bind the virtio devices to the VFs.
> >>> +On the other hand, generally the virtio devices are not created by the user
> >>> +inside the guest OS. This requires some management platform to participate.
> >>> +
> >>> +So we introduce a new admin queue command to bind the VFs and the virtio
> >>> +devices.
> >> Sorry, failed to process this. Maybe an orchestration sw layer can help?
> >> Provision a device on demands and assign it to a guest?
> >>
> >> Thanks
> >>> +
> >>> +\begin{lstlisting}
> >>> +struct virtio_admin_cmd_bind {
> >>> +    u64 identity;
> >>> +};
> >>> +\end{lstlisting}
> >>> +
> >>> +The user got the \field{identity} from the management platform, that is not
> >>> +included by this spec.
> >>> +
> >>> +\drivernormative{\paragraph}{Group administration commands}{Basic Facilities of a Virtio Device / Device groups / Group administration commands / Bind the device for member}
> >>> +
> >>> +VIRTIO_ADMIN_CMD_BIND_DEVICE requires that the \field{group_member_id} MUST be set.
> >>> +
> >>> +The \field{identity} is passed by the user. It is the identity of the virtio
> >>> +device.
> >>> +
> >>> +\devicenormative{\paragraph}{Group administration commands}{Basic Facilities of a Virtio Device / Device groups / Group administration commands / Bind the device for member}
> >>> +
> >>> +Every device MUST have one unique \field{identity} in the host.
> >>> +
> >>> +If the PF device can not find the device by the \field{identity},
> >>> +the \field{status} MUST be set to VIRTIO_ADMIN_STATUS_EINVAL.
> >>> +
> >>> +If the device is found by the \field{identity}, the device MUST work as the
> >>> +device of this group member specified by the \field{group_member_id}.
> >>> +
> >>>    \section{Administration Virtqueues}\label{sec:Basic Facilities of a Virtio Device / Administration Virtqueues}
> >>>
> >>>    An administration virtqueue of an owner device is used to submit
> > This publicly archived list offers a means to provide input to the
> > OASIS Virtual I/O Device (VIRTIO) TC.
> >
> > In order to verify user consent to the Feedback License terms and
> > to minimize spam in the list archive, subscription is required
> > before posting.
> >
> > Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> > Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> > List help: virtio-comment-help@lists.oasis-open.org
> > List archive: https://lists.oasis-open.org/archives/virtio-comment/
> > Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
> > List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
> > Committee: https://www.oasis-open.org/committees/virtio/
> > Join OASIS: https://www.oasis-open.org/join/
> >
>
>
> This publicly archived list offers a means to provide input to the
> OASIS Virtual I/O Device (VIRTIO) TC.
>
> In order to verify user consent to the Feedback License terms and
> to minimize spam in the list archive, subscription is required
> before posting.
>
> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> List help: virtio-comment-help@lists.oasis-open.org
> List archive: https://lists.oasis-open.org/archives/virtio-comment/
> Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
> List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
> Committee: https://www.oasis-open.org/committees/virtio/
> Join OASIS: https://www.oasis-open.org/join/
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

