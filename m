Return-Path: <virtio-dev-return-12615-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0B8FC77B7C
	for <virtio-dev@archiver.kernel.org>; Tue,  9 May 2023 03:45:26 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 19BCC29FC9
	for <virtio-dev@archiver.kernel.org>; Tue,  9 May 2023 03:45:26 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0686798652B
	for <virtio-dev@archiver.kernel.org>; Tue,  9 May 2023 03:45:26 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id EF06F9864BD; Tue,  9 May 2023 03:45:25 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DB1969864EE
	for <virtio-dev@lists.oasis-open.org>; Tue,  9 May 2023 03:45:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 3vZi_1RaPBOPma1ccftF-Q-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683603882; x=1686195882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b/tgXildGYPyqkBdfkiMWxj+Tpw7GuTTkN7HnD3sUpQ=;
        b=PXcvOelJrV8PJfQGa9eAiukHXVc2KO978yN/eQVwSAmRFDp9hmpz1u6P7OG185tiCB
         lwXU0iGv96MSX4HdvRHzQTZheAKFFqti9JMB59LBjHI69tCNPLdegsVcQ12G2a6WxNey
         6BHJVaT2hBgpIBgkVRtqX1hi85SemCojaq72v5xy7yoNCk3BDMKNoP9w8qm9WSHvGLr9
         QPkzhJf+fOPKul4iwKD6LrPtHt5GAXopZX5ZCWlE1aU/PCYKujkZ1tBrk14QXwP90zSj
         pQZRVAMzsL7hmuzTv70pqZUfSTOONjCxYCL0ZFhRLMF8Pfpo5UU4ZGOop/+TjnR2UGM5
         Bz1g==
X-Gm-Message-State: AC+VfDyqa4zDYPVdUw2tkIMedwgnGp+I0E0HyCaV8WsqMT8hbsAOyLwQ
	s4Ck4yuGXHv5gcg6F2Y6/0HTDUo3nZUiY9gR7n99aKFS/n7nD0pNRDxEDliZlw+v0cuv3GhDVgv
	dtHpfhI6HLNVnfRLF8J2FbNrnTuWmABCywDvDY6EDM6ID
X-Received: by 2002:a19:f602:0:b0:4f1:8dfa:aec9 with SMTP id x2-20020a19f602000000b004f18dfaaec9mr243399lfe.69.1683603881697;
        Mon, 08 May 2023 20:44:41 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6FneR99vJ5sEagOZTErpPVYVJEuml+WOgdMhtj6m2RMSfwJyqFtK0Itu8d9OcbskpYddG2R/530JOzdpZefgs=
X-Received: by 2002:a19:f602:0:b0:4f1:8dfa:aec9 with SMTP id
 x2-20020a19f602000000b004f18dfaaec9mr243390lfe.69.1683603881289; Mon, 08 May
 2023 20:44:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230506000135.628899-1-parav@nvidia.com> <CACGkMEt_2B68a+BZ4-vfeDf_eYj5ZhxrDNd6dxuiF85qr0yN2g@mail.gmail.com>
 <20230507093959-mutt-send-email-mst@kernel.org> <CACGkMEtfMbcu2OPsH6P2tA1aHh2FKygv=xkJ-e1XQzb62nE1vQ@mail.gmail.com>
 <b33fe999-8491-30b4-5021-589a2fe87398@nvidia.com>
In-Reply-To: <b33fe999-8491-30b4-5021-589a2fe87398@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 9 May 2023 11:44:30 +0800
Message-ID: <CACGkMEsSJVG8mzuo3BH1xQzz5TyNbO+o3GcYwoXchcYVOczTTg@mail.gmail.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtio-dev@lists.oasis-open.org, cohuck@redhat.com, 
	david.edmondson@oracle.com, sburla@marvell.com, yishaih@nvidia.com, 
	maorg@nvidia.com, virtio-comment@lists.oasis-open.org, shahafs@nvidia.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [PATCH v2 0/2] transport-pci: Introduce legacy registers access
 using AQ

On Tue, May 9, 2023 at 1:08=E2=80=AFAM Parav Pandit <parav@nvidia.com> wrot=
e:
>
>
>
> On 5/7/2023 10:23 PM, Jason Wang wrote:
> > On Sun, May 7, 2023 at 9:44=E2=80=AFPM Michael S. Tsirkin <mst@redhat.c=
om> wrote:
> >>
> >> On Sat, May 06, 2023 at 10:31:30AM +0800, Jason Wang wrote:
> >>> On Sat, May 6, 2023 at 8:02=E2=80=AFAM Parav Pandit <parav@nvidia.com=
> wrote:
> >>>>
> >>>> This short series introduces legacy registers access commands for th=
e owner
> >>>> group member PCI PF to access the legacy registers of the member VFs=
.
> >>>>
> >>>> If in future any SIOV devices to support legacy registers, they
> >>>> can be easily supported using same commands by using the group
> >>>> member identifiers of the future SIOV devices.
> >>>>
> >>>> More details as overview, motivation, use case are further described
> >>>> below.
> >>>>
> >>>> Patch summary:
> >>>> --------------
> >>>> patch-1 adds administrative virtuqueue commands
> >>>> patch-2 adds its conformance section
> >>>>
> >>>> This short series is on top of latest work [1] from Michael.
> >>>> It uses the newly introduced administrative virtqueue facility with =
3 new
> >>>> commands which uses the existing virtio_admin_cmd.
> >>>>
> >>>> [1] https://lists.oasis-open.org/archives/virtio-comment/202305/msg0=
0112.html
> >>>>
> >>>> Usecase:
> >>>> --------
> >>>> 1. A hypervisor/system needs to provide transitional
> >>>>     virtio devices to the guest VM at scale of thousands,
> >>>>     typically, one to eight devices per VM.
> >>>>
> >>>> 2. A hypervisor/system needs to provide such devices using a
> >>>>     vendor agnostic driver in the hypervisor system.
> >>>>
> >>>> 3. A hypervisor system prefers to have single stack regardless of
> >>>>     virtio device type (net/blk) and be future compatible with a
> >>>>     single vfio stack using SR-IOV or other scalable device
> >>>>     virtualization technology to map PCI devices to the guest VM.
> >>>>     (as transitional or otherwise)
> >>>>
> >>>> Motivation/Background:
> >>>> ----------------------
> >>>> The existing virtio transitional PCI device is missing support for
> >>>> PCI SR-IOV based devices. Currently it does not work beyond
> >>>> PCI PF, or as software emulated device in reality. Currently it
> >>>> has below cited system level limitations:
> >>>>
> >>>> [a] PCIe spec citation:
> >>>> VFs do not support I/O Space and thus VF BARs shall not indicate I/O=
 Space.
> >>>>
> >>>> [b] cpu arch citiation:
> >>>> Intel 64 and IA-32 Architectures Software Developer=E2=80=99s Manual=
:
> >>>> The processor=E2=80=99s I/O address space is separate and distinct f=
rom
> >>>> the physical-memory address space. The I/O address space consists
> >>>> of 64K individually addressable 8-bit I/O ports, numbered 0 through =
FFFFH.
> >>>>
> >>>> [c] PCIe spec citation:
> >>>> If a bridge implements an I/O address range,...I/O address range wil=
l be
> >>>> aligned to a 4 KB boundary.
> >>>>
> >>>> Overview:
> >>>> ---------
> >>>> Above usecase requirements can be solved by PCI PF group owner acces=
sing
> >>>> its group member PCI VFs legacy registers using an admin virtqueue o=
f
> >>>> the group owner PCI PF.
> >>>>
> >>>> Two new admin virtqueue commands are added which read/write PCI VF
> >>>> registers.
> >>>>
> >>>> The third command suggested by Jason queries the VF device's driver
> >>>> notification region.
> >>>>
> >>>> Software usage example:
> >>>> -----------------------
> >>>> One way to use and map to the guest VM is by using vfio driver
> >>>> framework in Linux kernel.
> >>>>
> >>>>                  +----------------------+
> >>>>                  |pci_dev_id =3D 0x100X   |
> >>>> +---------------|pci_rev_id =3D 0x0      |-----+
> >>>> |vfio device    |BAR0 =3D I/O region     |     |
> >>>> |               |Other attributes      |     |
> >>>> |               +----------------------+     |
> >>>> |                                            |
> >>>> +   +--------------+     +-----------------+ |
> >>>> |   |I/O BAR to AQ |     | Other vfio      | |
> >>>> |   |rd/wr mapper  |     | functionalities | |
> >>>> |   +--------------+     +-----------------+ |
> >>>> |                                            |
> >>>> +------+-------------------------+-----------+
> >>>>         |                         |
> >>>>    +----+------------+       +----+------------+
> >>>>    | +-----+         |       | PCI VF device A |
> >>>>    | | AQ  |-------------+---->+-------------+ |
> >>>>    | +-----+         |   |   | | legacy regs | |
> >>>>    | PCI PF device   |   |   | +-------------+ |
> >>>>    +-----------------+   |   +-----------------+
> >>>>                          |
> >>>>                          |   +----+------------+
> >>>>                          |   | PCI VF device N |
> >>>>                          +---->+-------------+ |
> >>>>                              | | legacy regs | |
> >>>>                              | +-------------+ |
> >>>>                              +-----------------+
> >>>>
> >>>> 2. Virtio pci driver to bind to the listed device id and
> >>>>     use it as native device in the host.
> >>>>
> >>>> 3. Use it in a light weight hypervisor to run bare-metal OS.
> >>>>
> >>>> Please review.
> >>>>
> >>>> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/167
> >>>> Signed-off-by: Parav Pandit <parav@nvidia.com>
> >>>>
> >>>> ---
> >>>> changelog:
> >>>> v1->v2:
> >>>> - addressed comments from Michael
> >>>> - added theory of operation
> >>>> - grammar corrections
> >>>> - removed group fields description from individual commands as
> >>>>    it is already present in generic section
> >>>> - added endianness normative for legacy device registers region
> >>>> - renamed the file to drop vf and add legacy prefix
> >>>> - added overview in commit log
> >>>> - renamed subsection to reflect command
> >>>
> >>> So as replied in V1, I think it's not a good idea to invent commands
> >>> for a partial transport just for legacy devices. It's better either:
> >>>
> >>> 1) rebase or collaborate this work on top of the transport virtqueue
> >>>
> >>> or
> >>>
> >>> 2) having a PCI over admin virtqueue transport, since this proposal
> >>> has already had BAR access, we can add config space access then it is
> >>> self-contained so we don't need to go through every corner case like
> >>> inventing dedicated commands to accessing some function that is
> >>> duplicated with capabilities. It will become yet another transport an=
d
> >>> legacy support is just a good byproduct.
> >>>
> >>> Thanks
> >>
> >>
> >> I thought so too originally. Unfortunately I now think that no, legacy=
 is not
> >> going to be a byproduct of transport virtqueue for modern -
> >> it is different enough that it needs dedicated commands.
> >
> > If you mean the transport virtqueue, I think some dedicated commands
> > for legacy are needed. Then it would be a transport that supports
> > transitional devices. It would be much better than having commands for
> > a partial transport like this patch did.
> >
> >> Consider simplest case, multibyte fields. Legacy needs multibyte write=
,
> >> modern does not even need multibyte read.
> >
> > I'm not sure I will get here, since we can't expose admin vq to
> > guests, it means we need some software mediation. So if we just
> > implement what PCI allows us, then everything would be fine (even if
> > some method is not used).
> >
> > Thanks
>
> The fundamental reason for not accessing the 1.x VF and SIOV device
> registers, config space, feature bits through PF is: it requires PF
> device mediation. VF and SIOV devices are first class citizen in PCIe
> spec and deserve direct interaction with the device.

Unless I miss something obvious, SIOV requires mediation (or
composition) for sure. Otherwise you break the compatibility.

>
> Hence, the transport we built is to consider this in mind for the coming
> future.

For transport virtqueue, it's not specific to PCI. It could be used in
a much broader use case.

> So if each VF has its own configq, or cmdq, it totally make sense to me
> which is bootstrap interface to transport existing config space interface=
.
> The problem is: it is not backward compatible;
> Hence a device has no way of when to support both or only new configq.

Providing compatibility in software is much more simpler than
inventing new hardware interfaces. Isn't it? (e.g if we want to
provide compatibility for VF on a SIOV device). And inventing a new
hardware interface for compatibility might not always work, it may
break the advantages of the new hardware (like scalability).

>
> So eve growing these fields and optionally placement on configq doesn't
> really help and device builder to build it efficiently (without much
> predictability).

Config queue is not the only choice, we have a lot of other choices
(for example PASID may help to reduce the on-chip resources).

>
> Instead of we say, that what exists today in config space stays in
> config space, anything additional on new q, than its deterministic
> behavior to size up the scale.

Just to be clear, if we have PCI over adminq, VF's config space could
be the minimal one for PCI spec complaint. The real config space is
accessed via the admin virtqueue.

>
> For example, a PCI device who wants to support 100 VFs, can easily size
> its memory to 30 bytes * 100 reserved for supporting config space.

Those capabilities (30 bytes) can be accessed via admin virtqueue. So
we don't need to place them in the config space.

> And new 40 bytes * 100 fields doesn't have to be in the resident memory.
>
> If we have optional configq/cmdq for transport, than 30*100 bytes are
> used (reserved) as 3000/(30+40) =3D 42 VFs.
>
> Only if some VFs use configq, more VFs can be deployed.

I don't understand here.

> It is hard to
> build scale this way. Therefore suggestion is to place new attributes on
> new config/cmd/transport q, and old to stay as-is.

Just to be sure we're on the same page. The proposal of both you and
mine are based on the adminq for PF not VF. The reason is obvious:
adminq per VF won't work without PASID, since it would have security
issues.

>
> The legacy infra is unfortunately is for the exception path due to the
> history; hence they are different commands as Michael suggests.
>

Thanks


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

