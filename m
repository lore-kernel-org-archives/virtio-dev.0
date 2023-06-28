Return-Path: <virtio-dev-return-13117-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E869EB64DA
	for <virtio-dev@archiver.kernel.org>; Wed, 28 Jun 2023 06:09:45 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id BE7B73894
	for <virtio-dev@archiver.kernel.org>; Wed, 28 Jun 2023 06:09:44 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B7A05986588
	for <virtio-dev@archiver.kernel.org>; Wed, 28 Jun 2023 06:09:44 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id ABA8D98654C; Wed, 28 Jun 2023 06:09:44 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9740B98654E;
	Wed, 28 Jun 2023 06:09:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Vm8TP1Z_1687932574;
Message-ID: <1687932392.6613173-2-xuanzhuo@linux.alibaba.com>
Date: Wed, 28 Jun 2023 14:06:32 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: virtio-dev@lists.oasis-open.org,
 mst@redhat.com,
 parav@nvidia.com,
 virtio-comment@lists.oasis-open.org,
 "Zhu, Lingshan" <lingshan.zhu@intel.com>
References: <20230626062210.49020-1-xuanzhuo@linux.alibaba.com>
 <1687854185.3344731-3-xuanzhuo@linux.alibaba.com>
 <CACGkMEs=2HJ=Bg5Xk1GYZAOKpNLpf5EUrkNEkEOKU4hSbXC=mw@mail.gmail.com>
 <1687863046.3264692-9-xuanzhuo@linux.alibaba.com>
 <CACGkMEvyJrnyN0CFv2sAraNQM5E_Hkccmo1hJNzQPX8DRB5ryg@mail.gmail.com>
In-Reply-To: <CACGkMEvyJrnyN0CFv2sAraNQM5E_Hkccmo1hJNzQPX8DRB5ryg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [virtio-comment] [RFC PATCH] admin-queue: bind the group member to the device

On Wed, 28 Jun 2023 10:49:45 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Tue, Jun 27, 2023 at 6:54=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > On Tue, 27 Jun 2023 17:00:06 +0800, Jason Wang <jasowang@redhat.com> wr=
ote:
> > > On Tue, Jun 27, 2023 at 4:28=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.ali=
baba.com> wrote:
> > > >
> > > >
> > > > Thanks Parav for pointing it out. We may have some gaps on the case.
> > > >
> > > > Let me introduce our case, which I think it is simple and should be=
 easy to
> > > > understand.
> > > >
> > > > First, the user (customer) purchased a bare metal machine.
> > > >
> > > > ## Bare metal machine
> > > >
> > > > Let me briefly explain the characteristics of a bare metal machine.=
 It is not a
> > > > virtual machine, it is a physical machine, and the difference betwe=
en it and a
> > > > general physical machine is that its PCI is connected to a device s=
imilar to a
> > > > DPU. This DPU provides devices such as virtio-blk/net to the host t=
hrough PCI.
> > > > These devices are managed by the vendor, and must be created and pu=
rchased
> > > > on the vendor's management platform.
> > > >
> > > > ## DPU
> > > >
> > > > There is a software implementation in the DPU, which will respond t=
o PCI
> > > > operations. But as mentioned above, resources such as network cards=
 must be
> > > > purchased and created before they can exist. So users can create VF=
, which is
> > > > just a pci-level operation, but there may not be a corresponding ba=
ckend.
> > > >
> > > > ## Management Platform
> > > >
> > > > The creation and configuration of devices is realized on the manage=
ment
> > > > platform.
> > > >
> > > > After the user completed the purchase on the management platform (t=
his is an
> > > > independent platform provided by the vendor and has nothing to do w=
ith
> > > > virtio), then there will be a corresponding device implementation i=
n the DPU.
> > > > This includes some user configurations, available bandwidth resourc=
es and other
> > > > information.
> > > >
> > > > ## Usage
> > > >
> > > > Since the user is directly on the HOST, the user can create VMs, pa=
ssthrough PF
> > > > or VF into the VM. Or users can create a large number of dockers, a=
ll of which
> > > > use a separate virtio-net device for performance.
> > > >
> > > > The reason why users use vf is that we need to use a large number o=
f virtio-net
> > > > devices. This number reaches 1k+.
> > > >
> > > > Based on this scenario, we need to bind vf to the backend device. B=
ecause, we
> > > > cannot automatically complete the creation of the virtio-net backen=
d device when
> > > > the user creates a vf.
> > > >
> > > > ## Migration
> > > >
> > > > In addition, let's consider another scenario of migration. If a vm =
is migrated
> > > > from another host, of course its corresponding virtio device is als=
o migrated to
> > > > the DPU. At this time, our newly created vf can only be used by the=
 vm after it
> > > > is bound to the migrated device. We do not want this vf to be a bra=
nd new
> > > > device.
> > > >
> > > > ## Abstraction
> > > >
> > > > So, this is how I understand the process of creating vf:
> > > >
> > > > 1. Create a PCI VF, at this time there may be no backend virtio dev=
ice, or there
> > > >     is only a default backend. It does not fully meet our expectati=
ons.
> > > > 2. Create device or migrate device
> > > > 3. Bind the backend virtio device to the vf
> > >
> > > 3) should come before 2)?
> > >
> > > Who is going to do 3) btw, is it the user? If yes, for example, if a
> > > user wants another 4 queue virtio-net devices, after purchase, how
> > > does the user know its id?
> >
> > Got the id from the management platform.
>
> So it can do the binding via that management platform which this
> became a cloud vendor specific interface.

In our scenario, this is bound by the user using this id and vf id in the o=
s.

>
> >
> > >
> > > >
> > > > In most scenarios, the first step may be enough. We can make some f=
ine-tuning on
> > > > this default device, such as modifying its mac. In the future, we c=
an use admin
> > > > queue to modify its msix vector and other configurations.
> > > >
> > > > But we should allow, we bind a backend virtio device to a certain v=
f. This is
> > > > useful for live migration and virtio devices with special configura=
tions.
> > >
> > > All of these could be addressed if a dynamic provisioning model is
> > > implemented (SIOV or transport virtqueue). Trying to have a workaround
> > > in SR-IOV might be tricky.
> >
> >
> > SR-IOV vf is native PCI device, this is the advancement.
>
> The problem is that it doesn't support flexible provisioning, e.g
> create and destroy a single VF.

YES. ^_^!!


>
> >
> >
> > >
> > > >
> > > > The design of virtio itself is two layers, and virtio should allow =
switching the
> > > > transport layer by nature. This is our advantage.
> > >
> > > Is it not switching the transport layer but about binding/unbinding
> > > vitio devices to VF?
> >
> > YES.
> >
> > >
> > > Is a new capability or similar admin cmd sufficient in this case?
> >
> > All is ok.
> >
> >
> > >
> > > struct virtio_pci_bind_cap {
> > >         struct virtio_pci_cap cap;
> > >         u16 bind; // virtio_device_id
> > >         u16 unbind; // virtio_device_id
> > > };
> >
> > You mean that the "bind" or "unbind" is writeable?

This is a good idea.

Thanks.


>
> Yes.
>
> Thanks
>
> >
> > Thanks.
> >
> > >
> > > Thanks
> > >
> > > >
> > > > ## About the identity
> > > >
> > > > In this patch, I used a vendor's id. The purpose of this is that I =
hope to
> > > > be compatible with all devices. In the network scenario, it is actu=
ally possible
> > > > to use a mac.
> > > >
> > > > Perhaps, introduce a standard id for each device/driver, I think th=
is may be
> > > > more in line with the habit of virtio spec.
> > > >
> > > > Thanks.
> > > >
> > > > On Mon, 26 Jun 2023 14:22:10 +0800, Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > > > > The VFs of the SR-IOV are created by the user inside the guest OS=
, so the virtio
> > > > > devices don't know about these VFs. Because each VF may be assign=
ed a different role
> > > > > by the user, the virtio device can not choose one VF to bind rand=
om.
> > > > > So only the user knows how to bind the virtio devices to the VFs.
> > > > > On the other hand, generally the virtio devices are not created b=
y the user
> > > > > inside the guest OS. This requires some management platform to pa=
rticipate.
> > > > >
> > > > > So the usage of this command:
> > > > > 1. The user purchases a virtio network card on the management pla=
tform,
> > > > >    and sets the ip, queue number, etc. The user obtains the ident=
ity of
> > > > >    the network card.
> > > > > 2. The user creates a VF with echo 8 > sriov_numvfs
> > > > > 3. The user binds the net crad to a VF with identity through the =
command
> > > > >    of the patch
> > > > >
> > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > ---
> > > > >  admin.tex | 41 ++++++++++++++++++++++++++++++++++++++++-
> > > > >  1 file changed, 40 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/admin.tex b/admin.tex
> > > > > index 2efd4d7..64d0667 100644
> > > > > --- a/admin.tex
> > > > > +++ b/admin.tex
> > > > > @@ -115,7 +115,8 @@ \subsection{Group administration commands}\la=
bel{sec:Basic Facilities of a Virti
> > > > >  \hline \hline
> > > > >  0x0000 & VIRTIO_ADMIN_CMD_LIST_QUERY & Provides to driver list o=
f commands supported for this group type    \\
> > > > >  0x0001 & VIRTIO_ADMIN_CMD_LIST_USE & Provides to device list of =
commands used for this group type \\
> > > > > -0x0002 - 0x7FFF & - & Commands using \field{struct virtio_admin_=
cmd}    \\
> > > > > +0x0002 & VIRTIO_ADMIN_CMD_BIND_DEVICE & Bind the device to one g=
roup member \\
> > > > > +0x0003 - 0x7FFF & - & Commands using \field{struct virtio_admin_=
cmd}    \\
> > > > >  \hline
> > > > >  0x8000 - 0xFFFF & - & Reserved for future commands (possibly usi=
ng a different structure)    \\
> > > > >  \hline
> > > > > @@ -429,6 +430,44 @@ \subsection{Group administration commands}\l=
abel{sec:Basic Facilities of a Virti
> > > > >  \field{VF Enable} refer to registers within the SR-IOV Extended
> > > > >  Capability as specified by \hyperref[intro:PCIe]{[PCIe]}.
> > > > >
> > > > > +\subsubsection{Bind the device for member}
> > > > > +
> > > > > +The VFs of the SR-IOV are created by the user inside the guest O=
S, so the virtio
> > > > > +devices don't know about these VFs. Because each VF may be assig=
ned a different role
> > > > > +by the user, the virtio device can not choose one VF to bind ran=
dom.
> > > > > +So only the user knows how to bind the virtio devices to the VFs.
> > > > > +On the other hand, generally the virtio devices are not created =
by the user
> > > > > +inside the guest OS. This requires some management platform to p=
articipate.
> > > > > +
> > > > > +So we introduce a new admin queue command to bind the VFs and th=
e virtio
> > > > > +devices.
> > > > > +
> > > > > +\begin{lstlisting}
> > > > > +struct virtio_admin_cmd_bind {
> > > > > +    u64 identity;
> > > > > +};
> > > > > +\end{lstlisting}
> > > > > +
> > > > > +The user got the \field{identity} from the management platform, =
that is not
> > > > > +included by this spec.
> > > > > +
> > > > > +\drivernormative{\paragraph}{Group administration commands}{Basi=
c Facilities of a Virtio Device / Device groups / Group administration comm=
ands / Bind the device for member}
> > > > > +
> > > > > +VIRTIO_ADMIN_CMD_BIND_DEVICE requires that the \field{group_memb=
er_id} MUST be set.
> > > > > +
> > > > > +The \field{identity} is passed by the user. It is the identity o=
f the virtio
> > > > > +device.
> > > > > +
> > > > > +\devicenormative{\paragraph}{Group administration commands}{Basi=
c Facilities of a Virtio Device / Device groups / Group administration comm=
ands / Bind the device for member}
> > > > > +
> > > > > +Every device MUST have one unique \field{identity} in the host.
> > > > > +
> > > > > +If the PF device can not find the device by the \field{identity},
> > > > > +the \field{status} MUST be set to VIRTIO_ADMIN_STATUS_EINVAL.
> > > > > +
> > > > > +If the device is found by the \field{identity}, the device MUST =
work as the
> > > > > +device of this group member specified by the \field{group_member=
_id}.
> > > > > +
> > > > >  \section{Administration Virtqueues}\label{sec:Basic Facilities o=
f a Virtio Device / Administration Virtqueues}
> > > > >
> > > > >  An administration virtqueue of an owner device is used to submit
> > > > > --
> > > > > 2.32.0.3.g01195cf9f
> > > > >
> > > > >
> > > > > This publicly archived list offers a means to provide input to the
> > > > > OASIS Virtual I/O Device (VIRTIO) TC.
> > > > >
> > > > > In order to verify user consent to the Feedback License terms and
> > > > > to minimize spam in the list archive, subscription is required
> > > > > before posting.
> > > > >
> > > > > Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> > > > > Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> > > > > List help: virtio-comment-help@lists.oasis-open.org
> > > > > List archive: https://lists.oasis-open.org/archives/virtio-commen=
t/
> > > > > Feedback License: https://www.oasis-open.org/who/ipr/feedback_lic=
ense.pdf
> > > > > List Guidelines: https://www.oasis-open.org/policies-guidelines/m=
ailing-lists
> > > > > Committee: https://www.oasis-open.org/committees/virtio/
> > > > > Join OASIS: https://www.oasis-open.org/join/
> > > > >
> > > >
> > >
> >
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

