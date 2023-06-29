Return-Path: <virtio-dev-return-13140-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB545EB64DA
	for <virtio-dev@archiver.kernel.org>; Thu, 29 Jun 2023 03:29:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 406367E2DA
	for <virtio-dev@archiver.kernel.org>; Thu, 29 Jun 2023 03:29:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 347B198667F
	for <virtio-dev@archiver.kernel.org>; Thu, 29 Jun 2023 03:29:28 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2A1409865CE; Thu, 29 Jun 2023 03:29:28 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 13691986590
	for <virtio-dev@lists.oasis-open.org>; Thu, 29 Jun 2023 03:29:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: BsKrIkUSM8ir6aNF_nHbqA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688009362; x=1690601362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZhUZRsfZAsfcUCNmxuz68VVSaIeNbux1Anw7CEPGc0M=;
        b=KHI5+XXKDrsLsLVZ2Pdep8OKqfYz0p8eByNXXRqRRxTQxEFsiuGyIvXVx2dfES5jJX
         91Q4ljbShOm88ocQD7RZ18IrI6Kw1y309j+Pr5G42cOmCfkBeKCIi5RSkrCe9bTIBcly
         GGnuSO92gDxSvbVIMmo2E4ij8HUPzRdn3x5DDlXyTw8GFBYG8V//FlS2bb+NY/+lmzl3
         lHXTCOTs3Yum1MDKEdBjtcxQtYyKJBKzVIUk7slo/PB7CKKUQchgvzr+WmEEH84Eepzu
         +Jaw8D4OiJNVaPn1FvizAKXWcqX53gucPR8B7MKVkR0h67U8ZZkCLcDkqX98PG+Jxmwc
         0fpg==
X-Gm-Message-State: AC+VfDw8+MF2FIC1AQ3nYv1nimQbomw7ovEqo18OM7AIX63LEO6XL2Vm
	yJNzfK8SuWo9cPOPub8uy+LMrTC5M1XDc9i1+TvjHprTh88T3ZVCG4bltLOogkYyJABzYH1DZ/6
	QrH4otrBkbKC9sodNJtnMxHw5EFXvfb71sLGZTt0grRBL
X-Received: by 2002:a05:651c:103c:b0:2b6:a83e:4ce3 with SMTP id w28-20020a05651c103c00b002b6a83e4ce3mr7050480ljm.44.1688009362145;
        Wed, 28 Jun 2023 20:29:22 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ56Y6bR/BH9z/yZVtyz/6yDcQ2b8cEPN2ESMbbuhG5EAnSw8l0SKOx9UVDW0ijoHF7KZTsyQcTFqJVGwvud+wY=
X-Received: by 2002:a05:651c:103c:b0:2b6:a83e:4ce3 with SMTP id
 w28-20020a05651c103c00b002b6a83e4ce3mr7050473ljm.44.1688009361820; Wed, 28
 Jun 2023 20:29:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230626062210.49020-1-xuanzhuo@linux.alibaba.com>
 <1687854185.3344731-3-xuanzhuo@linux.alibaba.com> <CACGkMEs=2HJ=Bg5Xk1GYZAOKpNLpf5EUrkNEkEOKU4hSbXC=mw@mail.gmail.com>
 <1687863046.3264692-9-xuanzhuo@linux.alibaba.com> <CACGkMEvyJrnyN0CFv2sAraNQM5E_Hkccmo1hJNzQPX8DRB5ryg@mail.gmail.com>
 <1687932392.6613173-2-xuanzhuo@linux.alibaba.com> <20230628114143-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230628114143-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 29 Jun 2023 11:29:10 +0800
Message-ID: <CACGkMEspnOhFi3XbeOaZ3mPcCv3G8+34hVYo7nrmVndDkZSJ2w@mail.gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtio-dev@lists.oasis-open.org, 
	parav@nvidia.com, virtio-comment@lists.oasis-open.org, 
	"Zhu, Lingshan" <lingshan.zhu@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [virtio-comment] [RFC PATCH] admin-queue: bind the group member
 to the device

On Wed, Jun 28, 2023 at 11:55=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Wed, Jun 28, 2023 at 02:06:32PM +0800, Xuan Zhuo wrote:
> > On Wed, 28 Jun 2023 10:49:45 +0800, Jason Wang <jasowang@redhat.com> wr=
ote:
> > > On Tue, Jun 27, 2023 at 6:54=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.ali=
baba.com> wrote:
> > > >
> > > > On Tue, 27 Jun 2023 17:00:06 +0800, Jason Wang <jasowang@redhat.com=
> wrote:
> > > > > On Tue, Jun 27, 2023 at 4:28=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux=
.alibaba.com> wrote:
> > > > > >
> > > > > >
> > > > > > Thanks Parav for pointing it out. We may have some gaps on the =
case.
> > > > > >
> > > > > > Let me introduce our case, which I think it is simple and shoul=
d be easy to
> > > > > > understand.
> > > > > >
> > > > > > First, the user (customer) purchased a bare metal machine.
> > > > > >
> > > > > > ## Bare metal machine
> > > > > >
> > > > > > Let me briefly explain the characteristics of a bare metal mach=
ine. It is not a
> > > > > > virtual machine, it is a physical machine, and the difference b=
etween it and a
> > > > > > general physical machine is that its PCI is connected to a devi=
ce similar to a
> > > > > > DPU. This DPU provides devices such as virtio-blk/net to the ho=
st through PCI.
> > > > > > These devices are managed by the vendor, and must be created an=
d purchased
> > > > > > on the vendor's management platform.
> > > > > >
> > > > > > ## DPU
> > > > > >
> > > > > > There is a software implementation in the DPU, which will respo=
nd to PCI
> > > > > > operations. But as mentioned above, resources such as network c=
ards must be
> > > > > > purchased and created before they can exist. So users can creat=
e VF, which is
> > > > > > just a pci-level operation, but there may not be a correspondin=
g backend.
> > > > > >
> > > > > > ## Management Platform
> > > > > >
> > > > > > The creation and configuration of devices is realized on the ma=
nagement
> > > > > > platform.
> > > > > >
> > > > > > After the user completed the purchase on the management platfor=
m (this is an
> > > > > > independent platform provided by the vendor and has nothing to =
do with
> > > > > > virtio), then there will be a corresponding device implementati=
on in the DPU.
> > > > > > This includes some user configurations, available bandwidth res=
ources and other
> > > > > > information.
> > > > > >
> > > > > > ## Usage
> > > > > >
> > > > > > Since the user is directly on the HOST, the user can create VMs=
, passthrough PF
> > > > > > or VF into the VM. Or users can create a large number of docker=
s, all of which
> > > > > > use a separate virtio-net device for performance.
> > > > > >
> > > > > > The reason why users use vf is that we need to use a large numb=
er of virtio-net
> > > > > > devices. This number reaches 1k+.
> > > > > >
> > > > > > Based on this scenario, we need to bind vf to the backend devic=
e. Because, we
> > > > > > cannot automatically complete the creation of the virtio-net ba=
ckend device when
> > > > > > the user creates a vf.
> > > > > >
> > > > > > ## Migration
> > > > > >
> > > > > > In addition, let's consider another scenario of migration. If a=
 vm is migrated
> > > > > > from another host, of course its corresponding virtio device is=
 also migrated to
> > > > > > the DPU. At this time, our newly created vf can only be used by=
 the vm after it
> > > > > > is bound to the migrated device. We do not want this vf to be a=
 brand new
> > > > > > device.
> > > > > >
> > > > > > ## Abstraction
> > > > > >
> > > > > > So, this is how I understand the process of creating vf:
> > > > > >
> > > > > > 1. Create a PCI VF, at this time there may be no backend virtio=
 device, or there
> > > > > >     is only a default backend. It does not fully meet our expec=
tations.
> > > > > > 2. Create device or migrate device
> > > > > > 3. Bind the backend virtio device to the vf
> > > > >
> > > > > 3) should come before 2)?
> > > > >
> > > > > Who is going to do 3) btw, is it the user? If yes, for example, i=
f a
> > > > > user wants another 4 queue virtio-net devices, after purchase, ho=
w
> > > > > does the user know its id?
> > > >
> > > > Got the id from the management platform.
> > >
> > > So it can do the binding via that management platform which this
> > > became a cloud vendor specific interface.
> >
> > In our scenario, this is bound by the user using this id and vf id in t=
he os.
> >
> > >
> > > >
> > > > >
> > > > > >
> > > > > > In most scenarios, the first step may be enough. We can make so=
me fine-tuning on
> > > > > > this default device, such as modifying its mac. In the future, =
we can use admin
> > > > > > queue to modify its msix vector and other configurations.
> > > > > >
> > > > > > But we should allow, we bind a backend virtio device to a certa=
in vf. This is
> > > > > > useful for live migration and virtio devices with special confi=
gurations.
> > > > >
> > > > > All of these could be addressed if a dynamic provisioning model i=
s
> > > > > implemented (SIOV or transport virtqueue). Trying to have a worka=
round
> > > > > in SR-IOV might be tricky.
> > > >
> > > >
> > > > SR-IOV vf is native PCI device, this is the advancement.
> > >
> > > The problem is that it doesn't support flexible provisioning, e.g
> > > create and destroy a single VF.
> >
> > YES. ^_^!!
>
> So sure, create it. Once you have created it, you can
> use the VF# to talk to it.
>
>
> I *suspect* that what this ID does is replace provisioning commands.
>
> So instead of saying "create VF#3 with MAC 0xABC and 0x1000VQs"
> you would have management say "ID 0xFACE refers to MAC ABC and 1000VQs"
> and later you will say "bind VF#3 to ID 0xFACE" and that will
> set it up.
>
> Is that it?
>
> But why is it important to do it in two steps like this?
> as opposed to in one step?  I have no idea.
>
> >
> > >
> > > >
> > > >
> > > > >
> > > > > >
> > > > > > The design of virtio itself is two layers, and virtio should al=
low switching the
> > > > > > transport layer by nature. This is our advantage.
> > > > >
> > > > > Is it not switching the transport layer but about binding/unbindi=
ng
> > > > > vitio devices to VF?
> > > >
> > > > YES.
> > > >
> > > > >
> > > > > Is a new capability or similar admin cmd sufficient in this case?
> > > >
> > > > All is ok.
> > > >
> > > >
> > > > >
> > > > > struct virtio_pci_bind_cap {
> > > > >         struct virtio_pci_cap cap;
> > > > >         u16 bind; // virtio_device_id
> > > > >         u16 unbind; // virtio_device_id
> > > > > };
> > > >
> > > > You mean that the "bind" or "unbind" is writeable?
> >
> > This is a good idea.
> >
> > Thanks.
>
> So stealing valuable memory from limited pci config space, no error
> handling, no filtering... Ugh.  Let's not put a round peg in a square
> hole.

It's just quick example to demonstrate the idea, actually I meant it
could be done via admin cmd, see above

"""
Is a new capability or similar admin cmd sufficient in this case?
"""

Thanks

>
> For management I think we should use admin commands. They were built for
> the management use-case.
> Config space (pci and virtio) is better for driver slow path.
>
> --
> MST
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

