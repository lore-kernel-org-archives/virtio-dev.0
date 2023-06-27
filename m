Return-Path: <virtio-dev-return-13099-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A8C5EB64D9
	for <virtio-dev@archiver.kernel.org>; Tue, 27 Jun 2023 08:18:45 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 85DA52B053
	for <virtio-dev@archiver.kernel.org>; Tue, 27 Jun 2023 08:18:44 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7AC5D986416
	for <virtio-dev@archiver.kernel.org>; Tue, 27 Jun 2023 08:18:44 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 6FF3198635C; Tue, 27 Jun 2023 08:18:44 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5CDA398635B;
	Tue, 27 Jun 2023 08:18:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R991e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Vm507V._1687853914;
Message-ID: <1687853815.9423323-2-xuanzhuo@linux.alibaba.com>
Date: Tue, 27 Jun 2023 16:16:55 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: virtio-comment@lists.oasis-open.org,
 virtio-dev@lists.oasis-open.org,
 mst@redhat.com,
 parav@nvidia.com
References: <20230626062210.49020-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEt=zfQn9ZY466opvwJNxamoj8fr=tSP4dQQFAFXymrwXA@mail.gmail.com>
In-Reply-To: <CACGkMEt=zfQn9ZY466opvwJNxamoj8fr=tSP4dQQFAFXymrwXA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [virtio-comment] [RFC PATCH] admin-queue: bind the group member to the device

On Tue, 27 Jun 2023 16:08:38 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Mon, Jun 26, 2023 at 2:22=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > The VFs of the SR-IOV are created by the user inside the guest OS, so t=
he virtio
> > devices don't know about these VFs. Because each VF may be assigned a d=
ifferent role
> > by the user, the virtio device can not choose one VF to bind random.
> > So only the user knows how to bind the virtio devices to the VFs.
> > On the other hand, generally the virtio devices are not created by the =
user
> > inside the guest OS. This requires some management platform to particip=
ate.
> >
> > So the usage of this command:
> > 1. The user purchases a virtio network card on the management platform,
> >    and sets the ip, queue number, etc. The user obtains the identity of
> >    the network card.
>
> Any reason we can't do this through IPC of software layers?


As Parav pointed out, we may have some gaps on the term. I will post our ca=
se
later.

Thanks.



>
> Thanks
>
> > 2. The user creates a VF with echo 8 > sriov_numvfs
> > 3. The user binds the net crad to a VF with identity through the command
> >    of the patch
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  admin.tex | 41 ++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 40 insertions(+), 1 deletion(-)
> >
> > diff --git a/admin.tex b/admin.tex
> > index 2efd4d7..64d0667 100644
> > --- a/admin.tex
> > +++ b/admin.tex
> > @@ -115,7 +115,8 @@ \subsection{Group administration commands}\label{se=
c:Basic Facilities of a Virti
> >  \hline \hline
> >  0x0000 & VIRTIO_ADMIN_CMD_LIST_QUERY & Provides to driver list of comm=
ands supported for this group type    \\
> >  0x0001 & VIRTIO_ADMIN_CMD_LIST_USE & Provides to device list of comman=
ds used for this group type \\
> > -0x0002 - 0x7FFF & - & Commands using \field{struct virtio_admin_cmd}  =
  \\
> > +0x0002 & VIRTIO_ADMIN_CMD_BIND_DEVICE & Bind the device to one group m=
ember \\
> > +0x0003 - 0x7FFF & - & Commands using \field{struct virtio_admin_cmd}  =
  \\
> >  \hline
> >  0x8000 - 0xFFFF & - & Reserved for future commands (possibly using a d=
ifferent structure)    \\
> >  \hline
> > @@ -429,6 +430,44 @@ \subsection{Group administration commands}\label{s=
ec:Basic Facilities of a Virti
> >  \field{VF Enable} refer to registers within the SR-IOV Extended
> >  Capability as specified by \hyperref[intro:PCIe]{[PCIe]}.
> >
> > +\subsubsection{Bind the device for member}
> > +
> > +The VFs of the SR-IOV are created by the user inside the guest OS, so =
the virtio
> > +devices don't know about these VFs. Because each VF may be assigned a =
different role
> > +by the user, the virtio device can not choose one VF to bind random.
> > +So only the user knows how to bind the virtio devices to the VFs.
> > +On the other hand, generally the virtio devices are not created by the=
 user
> > +inside the guest OS. This requires some management platform to partici=
pate.
> > +
> > +So we introduce a new admin queue command to bind the VFs and the virt=
io
> > +devices.
> > +
> > +\begin{lstlisting}
> > +struct virtio_admin_cmd_bind {
> > +    u64 identity;
> > +};
> > +\end{lstlisting}
> > +
> > +The user got the \field{identity} from the management platform, that i=
s not
> > +included by this spec.
> > +
> > +\drivernormative{\paragraph}{Group administration commands}{Basic Faci=
lities of a Virtio Device / Device groups / Group administration commands /=
 Bind the device for member}
> > +
> > +VIRTIO_ADMIN_CMD_BIND_DEVICE requires that the \field{group_member_id}=
 MUST be set.
> > +
> > +The \field{identity} is passed by the user. It is the identity of the =
virtio
> > +device.
> > +
> > +\devicenormative{\paragraph}{Group administration commands}{Basic Faci=
lities of a Virtio Device / Device groups / Group administration commands /=
 Bind the device for member}
> > +
> > +Every device MUST have one unique \field{identity} in the host.
> > +
> > +If the PF device can not find the device by the \field{identity},
> > +the \field{status} MUST be set to VIRTIO_ADMIN_STATUS_EINVAL.
> > +
> > +If the device is found by the \field{identity}, the device MUST work a=
s the
> > +device of this group member specified by the \field{group_member_id}.
> > +
> >  \section{Administration Virtqueues}\label{sec:Basic Facilities of a Vi=
rtio Device / Administration Virtqueues}
> >
> >  An administration virtqueue of an owner device is used to submit
> > --
> > 2.32.0.3.g01195cf9f
> >
> >
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
> > Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.p=
df
> > List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing=
-lists
> > Committee: https://www.oasis-open.org/committees/virtio/
> > Join OASIS: https://www.oasis-open.org/join/
> >
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

