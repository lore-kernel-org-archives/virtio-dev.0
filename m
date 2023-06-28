Return-Path: <virtio-dev-return-13113-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F045EB64DD
	for <virtio-dev@archiver.kernel.org>; Wed, 28 Jun 2023 02:50:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D1DC07C6B5
	for <virtio-dev@archiver.kernel.org>; Wed, 28 Jun 2023 02:50:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1FBA298683A
	for <virtio-dev@archiver.kernel.org>; Wed, 28 Jun 2023 02:50:31 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 76AA398654C; Wed, 28 Jun 2023 02:50:30 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 66BFC98654E
	for <virtio-dev@lists.oasis-open.org>; Wed, 28 Jun 2023 02:50:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: jAvDsMiMMoyOHHctcUzx7Q-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687920597; x=1690512597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FhqrNGZ5I75io87FzwkG+CsRwnWd7gBJ+hwRNUD8H/4=;
        b=eUqD51r7ILcNgPANlu6RYBjldvP4J/ZpQlGIQpVgzaWwYLKx26fSeuZFtoW31WqUoZ
         Pw4zSq2zYr5q2erTZjhwx/mSRZSbMlqb9vp6keQrSXMKn1/o6id57d05XylWf45DKIme
         1woSoFt//+z+1eJMqlKMpqRfGsudhxW/m374gii+RJxeJJoDNpFF47QKtNLmP+zVkTW3
         0rIFm8qryKXWahJKpgYotWJMSJlgYL3MxX+Jbg0j9F6eRCMq9koi/gdAeCbvxHr+2Ri9
         RS9qSsOHJ1LRLg2j1gzkESVn4Ta0w4TwM2EniDliXQmzMPLcj6VAfMe0IRSHxe1c9Y5m
         GXDQ==
X-Gm-Message-State: AC+VfDw3gNNpn/61ng2XnUMMW1+u30lIaQk3yWwrBvsJS4bkgP/YWIXf
	4eBhPcMWwk9hxRkQJ5b+k8wbDhhWa+TmfvP5ur0f6Ejrtfcmtu7ccBMaxc/fnUV7eWnbNAxDt1L
	m8g1ZEXLK579WeK/2Wft+XBZaJZJn7oPU2kIZJDK73EiD
X-Received: by 2002:a2e:a1c9:0:b0:2b6:a841:e690 with SMTP id c9-20020a2ea1c9000000b002b6a841e690mr3805545ljm.42.1687920596939;
        Tue, 27 Jun 2023 19:49:56 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5dBkoQMuZID/5vQ0OdTbDQuIDFewrFECokZXUdo74kS8wyU2QRO2UeNkmcD9D2gfE1ECqt0JNZhR5dylDEEV8=
X-Received: by 2002:a2e:a1c9:0:b0:2b6:a841:e690 with SMTP id
 c9-20020a2ea1c9000000b002b6a841e690mr3805536ljm.42.1687920596541; Tue, 27 Jun
 2023 19:49:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230626062210.49020-1-xuanzhuo@linux.alibaba.com>
 <1687854185.3344731-3-xuanzhuo@linux.alibaba.com> <CACGkMEs=2HJ=Bg5Xk1GYZAOKpNLpf5EUrkNEkEOKU4hSbXC=mw@mail.gmail.com>
 <1687863046.3264692-9-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1687863046.3264692-9-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 28 Jun 2023 10:49:45 +0800
Message-ID: <CACGkMEvyJrnyN0CFv2sAraNQM5E_Hkccmo1hJNzQPX8DRB5ryg@mail.gmail.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtio-dev@lists.oasis-open.org, mst@redhat.com, parav@nvidia.com, 
	virtio-comment@lists.oasis-open.org, "Zhu, Lingshan" <lingshan.zhu@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [virtio-comment] [RFC PATCH] admin-queue: bind the group member
 to the device

On Tue, Jun 27, 2023 at 6:54=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Tue, 27 Jun 2023 17:00:06 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Tue, Jun 27, 2023 at 4:28=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > >
> > >
> > > Thanks Parav for pointing it out. We may have some gaps on the case.
> > >
> > > Let me introduce our case, which I think it is simple and should be e=
asy to
> > > understand.
> > >
> > > First, the user (customer) purchased a bare metal machine.
> > >
> > > ## Bare metal machine
> > >
> > > Let me briefly explain the characteristics of a bare metal machine. I=
t is not a
> > > virtual machine, it is a physical machine, and the difference between=
 it and a
> > > general physical machine is that its PCI is connected to a device sim=
ilar to a
> > > DPU. This DPU provides devices such as virtio-blk/net to the host thr=
ough PCI.
> > > These devices are managed by the vendor, and must be created and purc=
hased
> > > on the vendor's management platform.
> > >
> > > ## DPU
> > >
> > > There is a software implementation in the DPU, which will respond to =
PCI
> > > operations. But as mentioned above, resources such as network cards m=
ust be
> > > purchased and created before they can exist. So users can create VF, =
which is
> > > just a pci-level operation, but there may not be a corresponding back=
end.
> > >
> > > ## Management Platform
> > >
> > > The creation and configuration of devices is realized on the manageme=
nt
> > > platform.
> > >
> > > After the user completed the purchase on the management platform (thi=
s is an
> > > independent platform provided by the vendor and has nothing to do wit=
h
> > > virtio), then there will be a corresponding device implementation in =
the DPU.
> > > This includes some user configurations, available bandwidth resources=
 and other
> > > information.
> > >
> > > ## Usage
> > >
> > > Since the user is directly on the HOST, the user can create VMs, pass=
through PF
> > > or VF into the VM. Or users can create a large number of dockers, all=
 of which
> > > use a separate virtio-net device for performance.
> > >
> > > The reason why users use vf is that we need to use a large number of =
virtio-net
> > > devices. This number reaches 1k+.
> > >
> > > Based on this scenario, we need to bind vf to the backend device. Bec=
ause, we
> > > cannot automatically complete the creation of the virtio-net backend =
device when
> > > the user creates a vf.
> > >
> > > ## Migration
> > >
> > > In addition, let's consider another scenario of migration. If a vm is=
 migrated
> > > from another host, of course its corresponding virtio device is also =
migrated to
> > > the DPU. At this time, our newly created vf can only be used by the v=
m after it
> > > is bound to the migrated device. We do not want this vf to be a brand=
 new
> > > device.
> > >
> > > ## Abstraction
> > >
> > > So, this is how I understand the process of creating vf:
> > >
> > > 1. Create a PCI VF, at this time there may be no backend virtio devic=
e, or there
> > >     is only a default backend. It does not fully meet our expectation=
s.
> > > 2. Create device or migrate device
> > > 3. Bind the backend virtio device to the vf
> >
> > 3) should come before 2)?
> >
> > Who is going to do 3) btw, is it the user? If yes, for example, if a
> > user wants another 4 queue virtio-net devices, after purchase, how
> > does the user know its id?
>
> Got the id from the management platform.

So it can do the binding via that management platform which this
became a cloud vendor specific interface.

>
> >
> > >
> > > In most scenarios, the first step may be enough. We can make some fin=
e-tuning on
> > > this default device, such as modifying its mac. In the future, we can=
 use admin
> > > queue to modify its msix vector and other configurations.
> > >
> > > But we should allow, we bind a backend virtio device to a certain vf.=
 This is
> > > useful for live migration and virtio devices with special configurati=
ons.
> >
> > All of these could be addressed if a dynamic provisioning model is
> > implemented (SIOV or transport virtqueue). Trying to have a workaround
> > in SR-IOV might be tricky.
>
>
> SR-IOV vf is native PCI device, this is the advancement.

The problem is that it doesn't support flexible provisioning, e.g
create and destroy a single VF.

>
>
> >
> > >
> > > The design of virtio itself is two layers, and virtio should allow sw=
itching the
> > > transport layer by nature. This is our advantage.
> >
> > Is it not switching the transport layer but about binding/unbinding
> > vitio devices to VF?
>
> YES.
>
> >
> > Is a new capability or similar admin cmd sufficient in this case?
>
> All is ok.
>
>
> >
> > struct virtio_pci_bind_cap {
> >         struct virtio_pci_cap cap;
> >         u16 bind; // virtio_device_id
> >         u16 unbind; // virtio_device_id
> > };
>
> You mean that the "bind" or "unbind" is writeable?

Yes.

Thanks

>
> Thanks.
>
> >
> > Thanks
> >
> > >
> > > ## About the identity
> > >
> > > In this patch, I used a vendor's id. The purpose of this is that I ho=
pe to
> > > be compatible with all devices. In the network scenario, it is actual=
ly possible
> > > to use a mac.
> > >
> > > Perhaps, introduce a standard id for each device/driver, I think this=
 may be
> > > more in line with the habit of virtio spec.
> > >
> > > Thanks.
> > >
> > > On Mon, 26 Jun 2023 14:22:10 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> > > > The VFs of the SR-IOV are created by the user inside the guest OS, =
so the virtio
> > > > devices don't know about these VFs. Because each VF may be assigned=
 a different role
> > > > by the user, the virtio device can not choose one VF to bind random=
.
> > > > So only the user knows how to bind the virtio devices to the VFs.
> > > > On the other hand, generally the virtio devices are not created by =
the user
> > > > inside the guest OS. This requires some management platform to part=
icipate.
> > > >
> > > > So the usage of this command:
> > > > 1. The user purchases a virtio network card on the management platf=
orm,
> > > >    and sets the ip, queue number, etc. The user obtains the identit=
y of
> > > >    the network card.
> > > > 2. The user creates a VF with echo 8 > sriov_numvfs
> > > > 3. The user binds the net crad to a VF with identity through the co=
mmand
> > > >    of the patch
> > > >
> > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > ---
> > > >  admin.tex | 41 ++++++++++++++++++++++++++++++++++++++++-
> > > >  1 file changed, 40 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/admin.tex b/admin.tex
> > > > index 2efd4d7..64d0667 100644
> > > > --- a/admin.tex
> > > > +++ b/admin.tex
> > > > @@ -115,7 +115,8 @@ \subsection{Group administration commands}\labe=
l{sec:Basic Facilities of a Virti
> > > >  \hline \hline
> > > >  0x0000 & VIRTIO_ADMIN_CMD_LIST_QUERY & Provides to driver list of =
commands supported for this group type    \\
> > > >  0x0001 & VIRTIO_ADMIN_CMD_LIST_USE & Provides to device list of co=
mmands used for this group type \\
> > > > -0x0002 - 0x7FFF & - & Commands using \field{struct virtio_admin_cm=
d}    \\
> > > > +0x0002 & VIRTIO_ADMIN_CMD_BIND_DEVICE & Bind the device to one gro=
up member \\
> > > > +0x0003 - 0x7FFF & - & Commands using \field{struct virtio_admin_cm=
d}    \\
> > > >  \hline
> > > >  0x8000 - 0xFFFF & - & Reserved for future commands (possibly using=
 a different structure)    \\
> > > >  \hline
> > > > @@ -429,6 +430,44 @@ \subsection{Group administration commands}\lab=
el{sec:Basic Facilities of a Virti
> > > >  \field{VF Enable} refer to registers within the SR-IOV Extended
> > > >  Capability as specified by \hyperref[intro:PCIe]{[PCIe]}.
> > > >
> > > > +\subsubsection{Bind the device for member}
> > > > +
> > > > +The VFs of the SR-IOV are created by the user inside the guest OS,=
 so the virtio
> > > > +devices don't know about these VFs. Because each VF may be assigne=
d a different role
> > > > +by the user, the virtio device can not choose one VF to bind rando=
m.
> > > > +So only the user knows how to bind the virtio devices to the VFs.
> > > > +On the other hand, generally the virtio devices are not created by=
 the user
> > > > +inside the guest OS. This requires some management platform to par=
ticipate.
> > > > +
> > > > +So we introduce a new admin queue command to bind the VFs and the =
virtio
> > > > +devices.
> > > > +
> > > > +\begin{lstlisting}
> > > > +struct virtio_admin_cmd_bind {
> > > > +    u64 identity;
> > > > +};
> > > > +\end{lstlisting}
> > > > +
> > > > +The user got the \field{identity} from the management platform, th=
at is not
> > > > +included by this spec.
> > > > +
> > > > +\drivernormative{\paragraph}{Group administration commands}{Basic =
Facilities of a Virtio Device / Device groups / Group administration comman=
ds / Bind the device for member}
> > > > +
> > > > +VIRTIO_ADMIN_CMD_BIND_DEVICE requires that the \field{group_member=
_id} MUST be set.
> > > > +
> > > > +The \field{identity} is passed by the user. It is the identity of =
the virtio
> > > > +device.
> > > > +
> > > > +\devicenormative{\paragraph}{Group administration commands}{Basic =
Facilities of a Virtio Device / Device groups / Group administration comman=
ds / Bind the device for member}
> > > > +
> > > > +Every device MUST have one unique \field{identity} in the host.
> > > > +
> > > > +If the PF device can not find the device by the \field{identity},
> > > > +the \field{status} MUST be set to VIRTIO_ADMIN_STATUS_EINVAL.
> > > > +
> > > > +If the device is found by the \field{identity}, the device MUST wo=
rk as the
> > > > +device of this group member specified by the \field{group_member_i=
d}.
> > > > +
> > > >  \section{Administration Virtqueues}\label{sec:Basic Facilities of =
a Virtio Device / Administration Virtqueues}
> > > >
> > > >  An administration virtqueue of an owner device is used to submit
> > > > --
> > > > 2.32.0.3.g01195cf9f
> > > >
> > > >
> > > > This publicly archived list offers a means to provide input to the
> > > > OASIS Virtual I/O Device (VIRTIO) TC.
> > > >
> > > > In order to verify user consent to the Feedback License terms and
> > > > to minimize spam in the list archive, subscription is required
> > > > before posting.
> > > >
> > > > Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> > > > Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> > > > List help: virtio-comment-help@lists.oasis-open.org
> > > > List archive: https://lists.oasis-open.org/archives/virtio-comment/
> > > > Feedback License: https://www.oasis-open.org/who/ipr/feedback_licen=
se.pdf
> > > > List Guidelines: https://www.oasis-open.org/policies-guidelines/mai=
ling-lists
> > > > Committee: https://www.oasis-open.org/committees/virtio/
> > > > Join OASIS: https://www.oasis-open.org/join/
> > > >
> > >
> >
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

