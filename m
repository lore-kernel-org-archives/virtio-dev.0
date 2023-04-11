Return-Path: <virtio-dev-return-12117-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C46B6C76196
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 10:42:53 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 1741B120D46
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 10:42:53 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F421F9863C9
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 10:42:52 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id DDEBD983DFF; Tue, 11 Apr 2023 10:42:52 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C9447986366
	for <virtio-dev@lists.oasis-open.org>; Tue, 11 Apr 2023 10:42:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: JZCu3CH6MiC4RTcFuMpwUA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681209769;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oo3WUn254TmxaoObCuUe1kf6tP03YM482bHx35KIa3E=;
        b=Lx6ev+lImm3C5cFBzDZ68DPIPBy5R7WklIbcVTZcWXvOmuvJolINt7rBfNKs9h2zYl
         OXc6RPL++u57upiXRFZTaID+1ylKyD1xxei9KAkPcDUSmHrPazFUetl2yy4cXRUucVvS
         LAK3N2sImUpX3kEgYi37chqiDV7mAUOjmH+ppc5xOF1Tcf8SJZIJyd9gLC+DZwF3mPec
         zMdUxlePx84opDG2tqJ9L3P2ZwWIJvPIvN6Pgrs1Vi0FiP4sTxZJia3nl9uHjX1Jkvb4
         9G/dclAXA0joxgKRQnhV02kolcBRsJNMfWiU9ymhw+ieDi/i5qcdSVTIkAlpK7R3WATk
         tsAw==
X-Gm-Message-State: AAQBX9eieUj6oLYydfHqsxHxnf7gPPHUKEwC3UuY9mx2JxwBeyUc56PF
	/6Ahmwe+YsIx7H4W2LNnYqRhb3X3qgT4KJt5OLnKLTvPS5VZBQoYa5fXmKh5Ubz7qt+8+khdUTj
	BFh1aGgkcLbA0/VmNUA5L11pcxwZ8
X-Received: by 2002:a7b:c015:0:b0:3e2:589:2512 with SMTP id c21-20020a7bc015000000b003e205892512mr9440181wmb.21.1681209769766;
        Tue, 11 Apr 2023 03:42:49 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZQxZ9wnro0KUsQZw8YvsKFplDhzgSzCiNnO6w3avAdLWheLsUJHZCY5/IZN0VVajVSWVuH2A==
X-Received: by 2002:a7b:c015:0:b0:3e2:589:2512 with SMTP id c21-20020a7bc015000000b003e205892512mr9440169wmb.21.1681209769406;
        Tue, 11 Apr 2023 03:42:49 -0700 (PDT)
Date: Tue, 11 Apr 2023 06:42:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>, virtio-dev@lists.oasis-open.org,
	cohuck@redhat.com, virtio-comment@lists.oasis-open.org,
	shahafs@nvidia.com, Satananda Burla <sburla@marvell.com>,
	Maxime Coquelin <maxime.coquelin@redhat.com>,
	Yan Vugenfirer <yan@daynix.com>
Message-ID: <20230411063945-mutt-send-email-mst@kernel.org>
References: <20230407043841-mutt-send-email-mst@kernel.org>
 <CACGkMEtkOdwixxaRz2Pv9xP75vb13ncboX5XRs8NqFCUsS16aQ@mail.gmail.com>
 <20230410020906-mutt-send-email-mst@kernel.org>
 <CACGkMEtiROwuB+ECJqd13qdpMJSTMoDOzi1u_i85==42C0XSXw@mail.gmail.com>
 <20230410023715-mutt-send-email-mst@kernel.org>
 <CACGkMEs+E_OarQxP3NmLk3iSi7U0WgAn-m3b4eX7ULu1+v=sOw@mail.gmail.com>
 <20230410060417-mutt-send-email-mst@kernel.org>
 <CACGkMEuc47PdmQdC67Nz4AvX_+jy+XBgCkwZ1BHmM8VGb9gywA@mail.gmail.com>
 <20230411030056-mutt-send-email-mst@kernel.org>
 <CACGkMEt2QAfhCgpYjSRNzf3n4W_HJLrMfE9JHzocR_gPH_Zrtg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEt2QAfhCgpYjSRNzf3n4W_HJLrMfE9JHzocR_gPH_Zrtg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH 09/11] transport-pci: Describe PCI
 MMR dev config registers

On Tue, Apr 11, 2023 at 05:01:59PM +0800, Jason Wang wrote:
> On Tue, Apr 11, 2023 at 3:04 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Apr 11, 2023 at 10:13:40AM +0800, Jason Wang wrote:
> > > On Mon, Apr 10, 2023 at 6:06 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Mon, Apr 10, 2023 at 03:20:52PM +0800, Jason Wang wrote:
> > > > > On Mon, Apr 10, 2023 at 2:40 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > >
> > > > > > On Mon, Apr 10, 2023 at 02:20:16PM +0800, Jason Wang wrote:
> > > > > > > On Mon, Apr 10, 2023 at 2:15 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > > >
> > > > > > > > On Mon, Apr 10, 2023 at 09:33:32AM +0800, Jason Wang wrote:
> > > > > > > > > This is fine for vDPA but not for virtio if the design can only work
> > > > > > > > > for some specific setups (OSes/archs).
> > > > > > > > >
> > > > > > > > > Thanks
> > > > > > > >
> > > > > > > > Well virtio legacy has a long history of documenting existing hacks :)
> > > > > > >
> > > > > > > Exactly, so the legacy behaviour is not (or can't be) defined by the
> > > > > > > spec but the codes.
> > > > > >
> > > > > > I mean driver behaviour derives from the code but we do document it in
> > > > > > the spec to help people build devices.
> > > > > >
> > > > > >
> > > > > > > > But yes, VIRTIO_F_ORDER_PLATFORM has to be documented.
> > > > > > > > And we have to decide what to do about ACCESS_PLATFORM since
> > > > > > > > there's a security problem if device allows not acking it.
> > > > > > > > Two options:
> > > > > > > > - relax the rules a bit and say device will assume ACCESS_PLATFORM
> > > > > > > >   is acked anyway
> > > > > > >
> > > > > > > This will break legacy drivers which assume physical addresses.
> > > > > >
> > > > > > not that they are not already broken.
> > > > >
> > > > > I may miss something, the whole point is to allow legacy drivers to
> > > > > run otherwise a modern device is sufficient?
> > > >
> > > > yes and if legacy drivers don't work in a given setup then we
> > > > should not worry.
> > > >
> > > > > >
> > > > > > > > - a new flag that is insecure (so useful for sec but useless for dpdk) but optional
> > > > > > >
> > > > > > > This looks like a new "hack" for the legacy hacks.
> > > > > >
> > > > > > it's not just for legacy.
> > > > >
> > > > > We have the ACCESS_PLATFORM feature bit, what is the useage for this new flag?
> > > >
> > > >
> > > > ACCESS_PLATFORM is also a security boundary. so devices must fail
> > > > negotiation if it's not there. this new one won't be.
> > > >
> > > >
> > > > > >
> > > > > > > And what about ORDER_PLATFORM, I don't think we can modify legacy drivers...
> > > > > > >
> > > > > > > Thanks
> > > > > >
> > > > > > You play some tricks with shadow VQ I guess.
> > > > >
> > > > > Do we really want to add a new feature in the virtio spec that can
> > > > > only work with the datapath mediation?
> > > > >
> > > > > Thanks
> > > >
> > > > As long as a feature is useful and can't be supported otherwise
> > > > we are out of options.
> > >
> > > Probably not? Is it as simple as relaxing this:
> > >
> > > "Transitional devices MUST expose the Legacy Interface in I/O space in BAR0."
> > >
> > > To allow memory space.
> > >
> > > This works for both software and hardware devices (I had a handy
> > > hardware that supports legacy virtio drivers in this way).
> > >
> > > Thanks
> >
> > Yes it is certainly simpler.
> >
> > Question: what happens if you try to run existing windows guests or dpdk
> > on these? Do they crash horribly or exit gracefully?
> 
> Haven't tried DPDK and windows. But I remember DPDK supported legacy
> MMIO bars for a while.
> 
> Adding Maxime and Yan for comments here.
> 
> >
> > The point of the capability is to allow using modern device ID so such
> > guests will not even try to bind.
> 
> It means a mediation layer is required to use. Then it's not an issue
> for this simple relaxing any more?
> 
> An advantage of such relaxing is that, for the legacy drivers like an
> ancient Linux version that can already do MMIO access to legacy BAR it
> can work without any mediation.

Yes. But the capability approach does not prevent that -
just use a transitional ID.
The disadvantage of a transitional ID is some old drivers might crash, or fail
to work in other ways. Using a modern ID with a capability
prevents old drivers from attaching. Using a capability the system
designed is in control and can decide which drivers to use.



> At least, if ID can help, it can be used with this as well.
> 
> Thanks


I don't know what that means.

> 
> 
> >
> >
> > > > Keeping field practice things out of the
> > > > spec helps no one.
> > > >
> > > > > >
> > > > > > --
> > > > > > MST
> > > > > >
> > > >
> >


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

