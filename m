Return-Path: <virtio-dev-return-13742-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81527CA0ED1
	for <virtio-dev@archiver.kernel.org>; Wed, 13 Sep 2023 04:44:18 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id E9B9470FEF
	for <virtio-dev@archiver.kernel.org>; Wed, 13 Sep 2023 04:44:17 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DF85D986659
	for <virtio-dev@archiver.kernel.org>; Wed, 13 Sep 2023 04:44:17 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id D3D19986632; Wed, 13 Sep 2023 04:44:17 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C190598663F
	for <virtio-dev@lists.oasis-open.org>; Wed, 13 Sep 2023 04:44:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 7_yy7tMkMEiiZ_qV6gbuVg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694580253; x=1695185053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H0Nw3kMHp38Hhs4AbgkkLYQSiyDKfYnVMfa/z+2SV0k=;
        b=Swha0o+ifUHS6p9UyPZlhRObbsutfKcUSK6YwjbxY35iUm2R/TNJAaWTcAK5qWGBut
         nMi/2yRe/GCWVjR++PoaSU7B3gWtQefHX7xlTDlQhWFqYWo6qDhVD1i8wO9YyweqvLDX
         68u5v2hkMWWgwVDqNW1diuHpLHczKaUXqW8z7iwucuaHJ44motxJ+aumIVGCJUvCooO/
         z9FsKvxGCjAm1IKjPH4trO/AzJ0F6EHP6pQCMC9sQRN7J7anYkuvMlmEQBM5eN3G3uEi
         Ky4R2ljdzTeRQKFElGLKdFRPw9l8BjqeX+7O2zkvuhLt04Jnye3+exgfCZDyXsZ8RLH5
         NjCg==
X-Gm-Message-State: AOJu0YzHTGioQz2En0mxOLfZIgU+hYvWLcrAEqfAfLFrEdqgDXHQCw6H
	UEzZseTPrYcwoDraEijCjNcFvP43sPMROHq6lFbBROq8uTSNjWeHjX0oEm1VymPjCy27arGQDfN
	gOoSGilzQ7apXJcILPQeRyBibyTC70mEARIdSRM+BXwJv
X-Received: by 2002:a05:6512:ac2:b0:4ff:9aaa:6e3e with SMTP id n2-20020a0565120ac200b004ff9aaa6e3emr1359706lfu.41.1694580252984;
        Tue, 12 Sep 2023 21:44:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTQWDngs0laJl7lTMttGGwiLYF3YZ7R21IrX0mJSTxGyo7x6d76KNtU6soPtVYxvOPXSbHpjIDqAFD2EGMeRg=
X-Received: by 2002:a05:6512:ac2:b0:4ff:9aaa:6e3e with SMTP id
 n2-20020a0565120ac200b004ff9aaa6e3emr1359699lfu.41.1694580252806; Tue, 12 Sep
 2023 21:44:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230906081637.32185-1-lingshan.zhu@intel.com>
 <20230906081637.32185-6-lingshan.zhu@intel.com> <20230906043016-mutt-send-email-mst@kernel.org>
 <CACGkMEu4R_nUFmpoNesmjJ-PtoE5brpWh8NLruWhEWycm2K4yg@mail.gmail.com>
 <PH0PR12MB5481A50B1B13CE1756B98D0DDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtMmwWGJDYe5BLvLCcetThv-yfPR2QbphNuuh+bp-+ikg@mail.gmail.com>
 <PH0PR12MB5481ED8DC23DC6D42665FB8EDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <eb6c350e-1198-7d83-a553-99c9c8c21edc@intel.com> <PH0PR12MB5481760E00AD18DB8BF91636DCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <ad1dd3a6-7c11-5c6b-b50f-d608ec027dcd@intel.com> <PH0PR12MB54819C4A4220712DCD57AD56DCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <fff7720f-6019-bd87-b14b-c0bf996f3959@intel.com> <PH0PR12MB5481D11A7DF45292103D9290DCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <88b8b14c-88d8-1f76-0e6e-7b5f334171f1@intel.com> <PH0PR12MB5481CBE0CDFF4ACD712F371CDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <2b3e8da1-5cbb-f990-0c1d-c0e894a73486@intel.com> <PH0PR12MB5481E8114A659954251F17DCDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtAe3j+A=gNEOJiZF8rcJnT-zw7Xg67LLM92FZCm0XqyQ@mail.gmail.com> <PH0PR12MB5481B44B636DA997885AABBEDCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB5481B44B636DA997885AABBEDCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 13 Sep 2023 12:44:01 +0800
Message-ID: <CACGkMEtFWZAQ0fKFBJYpRGR_RCNyDZSxXY+22y==PbuZqHzrVA@mail.gmail.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "Zhu, Lingshan" <lingshan.zhu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	"eperezma@redhat.com" <eperezma@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>, 
	"stefanha@redhat.com" <stefanha@redhat.com>, 
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, 
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [virtio-comment] [PATCH 5/5] virtio-pci: implement VIRTIO_F_QUEUE_STATE

On Tue, Sep 12, 2023 at 1:50=E2=80=AFPM Parav Pandit <parav@nvidia.com> wro=
te:
>
>
> One can delicate the work to other VF for purpose of nesting.
>
> One can build infinite level of nesting to not do passthrough, at the end=
 user applications remains slow.

We are talking about nested virtualization but nested emulation. I
won't repeat the definition of virtualization but no matter how much
level of nesting, the hypervisor will try hard to let the application
run natively for most of the time, otherwise it's not the nested
virtualization at all.

Nested virtualization has been supported by all major cloud vendors,
please read the relevant documentation for the performance
implications. Virtio community is not the correct place to debate
whether a nest is useful. We need to make sure the datapath could be
assigned to any nest layers without losing any fundamental facilities
like migration.

> So for such N and M being > 1, one can use software base emulation anyway=
.

No, only the control path is trapped, the datapath is still passthrough.

>
> >
> > And exposing the whole device to the guest drivers will have security
> > implications, your proposal has demonstrated that you need a workaround=
 for
> There is no security implications in passthrough.

How can you prove this or is it even possible for you to prove this?
You expose all device details to guests (especially the transport
specific details), the attack surface is increased in this way.

What's more, a simple passthrough may lose the chance to workaround
hardware erratas and you will finally get back to the trap and
emulation.

>
> > FLR at least.
> It is actually the opposite.
> FLR is supported with the proposal without any workarounds and mediation.

It's an obvious drawback but not an advantage. And it's not a must for
live migration to work. You need to prove the FLR doesn't conflict
with the live migration, and it's not only FLR but also all the other
PCI facilities. one other example is P2P and what's the next? As more
features were added to the PCI spec, you will have endless work in
auditing the possible conflict with the passthrough based live
migration.

>
> >
> > For non standard device we don't have choices other than passthrough, b=
ut for
> > standard devices we have other choices.
>
> Passthrough is basic requirement that we will be fulfilling.

It has several drawbacks that I would not like to repeat. We all know
even for VFIO, it requires a trap instead of a complete passthrough.

> If one wants to do special nesting, may be, there.

Nesting is not special. Go and see how it is supported by major cloud
vendors and you will get the answer. Introducing an interface in
virtio that is hard to be virtualized is even worse than writing a
compiler that can not do bootstrap compilation.

Thanks








> If both commands can converge its good, if not, they are orthogonal requi=
rements.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

