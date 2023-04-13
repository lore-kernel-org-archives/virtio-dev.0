Return-Path: <virtio-dev-return-12203-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9142C77B61
	for <virtio-dev@archiver.kernel.org>; Thu, 13 Apr 2023 05:14:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 1D1002B06C
	for <virtio-dev@archiver.kernel.org>; Thu, 13 Apr 2023 05:14:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E5E16986602
	for <virtio-dev@archiver.kernel.org>; Thu, 13 Apr 2023 05:14:33 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id CE8CB9865F6; Thu, 13 Apr 2023 05:14:33 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BB5E09865F7
	for <virtio-dev@lists.oasis-open.org>; Thu, 13 Apr 2023 05:14:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: UDB3TyIuP0SW7QKOP-FdzQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681362868; x=1683954868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rZKMfhHMlSv5Os9k9pl+VbavZ90IGOGlhGSf6b+FXSg=;
        b=VhIx76zBpVd35gpzSEzXk2ekIuMW/2QJ942t2rTnGV+EI8BUt595MaP9pm9NXjkA78
         0JsmQA1yjBEDt/rZpo5GRQQTtjKPK0Zji5GLCX5M7no9YvwyBNCo55uGgxsYlV4hJbZM
         Pp0JscK9pB6nlIQ7cHTvFNbwiSdwkQ69rUDzlKdhbQICYPiFSeng97C6nZ2LPTFRZ4sY
         H+vTtO2VBgJiQplA+/nc+kHV37iU6/u37EvheKBCBT/B+iWuulXbUa5hTqadjkQDrZrS
         1U6YeEIrpLhrt+30+0tceyRRD5FdxfP6v/sWKlN8U1onDYRiN4M6yATRxey1GmLAO6qq
         WxLA==
X-Gm-Message-State: AAQBX9fVKhNS1yHMOn9CY3HZXYXC4L41CHvqW15pIU7YXRhVcpRUPFPr
	Dk2ibvzEM1cnXyAtLV49wHNe8mPlCgQ7xndHDPQ+ehxKZxRylLzfmv9+A7TIF+JZSaI6DPuPtQg
	LdOV0cME1WcDeNjvoX30elJBn3dWwSOb35bzGCj/SsTnc
X-Received: by 2002:a4a:d0d8:0:b0:541:fe26:c252 with SMTP id u24-20020a4ad0d8000000b00541fe26c252mr219128oor.0.1681362867858;
        Wed, 12 Apr 2023 22:14:27 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZmakmSqImzOoot3ZW8kxClgnuu6+0LDUaRx8xPKn6aWTAjVVpk3IhDe+rf2Quvd02P8YH+4iwT2WRWK31KyHc=
X-Received: by 2002:a4a:d0d8:0:b0:541:fe26:c252 with SMTP id
 u24-20020a4ad0d8000000b00541fe26c252mr219123oor.0.1681362867534; Wed, 12 Apr
 2023 22:14:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230410020906-mutt-send-email-mst@kernel.org>
 <CACGkMEt2QAfhCgpYjSRNzf3n4W_HJLrMfE9JHzocR_gPH_Zrtg@mail.gmail.com>
 <20230411063945-mutt-send-email-mst@kernel.org> <CACGkMEufWUXHKahg3GLOKfV5aptbiek_DKwy+7rCfMya2GPaTQ@mail.gmail.com>
 <20230412000802-mutt-send-email-mst@kernel.org> <CACGkMEshNydwBD=Q0JW-SDY6xyiJ4uVrLn+pxbUrinycBKwsrw@mail.gmail.com>
 <PH0PR12MB548118F57BB4B4A4F8DC9D7ADC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEvYsz1fSPG+fKpRaZ05Ut7ffKwvMPvR8xbRBsXA_6vGQw@mail.gmail.com>
 <PH0PR12MB548137D7A25C99EAA42B4D12DC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEshW82qztmGw8YJWJ8=QCoRd6cPxQ+ySazxsO_o+U6c4Q@mail.gmail.com>
 <PH0PR12MB548147CF939CB9C2A0586310DC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEu2B_GogDR9HUwB7mT8fkGh+Q_buPLz4nhwhK7h9k6BQQ@mail.gmail.com>
 <PH0PR12MB5481F0CF5A555A6BB2CE856CDC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEuNOYOxvcSzrs0UFEyk+xOkGUpOfhK8rOy_Mebz5b5wdg@mail.gmail.com> <a74d3107-d38c-df15-e2ff-f848635f24bd@nvidia.com>
In-Reply-To: <a74d3107-d38c-df15-e2ff-f848635f24bd@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 13 Apr 2023 13:14:15 +0800
Message-ID: <CACGkMEt+bGN7UYEopXPj0+deAnYm1VUNp05VvGHcJnkd8LzbGg@mail.gmail.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, 
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>, 
	Satananda Burla <sburla@marvell.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, 
	Yan Vugenfirer <yan@daynix.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH 09/11] transport-pci: Describe PCI
 MMR dev config registers

On Thu, Apr 13, 2023 at 11:31=E2=80=AFAM Parav Pandit <parav@nvidia.com> wr=
ote:
>
>
>
> On 4/12/2023 9:48 PM, Jason Wang wrote:
> > On Wed, Apr 12, 2023 at 10:23=E2=80=AFPM Parav Pandit <parav@nvidia.com=
> wrote:
> >>
> >>
> >>
> >>> From: Jason Wang <jasowang@redhat.com>
> >>> Sent: Wednesday, April 12, 2023 2:15 AM
> >>>
> >>> On Wed, Apr 12, 2023 at 1:55=E2=80=AFPM Parav Pandit <parav@nvidia.co=
m> wrote:
> >>>>
> >>>>
> >>>>
> >>>>> From: Jason Wang <jasowang@redhat.com>
> >>>>> Sent: Wednesday, April 12, 2023 1:38 AM
> >>>>
> >>>>>> Modern device says FEAETURE_1 must be offered and must be
> >>>>>> negotiated by
> >>>>> driver.
> >>>>>> Legacy has Mac as RW area. (hypervisor can do it).
> >>>>>> Reset flow is difference between the legacy and modern.
> >>>>>
> >>>>> Just to make sure we're at the same page. We're talking in the
> >>>>> context of mediation. Without mediation, your proposal can't work.
> >>>>>
> >>>> Right.
> >>>>
> >>>>> So in this case, the guest driver is not talking with the device
> >>>>> directly. Qemu needs to traps whatever it wants to achieve the
> >>>>> mediation:
> >>>>>
> >>>> I prefer to avoid picking specific sw component here, but yes. QEMU =
can trap.
> >>>>
> >>>>> 1) It's perfectly fine that Qemu negotiated VERSION_1 but presented
> >>>>> a mediated legacy device to guests.
> >>>> Right but if VERSION_1 is negotiated, device will work as V_1 with 1=
2B
> >>> virtio_net_hdr.
> >>>
> >>> Shadow virtqueue could be used here. And we have much more issues wit=
hout
> >>> shadow virtqueue, more below.
> >>>
> >>>>
> >>>>> 2) For MAC and Reset, Qemu can trap and do anything it wants.
> >>>>>
> >>>> The idea is not to poke in the fields even though such sw can.
> >>>> MAC is RW in legacy.
> >>>> Mac ia RO in 1.x.
> >>>>
> >>>> So QEMU cannot make RO register into RW.
> >>>
> >>> It can be done via using the control vq. Trap the MAC write and forwa=
rd it via
> >>> control virtqueue.
> >>>
> >> This proposal Is not implementing about vdpa mediator that requires fa=
r higher understanding in hypervisor.
> >
> > It's not related to vDPA, it's about a common technology that is used
> > in virtualization. You do a trap and emulate the status, why can't you
> > do that for others?
> >
> >> Such mediation works fine for vdpa and it is upto vdpa layer to do. No=
t relevant here.
> >>
> >>>>
> >>>> The proposed solution in this series enables it and avoid per field =
sw
> >>> interpretation and mediation in parsing values etc.
> >>>
> >>> I don't think it's possible. See the discussion about ORDER_PLATFORM =
and
> >>> ACCESS_PLATFORM in previous threads.
> >>>
> >> I have read the previous thread.
> >> Hypervisor will be limiting to those platforms where ORDER_PLATFORM is=
 not needed.
> >
> > So you introduce a bunch of new facilities that only work on some
> > specific archs. This breaks the architecture independence of virtio
> > since 1.0.
> The defined spec for PCI device does not work today for transitional
> device for virtualization. Only works in limited PF case.
> Hence this update.

I fully understand the motivation. I just want to say

1) compare to the MMIO ar BAR0, this proposal doesn't provide much advantag=
es
2) mediate on top of modern devices allows us to not worry about the
device design which is hard for legacy

> More below.
>
> > The root cause is legacy is not fit for hardware
> > implementation, any kind of hardware that tries to offer legacy
> > function will finally run into those corner cases which require extra
> > interfaces which may finally end up with a (partial) duplication of
> > the modern interface.
> >
> I agree with you. We cannot change the legacy.
> What is being added here it to enable legacy transport via MMIO or AQ
> and using notification region.
>
> Will comment where you listed 3 options.
>
> >> And this is a pci transitional device that uses the standard platform =
dma anyway so ACCESS_PLATFORM is not related.
> >
> > So which type of transactions did this device use when it is used via
> > legacy MMIO BAR? Translated request or not?
> >
> Device uses the PCI transport level addresses configured because its a
> PCI device.
>
> >> For example, a device may have implemented say only BAR2, and small po=
rtion of the BAR2 is pointing to legacy MMIO config registers.
> >
> > We're discussing spec changes, not a specific implementation here. Why
> > is the device can't use BAR0, do you see any restriction in the spec?
> >
> No restriction.
> Forcing it to use BAR0 is the restrictive method.
> >> A mediator hypervisor sw will be able to read/write to it when BAR0 is=
 exposed towards the guest VM as IOBAR 0.
> >
> > So I don't think it can work:
> >
> > 1) This is very dangerous unless the spec mandates the size (this is
> > also tricky since page size varies among arches) for any
> > BAR/capability which is not what virtio wants, the spec leave those
> > flexibility to the implementation:
> >
> > E.g
> >
> > """
> > The driver MUST accept a cap_len value which is larger than specified h=
ere.
> > """
> cap_len talks about length of the PCI capability structure as defined by
> the PCI spec. BAR length is located in the le32 length.
>
> So new MMIO region can be of any size and anywhere in the BAR.
>
> For LM BAR length and number should be same between two PCI VFs. But its
> orthogonal to this point. Such checks will be done anyway.

Quoted the wrong sections, I think it should be:

"
length MAY include padding, or fields unused by the driver, or future
extensions. Note: For example, a future device might present a large
structure size of several MBytes. As current devices never utilize
structures larger than 4KBytes in size, driver MAY limit the mapped
structure size to e.g. 4KBytes (thus ignoring parts of structure after
the first 4KBytes) to allow forward compatibility with such devices
without loss of functionality and without wasting resources.
"

>
> >
> > 2) A blocker for live migration (and compatibility), the hypervisor
> > should not assume the size for any capability so for whatever case it
> > should have a fallback for the case where the BAR can't be assigned.
> >
> I agree that hypervisor should not assume.
> for LM such compatibility checks will be done anyway.
> So not a blocker, they should match on two sides is all needed.
>
> > Let me summarize, we had three ways currently:
> >
> > 1) legacy MMIO BAR via capability:
> >
> > Pros:
> > - allow some flexibility to place MMIO BAR other than 0
> > Cons:
> > - new device ID
> Not needed as Michael suggest. Existing transitional or non transitional

If it's a transitional device but not placed at BAR0, it might have
side effects for Linux drivers which assumes BAR0 for legacy.

I don't see how easy it could be a non transitional device:

"
Devices or drivers with no legacy compatibility are referred to as
non-transitional devices and drivers, respectively.
"

> device can expose this optional capability and its attached MMIO region.
>
> Spec changes are similar to #2.
> > - non trivial spec changes which ends up of the tricky cases that
> > tries to workaround legacy to fit for a hardware implementation
> > - work only for the case of virtualization with the help of
> > meditation, can't work for bare metal
> For bare-metal PFs usually thin hypervisors are used that does very
> minimal setup. But I agree that bare-metal is relatively less important.

This is not what I understand. I know several vendors that are using
virtio devices for bare metal.

>
> > - only work for some specific archs without SVQ
> >
> That is the legacy limitation that we don't worry about.
>
> > 2) allow BAR0 to be MMIO for transitional device
> >
> > Pros:
> > - very minor change for the spec
> Spec changes wise they are similar to #1.

This is different since the changes for this are trivial.

> > - work for virtualization (and it work even without dedicated
> > mediation for some setups)
> I am not aware where can it work without mediation. Do you know any
> specific kernel version where it actually works?

E.g current Linux driver did:

rc =3D pci_request_region(pci_dev, 0, "virtio-pci-legacy");

It doesn't differ from I/O with memory. It means if you had a
"transitional" device with legacy MMIO BAR0, it just works.

>
> > - work for bare metal for some setups (without mediation)
> > Cons:
> > - only work for some specific archs without SVQ
> > - BAR0 is required
> >
> Both are not limitation as they are mainly coming from the legacy side
> of things.
>
> > 3) modern device mediation for legacy
> >
> > Pros:
> > - no changes in the spec
> > Cons:
> > - require mediation layer in order to work in bare metal
> > - require datapath mediation like SVQ to work for virtualization
> >
> Spec change is still require for net and blk because modern device do
> not understand legacy, even with mediation layer.

That's fine and easy since we work on top of modern devices.

> FEATURE_1, RW cap via CVQ which is not really owned by the hypervisor.

Hypervisors can trap if they wish.

> A guest may be legacy or non legacy, so mediation shouldn't be always don=
e.

Yes, so mediation can work only if we found it's a legacy driver.

>
> > Compared to method 2) the only advantages of method 1) is the
> > flexibility of BAR0 but it has too many disadvantages. If we only care
> > about virtualization, modern devices are sufficient. Then why bother
> > for that?
>
> So that a single stack which doesn't always have the knowledge of which
> driver version is running is guest can utilize it. Otherwise 1.x also
> end up doing mediation when guest driver =3D 1.x and device =3D transitio=
nal
> PCI VF.

I don't see how this can be solved in your proposal.

>
> so (1) and (2) both are equivalent, one is more flexible, if you know
> more valid cases where BAR0 as MMIO can work as_is, such option is open.

As said in previous threads, this has been used by several vendors for year=
s.

E.g I have a handy transitional hardware virtio device that has:

        Region 0: Memory at f5ff0000 (64-bit, prefetchable) [size=3D8K]
        Region 2: Memory at f5fe0000 (64-bit, prefetchable) [size=3D4K]
        Region 4: Memory at f5800000 (64-bit, prefetchable) [size=3D4M]

And:

        Capabilities: [64] Vendor Specific Information: VirtIO: CommonCfg
                BAR=3D0 offset=3D00000888 size=3D00000078
        Capabilities: [74] Vendor Specific Information: VirtIO: Notify
                BAR=3D0 offset=3D00001800 size=3D00000020 multiplier=3D0000=
0000
        Capabilities: [88] Vendor Specific Information: VirtIO: ISR
                BAR=3D0 offset=3D00000820 size=3D00000020
        Capabilities: [98] Vendor Specific Information: VirtIO: DeviceCfg
                BAR=3D0 offset=3D00000840 size=3D00000020

>
> We can draft the spec that MMIO BAR SHOULD be exposes in BAR0.
>

Thanks


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

