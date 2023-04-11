Return-Path: <virtio-dev-return-12107-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72AEFC77B6F
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 07:05:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id CDCB14292A
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 07:05:26 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6061298661D
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 07:05:26 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id D7E9D9865B5; Tue, 11 Apr 2023 07:05:25 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A31F0986366
	for <virtio-dev@lists.oasis-open.org>; Tue, 11 Apr 2023 07:04:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: cDPoZcC_OZ21S8yEbc6Hkg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681196646;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X7BJBxzqw6BQKLHHbvgb7nEDPigsaKnnkb/mazo7hR8=;
        b=MzBxjCPtMV83rfy5DbZfj4oX4OKCrQWja2BLjtSB2QdlsZNAFIZKEFoqrQOkDsg422
         jJLkd97/5YF7xcYrtwc2cSb48+3GDldH2PQpkoSHqqiNU8CC7B70yKppgGMttV2lsPKC
         e5hS2KUEQmXbCyRo5MsHHzzZoK0w4gQoz6yUlV0eFf4yK8ZYnsENADGT1kd6yCs2NKnY
         B1YeCCKuX4dXsznXf+IPdGutIiKbZNd5+xO4mMETlpZMQb1i7Wv2JcsnWi1s+FBkU11L
         p+bBYmnMtIo9i5LUs/9IYaqAOpp69YY8VcbMWhzCly0xExJlWr6ZYidJB+wP9b0Z4Vg8
         GOlQ==
X-Gm-Message-State: AAQBX9cn5GGkaVohcG6ewwJg2VuQeK6YqV52ujUGZlRMvf5eApGge/mf
	y8sB2AYLYMqDKjJbsESch9XrCrX95B5bPgNZ5m0Q/CDTg/d1waLvZHt/pXGcFyZU0GWAPwpdxCC
	wqJZSMuDNsUOTpYh4IRewXFbpZ/FG
X-Received: by 2002:a7b:c5c2:0:b0:3ed:6693:138d with SMTP id n2-20020a7bc5c2000000b003ed6693138dmr8356683wmk.4.1681196646550;
        Tue, 11 Apr 2023 00:04:06 -0700 (PDT)
X-Google-Smtp-Source: AKy350bThzteZMwnWPkkE38HCeoRUc/fBG9gUPo3RcBhRLiBPMfHwPtsIhCtCSQNo2tzMGAWbImclQ==
X-Received: by 2002:a7b:c5c2:0:b0:3ed:6693:138d with SMTP id n2-20020a7bc5c2000000b003ed6693138dmr8356662wmk.4.1681196646119;
        Tue, 11 Apr 2023 00:04:06 -0700 (PDT)
Date: Tue, 11 Apr 2023 03:04:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>, virtio-dev@lists.oasis-open.org,
	cohuck@redhat.com, virtio-comment@lists.oasis-open.org,
	shahafs@nvidia.com, Satananda Burla <sburla@marvell.com>
Message-ID: <20230411030056-mutt-send-email-mst@kernel.org>
References: <20230330225834.506969-1-parav@nvidia.com>
 <20230330225834.506969-10-parav@nvidia.com>
 <20230407043841-mutt-send-email-mst@kernel.org>
 <CACGkMEtkOdwixxaRz2Pv9xP75vb13ncboX5XRs8NqFCUsS16aQ@mail.gmail.com>
 <20230410020906-mutt-send-email-mst@kernel.org>
 <CACGkMEtiROwuB+ECJqd13qdpMJSTMoDOzi1u_i85==42C0XSXw@mail.gmail.com>
 <20230410023715-mutt-send-email-mst@kernel.org>
 <CACGkMEs+E_OarQxP3NmLk3iSi7U0WgAn-m3b4eX7ULu1+v=sOw@mail.gmail.com>
 <20230410060417-mutt-send-email-mst@kernel.org>
 <CACGkMEuc47PdmQdC67Nz4AvX_+jy+XBgCkwZ1BHmM8VGb9gywA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEuc47PdmQdC67Nz4AvX_+jy+XBgCkwZ1BHmM8VGb9gywA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH 09/11] transport-pci: Describe PCI
 MMR dev config registers

On Tue, Apr 11, 2023 at 10:13:40AM +0800, Jason Wang wrote:
> On Mon, Apr 10, 2023 at 6:06 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Apr 10, 2023 at 03:20:52PM +0800, Jason Wang wrote:
> > > On Mon, Apr 10, 2023 at 2:40 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Mon, Apr 10, 2023 at 02:20:16PM +0800, Jason Wang wrote:
> > > > > On Mon, Apr 10, 2023 at 2:15 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > >
> > > > > > On Mon, Apr 10, 2023 at 09:33:32AM +0800, Jason Wang wrote:
> > > > > > > This is fine for vDPA but not for virtio if the design can only work
> > > > > > > for some specific setups (OSes/archs).
> > > > > > >
> > > > > > > Thanks
> > > > > >
> > > > > > Well virtio legacy has a long history of documenting existing hacks :)
> > > > >
> > > > > Exactly, so the legacy behaviour is not (or can't be) defined by the
> > > > > spec but the codes.
> > > >
> > > > I mean driver behaviour derives from the code but we do document it in
> > > > the spec to help people build devices.
> > > >
> > > >
> > > > > > But yes, VIRTIO_F_ORDER_PLATFORM has to be documented.
> > > > > > And we have to decide what to do about ACCESS_PLATFORM since
> > > > > > there's a security problem if device allows not acking it.
> > > > > > Two options:
> > > > > > - relax the rules a bit and say device will assume ACCESS_PLATFORM
> > > > > >   is acked anyway
> > > > >
> > > > > This will break legacy drivers which assume physical addresses.
> > > >
> > > > not that they are not already broken.
> > >
> > > I may miss something, the whole point is to allow legacy drivers to
> > > run otherwise a modern device is sufficient?
> >
> > yes and if legacy drivers don't work in a given setup then we
> > should not worry.
> >
> > > >
> > > > > > - a new flag that is insecure (so useful for sec but useless for dpdk) but optional
> > > > >
> > > > > This looks like a new "hack" for the legacy hacks.
> > > >
> > > > it's not just for legacy.
> > >
> > > We have the ACCESS_PLATFORM feature bit, what is the useage for this new flag?
> >
> >
> > ACCESS_PLATFORM is also a security boundary. so devices must fail
> > negotiation if it's not there. this new one won't be.
> >
> >
> > > >
> > > > > And what about ORDER_PLATFORM, I don't think we can modify legacy drivers...
> > > > >
> > > > > Thanks
> > > >
> > > > You play some tricks with shadow VQ I guess.
> > >
> > > Do we really want to add a new feature in the virtio spec that can
> > > only work with the datapath mediation?
> > >
> > > Thanks
> >
> > As long as a feature is useful and can't be supported otherwise
> > we are out of options.
> 
> Probably not? Is it as simple as relaxing this:
> 
> "Transitional devices MUST expose the Legacy Interface in I/O space in BAR0."
> 
> To allow memory space.
> 
> This works for both software and hardware devices (I had a handy
> hardware that supports legacy virtio drivers in this way).
> 
> Thanks

Yes it is certainly simpler.

Question: what happens if you try to run existing windows guests or dpdk
on these? Do they crash horribly or exit gracefully?

The point of the capability is to allow using modern device ID so such
guests will not even try to bind.


> > Keeping field practice things out of the
> > spec helps no one.
> >
> > > >
> > > > --
> > > > MST
> > > >
> >


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

