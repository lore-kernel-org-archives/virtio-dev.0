Return-Path: <virtio-dev-return-12112-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AF5CC7619A
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 09:02:16 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 29B433309C
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 09:02:16 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 05E0B9863D1
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 09:02:16 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E1CCE986366; Tue, 11 Apr 2023 09:02:15 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CFE4D98636D
	for <virtio-dev@lists.oasis-open.org>; Tue, 11 Apr 2023 09:02:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: e-H9noDFOl-HwvPyGX505Q-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681203731; x=1683795731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JoQJvePWC+E9HAfKlg3Zr9Px6+LoCYAwE5Lvin70mCs=;
        b=1FyRzHpXCEBufP8aBIRry/XjtM7Wc3J4IhN1HB6WWuS+yp2jno+Silj+K19JAuCJST
         OPrAPLlNUhKL1lcaCUXiAkOkaRaZ8D2BQqKGUKR0ILk+YX2JDjQp+qK0g//iD08jYeJ4
         VShxjpWyz8QWuEHfHrgjQOC+ExfzAmMMs7zMQVoC5mhRRS+RqdADwc8cOxJq2lYmlLL8
         QWyqv9/tmYljFlrEawbPSnpFzrBl8VyGh3twjfX+rh+JlmcllU+cB105Hbf+/DxrllfC
         Lz+gFWO1YFGCzLTbMdDYIprKfbySguSwFd1leBpHVEYQqNX2Qj6P839EzgrH9gij9E7X
         aBOg==
X-Gm-Message-State: AAQBX9dl3qzsz1HgaO2BzNzBS2dUo3rt/bvAiTgKhy45xxLKVn5F914R
	t2QJJtGn4VwVa9PftWJcUbEKWEJuZVJy6mr5o7BX1lKa1fCOxZzZ/kFvIYzDWYlDM1/g+nDA7IJ
	TU7SkJ/EB4amYpr8Dh+KDN0F1Pi4zvRfwxgphBfFp9oyD
X-Received: by 2002:a05:6870:5627:b0:184:c14:a685 with SMTP id m39-20020a056870562700b001840c14a685mr895051oao.9.1681203730982;
        Tue, 11 Apr 2023 02:02:10 -0700 (PDT)
X-Google-Smtp-Source: AKy350Y30/DZjjWO4jLZoew4X2H9mmkO4P4ZDV6QvDEis0UP5JUNE8PSSVhRXrklBZvD79OKiejDwUV5djUaD4HBrvg=
X-Received: by 2002:a05:6870:5627:b0:184:c14:a685 with SMTP id
 m39-20020a056870562700b001840c14a685mr895037oao.9.1681203730742; Tue, 11 Apr
 2023 02:02:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230330225834.506969-1-parav@nvidia.com> <20230330225834.506969-10-parav@nvidia.com>
 <20230407043841-mutt-send-email-mst@kernel.org> <CACGkMEtkOdwixxaRz2Pv9xP75vb13ncboX5XRs8NqFCUsS16aQ@mail.gmail.com>
 <20230410020906-mutt-send-email-mst@kernel.org> <CACGkMEtiROwuB+ECJqd13qdpMJSTMoDOzi1u_i85==42C0XSXw@mail.gmail.com>
 <20230410023715-mutt-send-email-mst@kernel.org> <CACGkMEs+E_OarQxP3NmLk3iSi7U0WgAn-m3b4eX7ULu1+v=sOw@mail.gmail.com>
 <20230410060417-mutt-send-email-mst@kernel.org> <CACGkMEuc47PdmQdC67Nz4AvX_+jy+XBgCkwZ1BHmM8VGb9gywA@mail.gmail.com>
 <20230411030056-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230411030056-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 11 Apr 2023 17:01:59 +0800
Message-ID: <CACGkMEt2QAfhCgpYjSRNzf3n4W_HJLrMfE9JHzocR_gPH_Zrtg@mail.gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>, virtio-dev@lists.oasis-open.org, cohuck@redhat.com, 
	virtio-comment@lists.oasis-open.org, shahafs@nvidia.com, 
	Satananda Burla <sburla@marvell.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, 
	Yan Vugenfirer <yan@daynix.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH 09/11] transport-pci: Describe PCI
 MMR dev config registers

On Tue, Apr 11, 2023 at 3:04=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Tue, Apr 11, 2023 at 10:13:40AM +0800, Jason Wang wrote:
> > On Mon, Apr 10, 2023 at 6:06=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Mon, Apr 10, 2023 at 03:20:52PM +0800, Jason Wang wrote:
> > > > On Mon, Apr 10, 2023 at 2:40=E2=80=AFPM Michael S. Tsirkin <mst@red=
hat.com> wrote:
> > > > >
> > > > > On Mon, Apr 10, 2023 at 02:20:16PM +0800, Jason Wang wrote:
> > > > > > On Mon, Apr 10, 2023 at 2:15=E2=80=AFPM Michael S. Tsirkin <mst=
@redhat.com> wrote:
> > > > > > >
> > > > > > > On Mon, Apr 10, 2023 at 09:33:32AM +0800, Jason Wang wrote:
> > > > > > > > This is fine for vDPA but not for virtio if the design can =
only work
> > > > > > > > for some specific setups (OSes/archs).
> > > > > > > >
> > > > > > > > Thanks
> > > > > > >
> > > > > > > Well virtio legacy has a long history of documenting existing=
 hacks :)
> > > > > >
> > > > > > Exactly, so the legacy behaviour is not (or can't be) defined b=
y the
> > > > > > spec but the codes.
> > > > >
> > > > > I mean driver behaviour derives from the code but we do document =
it in
> > > > > the spec to help people build devices.
> > > > >
> > > > >
> > > > > > > But yes, VIRTIO_F_ORDER_PLATFORM has to be documented.
> > > > > > > And we have to decide what to do about ACCESS_PLATFORM since
> > > > > > > there's a security problem if device allows not acking it.
> > > > > > > Two options:
> > > > > > > - relax the rules a bit and say device will assume ACCESS_PLA=
TFORM
> > > > > > >   is acked anyway
> > > > > >
> > > > > > This will break legacy drivers which assume physical addresses.
> > > > >
> > > > > not that they are not already broken.
> > > >
> > > > I may miss something, the whole point is to allow legacy drivers to
> > > > run otherwise a modern device is sufficient?
> > >
> > > yes and if legacy drivers don't work in a given setup then we
> > > should not worry.
> > >
> > > > >
> > > > > > > - a new flag that is insecure (so useful for sec but useless =
for dpdk) but optional
> > > > > >
> > > > > > This looks like a new "hack" for the legacy hacks.
> > > > >
> > > > > it's not just for legacy.
> > > >
> > > > We have the ACCESS_PLATFORM feature bit, what is the useage for thi=
s new flag?
> > >
> > >
> > > ACCESS_PLATFORM is also a security boundary. so devices must fail
> > > negotiation if it's not there. this new one won't be.
> > >
> > >
> > > > >
> > > > > > And what about ORDER_PLATFORM, I don't think we can modify lega=
cy drivers...
> > > > > >
> > > > > > Thanks
> > > > >
> > > > > You play some tricks with shadow VQ I guess.
> > > >
> > > > Do we really want to add a new feature in the virtio spec that can
> > > > only work with the datapath mediation?
> > > >
> > > > Thanks
> > >
> > > As long as a feature is useful and can't be supported otherwise
> > > we are out of options.
> >
> > Probably not? Is it as simple as relaxing this:
> >
> > "Transitional devices MUST expose the Legacy Interface in I/O space in =
BAR0."
> >
> > To allow memory space.
> >
> > This works for both software and hardware devices (I had a handy
> > hardware that supports legacy virtio drivers in this way).
> >
> > Thanks
>
> Yes it is certainly simpler.
>
> Question: what happens if you try to run existing windows guests or dpdk
> on these? Do they crash horribly or exit gracefully?

Haven't tried DPDK and windows. But I remember DPDK supported legacy
MMIO bars for a while.

Adding Maxime and Yan for comments here.

>
> The point of the capability is to allow using modern device ID so such
> guests will not even try to bind.

It means a mediation layer is required to use. Then it's not an issue
for this simple relaxing any more?

An advantage of such relaxing is that, for the legacy drivers like an
ancient Linux version that can already do MMIO access to legacy BAR it
can work without any mediation.

At least, if ID can help, it can be used with this as well.

Thanks



>
>
> > > Keeping field practice things out of the
> > > spec helps no one.
> > >
> > > > >
> > > > > --
> > > > > MST
> > > > >
> > >
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

