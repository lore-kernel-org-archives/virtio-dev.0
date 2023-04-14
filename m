Return-Path: <virtio-dev-return-12220-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB69DC77B71
	for <virtio-dev@archiver.kernel.org>; Fri, 14 Apr 2023 03:08:58 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 08CF72A834
	for <virtio-dev@archiver.kernel.org>; Fri, 14 Apr 2023 03:08:58 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 00542986618
	for <virtio-dev@archiver.kernel.org>; Fri, 14 Apr 2023 03:08:58 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E7AD6983C98; Fri, 14 Apr 2023 03:08:57 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D79E9986601
	for <virtio-dev@lists.oasis-open.org>; Fri, 14 Apr 2023 03:08:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: cWPv2b2GP1ulAJuTeOupkw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681441732; x=1684033732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=InlTNJYWfyNaL3nO8HILkD4J7UYTzg5KfywzLe6KV4s=;
        b=brVhSUYe/knVZzd31sFdzf1jCPCJ5E5coq2tRrEfOgyhK07Dev2lPUJXjLzZzf4wWz
         MjJFHFOKA1QDkBEDVJ5XIDcWHTW/qyo9hIqtCZ5qHNC9Dx4zNmqjYYf/F7a5iiyJasnN
         9Et0n4S3Jxs0mZYDYJHx/67P3exEt1lstmXrrnTLj147T6cJHKEVh+Y2oatPl+uom1vt
         exQFzSkosaJPv7ufyB0FdZ/OUOFU8PezskuHtvNT6fSP7AEhOuUk6Y7ky0JSTnZpJtW2
         xGM/ykQwfwXwSpS6TVnj6Lvo48O5N2igaaq3lPCy0huHzzBaA2pYXz7UShc32UY67+T5
         d/iA==
X-Gm-Message-State: AAQBX9fxcl6b63SWw2YG6oRmrThkuQaWhY+NZRvbkr0IXpHo3YuSDxbj
	Ucdq3zP0TiAEeZX3Nglzi3NOpJTRJfb/QG3Dvw8DTqmRrUmaIVtSa94uNB8BMRe76q/FUwcVxUM
	p08y1qStdXPem4zntQ8D97803ocJfSgvAYEzUR/byyUj0
X-Received: by 2002:a05:6870:3489:b0:187:7f2e:98d6 with SMTP id n9-20020a056870348900b001877f2e98d6mr1897563oah.9.1681441732422;
        Thu, 13 Apr 2023 20:08:52 -0700 (PDT)
X-Google-Smtp-Source: AKy350bhEJ5aDMn+YXE0CTjcg9iCAujE550uMPapDViTNmpu+HshMKRZ515Ox4ruq2hIryP0r/w41BsNSbRlkQMsaTQ=
X-Received: by 2002:a05:6870:3489:b0:187:7f2e:98d6 with SMTP id
 n9-20020a056870348900b001877f2e98d6mr1897558oah.9.1681441732177; Thu, 13 Apr
 2023 20:08:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230410020906-mutt-send-email-mst@kernel.org>
 <CACGkMEufWUXHKahg3GLOKfV5aptbiek_DKwy+7rCfMya2GPaTQ@mail.gmail.com>
 <20230412000802-mutt-send-email-mst@kernel.org> <CACGkMEshNydwBD=Q0JW-SDY6xyiJ4uVrLn+pxbUrinycBKwsrw@mail.gmail.com>
 <PH0PR12MB548118F57BB4B4A4F8DC9D7ADC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEvYsz1fSPG+fKpRaZ05Ut7ffKwvMPvR8xbRBsXA_6vGQw@mail.gmail.com>
 <PH0PR12MB548137D7A25C99EAA42B4D12DC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEshW82qztmGw8YJWJ8=QCoRd6cPxQ+ySazxsO_o+U6c4Q@mail.gmail.com>
 <PH0PR12MB548147CF939CB9C2A0586310DC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEu2B_GogDR9HUwB7mT8fkGh+Q_buPLz4nhwhK7h9k6BQQ@mail.gmail.com>
 <PH0PR12MB5481F0CF5A555A6BB2CE856CDC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEuNOYOxvcSzrs0UFEyk+xOkGUpOfhK8rOy_Mebz5b5wdg@mail.gmail.com>
 <a74d3107-d38c-df15-e2ff-f848635f24bd@nvidia.com> <CACGkMEt+bGN7UYEopXPj0+deAnYm1VUNp05VvGHcJnkd8LzbGg@mail.gmail.com>
 <f9f01f9d-f6ec-0daa-a11d-c75589dcbe6c@nvidia.com>
In-Reply-To: <f9f01f9d-f6ec-0daa-a11d-c75589dcbe6c@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 14 Apr 2023 11:08:40 +0800
Message-ID: <CACGkMEskPJgNrBQV10ieSaKCg_kBbi2E0z1BEbdyiiaDdD1zJA@mail.gmail.com>
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

On Fri, Apr 14, 2023 at 1:24=E2=80=AFAM Parav Pandit <parav@nvidia.com> wro=
te:
>
>
>
> On 4/13/2023 1:14 AM, Jason Wang wrote:
>
> >> For LM BAR length and number should be same between two PCI VFs. But i=
ts
> >> orthogonal to this point. Such checks will be done anyway.
> >
> > Quoted the wrong sections, I think it should be:
> >
> > "
> > length MAY include padding, or fields unused by the driver, or future
> > extensions. Note: For example, a future device might present a large
> > structure size of several MBytes. As current devices never utilize
> > structures larger than 4KBytes in size, driver MAY limit the mapped
> > structure size to e.g. 4KBytes (thus ignoring parts of structure after
> > the first 4KBytes) to allow forward compatibility with such devices
> > without loss of functionality and without wasting resources.
> > "
> yes. This is the one.
>
> > If it's a transitional device but not placed at BAR0, it might have
> > side effects for Linux drivers which assumes BAR0 for legacy.
> >
> True. Transitional can be at BAR0.
>
> > I don't see how easy it could be a non transitional device:
> >
> > "
> > Devices or drivers with no legacy compatibility are referred to as
> > non-transitional devices and drivers, respectively.
> > "
> Michael has suggested rewording of the text.
> It is anyway new text so lets park it aside for now.
> It is mostly tweaking the text.
>
> >
> >> device can expose this optional capability and its attached MMIO regio=
n.
> >>
> >> Spec changes are similar to #2.
> >>> - non trivial spec changes which ends up of the tricky cases that
> >>> tries to workaround legacy to fit for a hardware implementation
> >>> - work only for the case of virtualization with the help of
> >>> meditation, can't work for bare metal
> >> For bare-metal PFs usually thin hypervisors are used that does very
> >> minimal setup. But I agree that bare-metal is relatively less importan=
t.
> >
> > This is not what I understand. I know several vendors that are using
> > virtio devices for bare metal.
> >
> I was saying the case for legacy bare metal is less of a problem because
> PCIe does not limit functionality, perf is still limited due to IOBAR.
>
> >>
> >>> - only work for some specific archs without SVQ
> >>>
> >> That is the legacy limitation that we don't worry about.
> >>
> >>> 2) allow BAR0 to be MMIO for transitional device
> >>>
> >>> Pros:
> >>> - very minor change for the spec
> >> Spec changes wise they are similar to #1.
> >
> > This is different since the changes for this are trivial.
> >
> >>> - work for virtualization (and it work even without dedicated
> >>> mediation for some setups)
> >> I am not aware where can it work without mediation. Do you know any
> >> specific kernel version where it actually works?
> >
> > E.g current Linux driver did:
> >
> > rc =3D pci_request_region(pci_dev, 0, "virtio-pci-legacy");
> >
> > It doesn't differ from I/O with memory. It means if you had a
> > "transitional" device with legacy MMIO BAR0, it just works.
> >
>
> Thanks to the abstract PCI API in Linux.

And this (legacy MMIO bar) has been supported by DPDK as well for a while.

>
> >>> - work for bare metal for some setups (without mediation)
> >>> Cons:
> >>> - only work for some specific archs without SVQ
> >>> - BAR0 is required
> >>>
> >> Both are not limitation as they are mainly coming from the legacy side
> >> of things.
> >>
> >>> 3) modern device mediation for legacy
> >>>
> >>> Pros:
> >>> - no changes in the spec
> >>> Cons:
> >>> - require mediation layer in order to work in bare metal
> >>> - require datapath mediation like SVQ to work for virtualization
> >>>
> >> Spec change is still require for net and blk because modern device do
> >> not understand legacy, even with mediation layer.
> >
> > That's fine and easy since we work on top of modern devices.
> >
> >> FEATURE_1, RW cap via CVQ which is not really owned by the hypervisor.
> >
> > Hypervisors can trap if they wish.
> >
> Trapping non legacy accessing for 1.x doesn't make sense.

Actually not, I think I've mentioned the reason for several times:

It's a must for ABI and migration compatibility:

1) The offset is not necessarily a page boundary
2) The length is not necessarily times of a PAGE_SIZE
3) PAGE_SIZE varies among different archs
4) Two vendors may have two different layout for the structure

Thanks


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

