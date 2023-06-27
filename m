Return-Path: <virtio-dev-return-13101-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32F5CEB64D9
	for <virtio-dev@archiver.kernel.org>; Tue, 27 Jun 2023 09:00:24 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 8524642568
	for <virtio-dev@archiver.kernel.org>; Tue, 27 Jun 2023 09:00:23 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6333C98639B
	for <virtio-dev@archiver.kernel.org>; Tue, 27 Jun 2023 09:00:23 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 4BBD59843C5; Tue, 27 Jun 2023 09:00:23 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3868698635B
	for <virtio-dev@lists.oasis-open.org>; Tue, 27 Jun 2023 09:00:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: bL5Q1KA6N3u8ZgtgSqFdKw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687856418; x=1690448418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SRbI97ViN0RMhAMLAXjsjIgY0w/B75u/mAwb1dWpfY4=;
        b=lNM+QZPAh+MvSWaSWI0hBtxjK+JqDvdq+0BRU9slCUqIk6H5FKGkrj9uLGeoF4XAkv
         EwAGSBAJhH2XkLCu7vJnmTbnL52MAs0ZyIORn9BJb1/7Im8BPD77FESiwzXBuTDkfJFU
         rl4xuBtbdqOr8z3P6lFXNVGIktoQAmSj1HaxP0iPhMYXFw6QGCU4z0Gg1l0akCdLujJ5
         RvUTQK/fujS/+17NgXb6Rewse4y8LceRMvxzwzyPJ+vwdP6ffWWgEpJuc4e3mmBKzbQZ
         1BF0TBew0nmL8CVbG7+VFEZMnpScpeKvcr6pQlPj7r2DflDmymU57hHyOFEpOpoyQxBe
         R0DQ==
X-Gm-Message-State: AC+VfDzAOgTKoBwPumwWAvZPVWClovz1QK0kjJjtYxHCXGgdKHPeXnf+
	qxIcAcNecclNThLfdMvZMAQujLRiLPtzN8Bh2J1OC2imRPVNjS6PlIQjtylmyHicuFJVqRrJRFW
	t6JMSLbBKBbswrkNgZlCph9omKqkDTqiNfYZlKIaZ5niq
X-Received: by 2002:a05:651c:10c:b0:2b6:a3a4:f7e8 with SMTP id a12-20020a05651c010c00b002b6a3a4f7e8mr3111574ljb.17.1687856418550;
        Tue, 27 Jun 2023 02:00:18 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6OFJknmYZUjAvOC5HwJQryymuAhawZPL0lMo26DeOhtgqE0gHmt4wWZP0rqM8usGwiXbkPF7XnQNTty18QegI=
X-Received: by 2002:a05:651c:10c:b0:2b6:a3a4:f7e8 with SMTP id
 a12-20020a05651c010c00b002b6a3a4f7e8mr3111556ljb.17.1687856418124; Tue, 27
 Jun 2023 02:00:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230626062210.49020-1-xuanzhuo@linux.alibaba.com> <1687854185.3344731-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1687854185.3344731-3-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 27 Jun 2023 17:00:06 +0800
Message-ID: <CACGkMEs=2HJ=Bg5Xk1GYZAOKpNLpf5EUrkNEkEOKU4hSbXC=mw@mail.gmail.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtio-dev@lists.oasis-open.org, mst@redhat.com, parav@nvidia.com, 
	virtio-comment@lists.oasis-open.org, "Zhu, Lingshan" <lingshan.zhu@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [virtio-comment] [RFC PATCH] admin-queue: bind the group member
 to the device

On Tue, Jun 27, 2023 at 4:28=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
>
> Thanks Parav for pointing it out. We may have some gaps on the case.
>
> Let me introduce our case, which I think it is simple and should be easy =
to
> understand.
>
> First, the user (customer) purchased a bare metal machine.
>
> ## Bare metal machine
>
> Let me briefly explain the characteristics of a bare metal machine. It is=
 not a
> virtual machine, it is a physical machine, and the difference between it =
and a
> general physical machine is that its PCI is connected to a device similar=
 to a
> DPU. This DPU provides devices such as virtio-blk/net to the host through=
 PCI.
> These devices are managed by the vendor, and must be created and purchase=
d
> on the vendor's management platform.
>
> ## DPU
>
> There is a software implementation in the DPU, which will respond to PCI
> operations. But as mentioned above, resources such as network cards must =
be
> purchased and created before they can exist. So users can create VF, whic=
h is
> just a pci-level operation, but there may not be a corresponding backend.
>
> ## Management Platform
>
> The creation and configuration of devices is realized on the management
> platform.
>
> After the user completed the purchase on the management platform (this is=
 an
> independent platform provided by the vendor and has nothing to do with
> virtio), then there will be a corresponding device implementation in the =
DPU.
> This includes some user configurations, available bandwidth resources and=
 other
> information.
>
> ## Usage
>
> Since the user is directly on the HOST, the user can create VMs, passthro=
ugh PF
> or VF into the VM. Or users can create a large number of dockers, all of =
which
> use a separate virtio-net device for performance.
>
> The reason why users use vf is that we need to use a large number of virt=
io-net
> devices. This number reaches 1k+.
>
> Based on this scenario, we need to bind vf to the backend device. Because=
, we
> cannot automatically complete the creation of the virtio-net backend devi=
ce when
> the user creates a vf.
>
> ## Migration
>
> In addition, let's consider another scenario of migration. If a vm is mig=
rated
> from another host, of course its corresponding virtio device is also migr=
ated to
> the DPU. At this time, our newly created vf can only be used by the vm af=
ter it
> is bound to the migrated device. We do not want this vf to be a brand new
> device.
>
> ## Abstraction
>
> So, this is how I understand the process of creating vf:
>
> 1. Create a PCI VF, at this time there may be no backend virtio device, o=
r there
>     is only a default backend. It does not fully meet our expectations.
> 2. Create device or migrate device
> 3. Bind the backend virtio device to the vf

3) should come before 2)?

Who is going to do 3) btw, is it the user? If yes, for example, if a
user wants another 4 queue virtio-net devices, after purchase, how
does the user know its id?

>
> In most scenarios, the first step may be enough. We can make some fine-tu=
ning on
> this default device, such as modifying its mac. In the future, we can use=
 admin
> queue to modify its msix vector and other configurations.
>
> But we should allow, we bind a backend virtio device to a certain vf. Thi=
s is
> useful for live migration and virtio devices with special configurations.

All of these could be addressed if a dynamic provisioning model is
implemented (SIOV or transport virtqueue). Trying to have a workaround
in SR-IOV might be tricky.

>
> The design of virtio itself is two layers, and virtio should allow switch=
ing the
> transport layer by nature. This is our advantage.

Is it not switching the transport layer but about binding/unbinding
vitio devices to VF?

Is a new capability or similar admin cmd sufficient in this case?

struct virtio_pci_bind_cap {
        struct virtio_pci_cap cap;
        u16 bind; // virtio_device_id
        u16 unbind; // virtio_device_id
};

Thanks

>
> ## About the identity
>
> In this patch, I used a vendor's id. The purpose of this is that I hope t=
o
> be compatible with all devices. In the network scenario, it is actually p=
ossible
> to use a mac.
>
> Perhaps, introduce a standard id for each device/driver, I think this may=
 be
> more in line with the habit of virtio spec.
>
> Thanks.
>
> On Mon, 26 Jun 2023 14:22:10 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba.com=
> wrote:
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
> > 2. The user creates a VF with echo 8 > sriov_numvfs
> > 3. The user binds the net crad to a VF with identity through the comman=
d
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

