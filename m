Return-Path: <virtio-dev-return-12160-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECD63C77B73
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 03:58:56 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 1C5DE2AC6F
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 03:58:56 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 12A4A9865B2
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 03:58:56 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 078CD98650F; Wed, 12 Apr 2023 03:58:56 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DFF649864B3
	for <virtio-dev@lists.oasis-open.org>; Wed, 12 Apr 2023 03:58:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: wDP4XwebOQacoofmgpj2TA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681271931; x=1683863931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=14dviLpXCS3QnvzR3JMlDdFsuHshw03uY4gDtoqnoTc=;
        b=QsxKICLeVsH3ck3g1i0aA/rt/RT8uZXaKoAAvlbQ8V55N9217Uz8nBYPfzIiuJbqtf
         yYcrQmyWcX5d+sgB3CT0vcSgXRmmE7aOSv89Ynay+mtIgzfR1ljqneAJSHxFtLHJ9kbt
         Uc2210nMxJj/BF+aE1S4LCKaeN3FHV6spJR77OWJ2Xj4qyENworonuCbK6Z7PcY1oGXA
         gdRSwcSDe5fEm1L1iPwaN8h9vERTU3hlXn3dREpTwp8ipFUJyIn8eIAb1IdTADR5UJ2z
         OP65R8fmI8KogwMqf0RitB6MixV7g30LqXv3bs1pW1l/6xbo230v0xgM5qk8on27pmLe
         V40A==
X-Gm-Message-State: AAQBX9fxT2mYbYVEwMxF2F8xanCkn5qnYadIeNqpfvIZ6XD/fJeY3XLa
	iN42+I20OoKPdTPyiCugaiEfI8BX/K7g0KHFdT8HBQZGGyy89i5m7ha8ZiJqTd3Ohlf42l1ZHjX
	60oshQ8oMfIIAyj5N2Ys5dD0dg5l08UpPtUq2Au2K1/WK
X-Received: by 2002:a05:620a:29cb:b0:74a:508:e788 with SMTP id s11-20020a05620a29cb00b0074a0508e788mr4390160qkp.8.1681271930886;
        Tue, 11 Apr 2023 20:58:50 -0700 (PDT)
X-Google-Smtp-Source: AKy350bDiouuOC8GRAzel885LaF35I6qn0NExePS7xUqeBGPQcAyuKZxsnvNNWm6OArKqcgQz1a2twvmoC2XUVUoyWA=
X-Received: by 2002:a05:620a:29cb:b0:74a:508:e788 with SMTP id
 s11-20020a05620a29cb00b0074a0508e788mr4390155qkp.8.1681271930548; Tue, 11 Apr
 2023 20:58:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230407043841-mutt-send-email-mst@kernel.org>
 <CACGkMEtkOdwixxaRz2Pv9xP75vb13ncboX5XRs8NqFCUsS16aQ@mail.gmail.com>
 <20230410020906-mutt-send-email-mst@kernel.org> <CACGkMEtiROwuB+ECJqd13qdpMJSTMoDOzi1u_i85==42C0XSXw@mail.gmail.com>
 <20230410023715-mutt-send-email-mst@kernel.org> <CACGkMEs+E_OarQxP3NmLk3iSi7U0WgAn-m3b4eX7ULu1+v=sOw@mail.gmail.com>
 <20230410060417-mutt-send-email-mst@kernel.org> <CACGkMEuc47PdmQdC67Nz4AvX_+jy+XBgCkwZ1BHmM8VGb9gywA@mail.gmail.com>
 <20230411030056-mutt-send-email-mst@kernel.org> <CACGkMEt2QAfhCgpYjSRNzf3n4W_HJLrMfE9JHzocR_gPH_Zrtg@mail.gmail.com>
 <20230411063945-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230411063945-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 12 Apr 2023 11:58:39 +0800
Message-ID: <CACGkMEufWUXHKahg3GLOKfV5aptbiek_DKwy+7rCfMya2GPaTQ@mail.gmail.com>
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

On Tue, Apr 11, 2023 at 6:42=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Tue, Apr 11, 2023 at 05:01:59PM +0800, Jason Wang wrote:
> > On Tue, Apr 11, 2023 at 3:04=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Tue, Apr 11, 2023 at 10:13:40AM +0800, Jason Wang wrote:
> > > > On Mon, Apr 10, 2023 at 6:06=E2=80=AFPM Michael S. Tsirkin <mst@red=
hat.com> wrote:
> > > > >
> > > > > On Mon, Apr 10, 2023 at 03:20:52PM +0800, Jason Wang wrote:
> > > > > > On Mon, Apr 10, 2023 at 2:40=E2=80=AFPM Michael S. Tsirkin <mst=
@redhat.com> wrote:
> > > > > > >
> > > > > > > On Mon, Apr 10, 2023 at 02:20:16PM +0800, Jason Wang wrote:
> > > > > > > > On Mon, Apr 10, 2023 at 2:15=E2=80=AFPM Michael S. Tsirkin =
<mst@redhat.com> wrote:
> > > > > > > > >
> > > > > > > > > On Mon, Apr 10, 2023 at 09:33:32AM +0800, Jason Wang wrot=
e:
> > > > > > > > > > This is fine for vDPA but not for virtio if the design =
can only work
> > > > > > > > > > for some specific setups (OSes/archs).
> > > > > > > > > >
> > > > > > > > > > Thanks
> > > > > > > > >
> > > > > > > > > Well virtio legacy has a long history of documenting exis=
ting hacks :)
> > > > > > > >
> > > > > > > > Exactly, so the legacy behaviour is not (or can't be) defin=
ed by the
> > > > > > > > spec but the codes.
> > > > > > >
> > > > > > > I mean driver behaviour derives from the code but we do docum=
ent it in
> > > > > > > the spec to help people build devices.
> > > > > > >
> > > > > > >
> > > > > > > > > But yes, VIRTIO_F_ORDER_PLATFORM has to be documented.
> > > > > > > > > And we have to decide what to do about ACCESS_PLATFORM si=
nce
> > > > > > > > > there's a security problem if device allows not acking it=
.
> > > > > > > > > Two options:
> > > > > > > > > - relax the rules a bit and say device will assume ACCESS=
_PLATFORM
> > > > > > > > >   is acked anyway
> > > > > > > >
> > > > > > > > This will break legacy drivers which assume physical addres=
ses.
> > > > > > >
> > > > > > > not that they are not already broken.
> > > > > >
> > > > > > I may miss something, the whole point is to allow legacy driver=
s to
> > > > > > run otherwise a modern device is sufficient?
> > > > >
> > > > > yes and if legacy drivers don't work in a given setup then we
> > > > > should not worry.
> > > > >
> > > > > > >
> > > > > > > > > - a new flag that is insecure (so useful for sec but usel=
ess for dpdk) but optional
> > > > > > > >
> > > > > > > > This looks like a new "hack" for the legacy hacks.
> > > > > > >
> > > > > > > it's not just for legacy.
> > > > > >
> > > > > > We have the ACCESS_PLATFORM feature bit, what is the useage for=
 this new flag?
> > > > >
> > > > >
> > > > > ACCESS_PLATFORM is also a security boundary. so devices must fail
> > > > > negotiation if it's not there. this new one won't be.
> > > > >
> > > > >
> > > > > > >
> > > > > > > > And what about ORDER_PLATFORM, I don't think we can modify =
legacy drivers...
> > > > > > > >
> > > > > > > > Thanks
> > > > > > >
> > > > > > > You play some tricks with shadow VQ I guess.
> > > > > >
> > > > > > Do we really want to add a new feature in the virtio spec that =
can
> > > > > > only work with the datapath mediation?
> > > > > >
> > > > > > Thanks
> > > > >
> > > > > As long as a feature is useful and can't be supported otherwise
> > > > > we are out of options.
> > > >
> > > > Probably not? Is it as simple as relaxing this:
> > > >
> > > > "Transitional devices MUST expose the Legacy Interface in I/O space=
 in BAR0."
> > > >
> > > > To allow memory space.
> > > >
> > > > This works for both software and hardware devices (I had a handy
> > > > hardware that supports legacy virtio drivers in this way).
> > > >
> > > > Thanks
> > >
> > > Yes it is certainly simpler.
> > >
> > > Question: what happens if you try to run existing windows guests or d=
pdk
> > > on these? Do they crash horribly or exit gracefully?
> >
> > Haven't tried DPDK and windows. But I remember DPDK supported legacy
> > MMIO bars for a while.
> >
> > Adding Maxime and Yan for comments here.
> >
> > >
> > > The point of the capability is to allow using modern device ID so suc=
h
> > > guests will not even try to bind.
> >
> > It means a mediation layer is required to use. Then it's not an issue
> > for this simple relaxing any more?
> >
> > An advantage of such relaxing is that, for the legacy drivers like an
> > ancient Linux version that can already do MMIO access to legacy BAR it
> > can work without any mediation.
>
> Yes. But the capability approach does not prevent that -
> just use a transitional ID.
> The disadvantage of a transitional ID is some old drivers might crash, or=
 fail
> to work in other ways.

If the driver is wrote correctly it should fail gracefully if it can't
request legacy I/O regions.

> Using a modern ID with a capability
> prevents old drivers from attaching.

Just to make sure we are at the same page.

It looks like the motivation for this series is allow hypervisor to
mediate between legacy MMIO BAR and legacy driver. This end ups with a
design that only work for a specific use case (virtualization) and a
specific setups (e.g using Linux as a hypervisor). By definition, it's
not a transitional device. What's more important, if it is only used
for virtualization, legacy MMIO bar is not a must. We can present a
legacy device on top of modern device by using necessary mediation
technologies as discussed.

By relaxing to use MMIO at BAR0, we had a much broad use cases. By
definition, it's a transitional device. It's useful for both bare
metal and virtualization. We don't worry about the buggy drivers or at
least fixing (I meant fail on no I/O bar) those drivers is not hard.

> Using a capability the system
> designed is in control and can decide which drivers to use.

Do we allow a virtio device only with this capability? If yes, this
seems can mislead vendors. If not, we have already had modern
interfaces so I don't see value to add that in the current Linux
drivers. The only possible use case is the doing mediation in the
hypervisor like Qemu not the driver.

>
>
>
> > At least, if ID can help, it can be used with this as well.
> >
> > Thanks
>
>
> I don't know what that means.

I mean having dedicated ID for this relaxing (though I don't see too
much value).

Thanks

>
> >
> >
> > >
> > >
> > > > > Keeping field practice things out of the
> > > > > spec helps no one.
> > > > >
> > > > > > >
> > > > > > > --
> > > > > > > MST
> > > > > > >
> > > > >
> > >
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

