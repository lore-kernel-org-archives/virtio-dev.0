Return-Path: <virtio-dev-return-12164-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79E98C77B6E
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 04:15:20 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id BFE812AC4A
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 04:15:18 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 773D39865B3
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 04:15:18 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 5BB72986675; Wed, 12 Apr 2023 04:15:18 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3520E98662E
	for <virtio-dev@lists.oasis-open.org>; Wed, 12 Apr 2023 04:15:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 97uowBWaPOOw0LiuSepszA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681272914;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B+xPs/XOXWDUMMCaMwuKjAkMnFA2hbMq9FJfAG1g8uk=;
        b=hmOQXkvA92jx+ZVg7gRa74MOrB9efXdmV3IVUHRnW9XVxWr5m/jADdt02+eoAPisDI
         TnEOUVCEXRctGqQ7kvFWY9d5W756u0PspJufLZaqMLEhr1WAZDMlDaQg6jbqVetD2OQW
         arD0Iic4tRpuppps9LyHKOlkeFFtKlcT2hxyvnsv206O7ejNl2hcC4SyDx1S5aTT4fWQ
         pxibKr4VA4FaIzMv0kXKfkUdLaOlM+Fiu+fFn3mvwB5wD1rJA/67v+4m/xMRhqq/1+8Z
         TlmctRMFT8PYqDaf+//Vey049ASxrVGiW1Rx6qRqYTMoqGeeC9wBSkX2EyMOX5H9hAZf
         cmbg==
X-Gm-Message-State: AAQBX9fMV36dyQmFnOAmDr0F9HuNBwBXC+0hugJGKgp/pD3Xyc3xXpcq
	EPFRWFbGQI4sOcyr6suxRwq+0egZRWRulmwN5Ly44dSvjg3PDw28ddXJDiDDjhrA7tiqRpPSWa7
	jKmAjLlY/QjnzEZUvmWV3cMi8x8Wy
X-Received: by 2002:adf:ed90:0:b0:2f4:a60f:3cd8 with SMTP id c16-20020adfed90000000b002f4a60f3cd8mr183973wro.49.1681272914456;
        Tue, 11 Apr 2023 21:15:14 -0700 (PDT)
X-Google-Smtp-Source: AKy350Y4FqYSqItWi3cAdprdGg8dNAJQSxliFxJc4hTLHTXpAk8p1D4eQxkwTBwYg76Y3JyE05i6hw==
X-Received: by 2002:adf:ed90:0:b0:2f4:a60f:3cd8 with SMTP id c16-20020adfed90000000b002f4a60f3cd8mr183948wro.49.1681272914073;
        Tue, 11 Apr 2023 21:15:14 -0700 (PDT)
Date: Wed, 12 Apr 2023 00:15:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>, virtio-dev@lists.oasis-open.org,
	cohuck@redhat.com, virtio-comment@lists.oasis-open.org,
	shahafs@nvidia.com, Satananda Burla <sburla@marvell.com>,
	Maxime Coquelin <maxime.coquelin@redhat.com>,
	Yan Vugenfirer <yan@daynix.com>
Message-ID: <20230412000802-mutt-send-email-mst@kernel.org>
References: <20230410020906-mutt-send-email-mst@kernel.org>
 <CACGkMEtiROwuB+ECJqd13qdpMJSTMoDOzi1u_i85==42C0XSXw@mail.gmail.com>
 <20230410023715-mutt-send-email-mst@kernel.org>
 <CACGkMEs+E_OarQxP3NmLk3iSi7U0WgAn-m3b4eX7ULu1+v=sOw@mail.gmail.com>
 <20230410060417-mutt-send-email-mst@kernel.org>
 <CACGkMEuc47PdmQdC67Nz4AvX_+jy+XBgCkwZ1BHmM8VGb9gywA@mail.gmail.com>
 <20230411030056-mutt-send-email-mst@kernel.org>
 <CACGkMEt2QAfhCgpYjSRNzf3n4W_HJLrMfE9JHzocR_gPH_Zrtg@mail.gmail.com>
 <20230411063945-mutt-send-email-mst@kernel.org>
 <CACGkMEufWUXHKahg3GLOKfV5aptbiek_DKwy+7rCfMya2GPaTQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEufWUXHKahg3GLOKfV5aptbiek_DKwy+7rCfMya2GPaTQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH 09/11] transport-pci: Describe PCI
 MMR dev config registers

On Wed, Apr 12, 2023 at 11:58:39AM +0800, Jason Wang wrote:
> On Tue, Apr 11, 2023 at 6:42 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Apr 11, 2023 at 05:01:59PM +0800, Jason Wang wrote:
> > > On Tue, Apr 11, 2023 at 3:04 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Tue, Apr 11, 2023 at 10:13:40AM +0800, Jason Wang wrote:
> > > > > On Mon, Apr 10, 2023 at 6:06 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > >
> > > > > > On Mon, Apr 10, 2023 at 03:20:52PM +0800, Jason Wang wrote:
> > > > > > > On Mon, Apr 10, 2023 at 2:40 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > > >
> > > > > > > > On Mon, Apr 10, 2023 at 02:20:16PM +0800, Jason Wang wrote:
> > > > > > > > > On Mon, Apr 10, 2023 at 2:15 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Mon, Apr 10, 2023 at 09:33:32AM +0800, Jason Wang wrote:
> > > > > > > > > > > This is fine for vDPA but not for virtio if the design can only work
> > > > > > > > > > > for some specific setups (OSes/archs).
> > > > > > > > > > >
> > > > > > > > > > > Thanks
> > > > > > > > > >
> > > > > > > > > > Well virtio legacy has a long history of documenting existing hacks :)
> > > > > > > > >
> > > > > > > > > Exactly, so the legacy behaviour is not (or can't be) defined by the
> > > > > > > > > spec but the codes.
> > > > > > > >
> > > > > > > > I mean driver behaviour derives from the code but we do document it in
> > > > > > > > the spec to help people build devices.
> > > > > > > >
> > > > > > > >
> > > > > > > > > > But yes, VIRTIO_F_ORDER_PLATFORM has to be documented.
> > > > > > > > > > And we have to decide what to do about ACCESS_PLATFORM since
> > > > > > > > > > there's a security problem if device allows not acking it.
> > > > > > > > > > Two options:
> > > > > > > > > > - relax the rules a bit and say device will assume ACCESS_PLATFORM
> > > > > > > > > >   is acked anyway
> > > > > > > > >
> > > > > > > > > This will break legacy drivers which assume physical addresses.
> > > > > > > >
> > > > > > > > not that they are not already broken.
> > > > > > >
> > > > > > > I may miss something, the whole point is to allow legacy drivers to
> > > > > > > run otherwise a modern device is sufficient?
> > > > > >
> > > > > > yes and if legacy drivers don't work in a given setup then we
> > > > > > should not worry.
> > > > > >
> > > > > > > >
> > > > > > > > > > - a new flag that is insecure (so useful for sec but useless for dpdk) but optional
> > > > > > > > >
> > > > > > > > > This looks like a new "hack" for the legacy hacks.
> > > > > > > >
> > > > > > > > it's not just for legacy.
> > > > > > >
> > > > > > > We have the ACCESS_PLATFORM feature bit, what is the useage for this new flag?
> > > > > >
> > > > > >
> > > > > > ACCESS_PLATFORM is also a security boundary. so devices must fail
> > > > > > negotiation if it's not there. this new one won't be.
> > > > > >
> > > > > >
> > > > > > > >
> > > > > > > > > And what about ORDER_PLATFORM, I don't think we can modify legacy drivers...
> > > > > > > > >
> > > > > > > > > Thanks
> > > > > > > >
> > > > > > > > You play some tricks with shadow VQ I guess.
> > > > > > >
> > > > > > > Do we really want to add a new feature in the virtio spec that can
> > > > > > > only work with the datapath mediation?
> > > > > > >
> > > > > > > Thanks
> > > > > >
> > > > > > As long as a feature is useful and can't be supported otherwise
> > > > > > we are out of options.
> > > > >
> > > > > Probably not? Is it as simple as relaxing this:
> > > > >
> > > > > "Transitional devices MUST expose the Legacy Interface in I/O space in BAR0."
> > > > >
> > > > > To allow memory space.
> > > > >
> > > > > This works for both software and hardware devices (I had a handy
> > > > > hardware that supports legacy virtio drivers in this way).
> > > > >
> > > > > Thanks
> > > >
> > > > Yes it is certainly simpler.
> > > >
> > > > Question: what happens if you try to run existing windows guests or dpdk
> > > > on these? Do they crash horribly or exit gracefully?
> > >
> > > Haven't tried DPDK and windows. But I remember DPDK supported legacy
> > > MMIO bars for a while.
> > >
> > > Adding Maxime and Yan for comments here.
> > >
> > > >
> > > > The point of the capability is to allow using modern device ID so such
> > > > guests will not even try to bind.
> > >
> > > It means a mediation layer is required to use. Then it's not an issue
> > > for this simple relaxing any more?
> > >
> > > An advantage of such relaxing is that, for the legacy drivers like an
> > > ancient Linux version that can already do MMIO access to legacy BAR it
> > > can work without any mediation.
> >
> > Yes. But the capability approach does not prevent that -
> > just use a transitional ID.
> > The disadvantage of a transitional ID is some old drivers might crash, or fail
> > to work in other ways.
> 
> If the driver is wrote correctly it should fail gracefully if it can't
> request legacy I/O regions.

it's not just regions. it's things like iommu, ordering, endian-ness...
we all know legacy is a mess.

> > Using a modern ID with a capability
> > prevents old drivers from attaching.
> 
> Just to make sure we are at the same page.
> 
> It looks like the motivation for this series is allow hypervisor to
> mediate between legacy MMIO BAR and legacy driver. This end ups with a
> design that only work for a specific use case (virtualization) and a
> specific setups (e.g using Linux as a hypervisor). By definition, it's
> not a transitional device.

It can be a transitional or non-transitional device.

> What's more important, if it is only used
> for virtualization, legacy MMIO bar is not a must. We can present a
> legacy device on top of modern device by using necessary mediation
> technologies as discussed.

You may call it a bug, i call it a feature. I am not really
excited about all the bugs we'll see reported because
people will try to use legacy guests on bare metal virtio.
Can we just not go there please or at least give people
an option not to go there?

> By relaxing to use MMIO at BAR0, we had a much broad use cases. By
> definition, it's a transitional device. It's useful for both bare
> metal and virtualization. We don't worry about the buggy drivers or at
> least fixing (I meant fail on no I/O bar) those drivers is not hard.
>
> > Using a capability the system
> > designed is in control and can decide which drivers to use.
> 
> Do we allow a virtio device only with this capability? If yes, this
> seems can mislead vendors. If not, we have already had modern
> interfaces so I don't see value to add that in the current Linux
> drivers. The only possible use case is the doing mediation in the
> hypervisor like Qemu not the driver.

exactly.

> >
> >
> >
> > > At least, if ID can help, it can be used with this as well.
> > >
> > > Thanks
> >
> >
> > I don't know what that means.
> 
> I mean having dedicated ID for this relaxing (though I don't see too
> much value).
> 
> Thanks

me neither.

> >
> > >
> > >
> > > >
> > > >
> > > > > > Keeping field practice things out of the
> > > > > > spec helps no one.
> > > > > >
> > > > > > > >
> > > > > > > > --
> > > > > > > > MST
> > > > > > > >
> > > > > >
> > > >
> >


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

