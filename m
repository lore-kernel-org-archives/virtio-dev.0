Return-Path: <virtio-dev-return-13092-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C47EB64DC
	for <virtio-dev@archiver.kernel.org>; Tue, 27 Jun 2023 02:38:26 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 8EEA2171D0C
	for <virtio-dev@archiver.kernel.org>; Tue, 27 Jun 2023 02:38:25 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 81EA098641F
	for <virtio-dev@archiver.kernel.org>; Tue, 27 Jun 2023 02:38:25 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 74630986350; Tue, 27 Jun 2023 02:38:25 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5B14C98639B
	for <virtio-dev@lists.oasis-open.org>; Tue, 27 Jun 2023 02:38:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: Q6BMUfRhMw-GVS7ab8fzSw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687833495; x=1690425495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7o3uetnN5z3NXlwvDSaL68XYOjJHuWanMm5YwtrLLhM=;
        b=Of1+W2rtHjrDXgT419jQIeX/qUO5vUzccE07ExE729Jc2+qnFzDs03UlN3bhQxxWST
         YlAwPUHKHAFSlQdT9GG8UjFnwtonw2710wB/l4+UOuPSKPJLEQBV+i+cDoDsiikJZ8S0
         I1NOhXNrIv3THO2amVaKIQcW5VlwuqEpvDEIKuJhTawmfLCIEqsCzp0GCMQHchgrMqhj
         5pUy5e84sP9avCoS4CTR/a1/PnB4E8CujYG6EpTNhNLyPpYYvFlhU0+dah2DDuakU4/x
         1UppOGwZ8lIkoz65owHkIspPNBXo4z1Nk/NEUe+STgX+JNorxdYPviKQqH7eLxe0JD/S
         h5lg==
X-Gm-Message-State: AC+VfDz8RrL8Gozplvdw6PtpBuywNc7DItBM8wMefRk9eI/UTBViHaCr
	4nv5SkUSgApo3Oq4W+06A+whzPaDsntp7HGTbAzlmfmxc41ikitx3NeviR2nPo0HAKAY2Iu941Z
	9d2SmL+9H3wZWi/85yszxnLP1NLMpAh+tgZoV3tq8pymI
X-Received: by 2002:a19:6748:0:b0:4f8:6bca:50d7 with SMTP id e8-20020a196748000000b004f86bca50d7mr13296868lfj.13.1687833495247;
        Mon, 26 Jun 2023 19:38:15 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7QxgW6lUelz8XquYOLi53HU8RZHmkBT0p4xDk+EB42ZgMWB79H6xfXli2NxdFy3ZWLjMPkkPDXacR+w9ROS2E=
X-Received: by 2002:a19:6748:0:b0:4f8:6bca:50d7 with SMTP id
 e8-20020a196748000000b004f86bca50d7mr13296855lfj.13.1687833494850; Mon, 26
 Jun 2023 19:38:14 -0700 (PDT)
MIME-Version: 1.0
References: <PH0PR12MB54810313CA6DD1995F52745DDC50A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsy=pG=LT0hOT-PO3HTkk3NOAu6qA_GaZpKwqq8B996cA@mail.gmail.com>
 <PH0PR12MB5481B197049376E7C4D0112EDC51A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsPjwgx=atOC1ww+RnfJcrg7m2CmMXWQCCoreCwsWVpLg@mail.gmail.com>
 <PH0PR12MB54817C027CB2B7BB74BD35EDDC51A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsGA4ZhOPn5OCTZEZkja2UrLpJ8DXH+d62Fp5rtdicseg@mail.gmail.com>
 <PH0PR12MB5481F1BE96B1CE71F4FBD2D8DC51A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEu+LDKUkg5ZZjcRsztrL1QGY2a6wto8r93Ddwc6L=a63w@mail.gmail.com>
 <PH0PR12MB5481175A9D915E3BF396AFFBDC51A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsN=5DcMsZa5hHGKb9kCRUVA2CcwZ4uif-E0HKaXiJ-fA@mail.gmail.com>
 <20230609031923-mutt-send-email-mst@kernel.org> <PH0PR12MB54817CE9205B222B57680AE4DC51A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEvVEgywkt6ZzWNRicceexDZ+aDzv-SusUHC5+G6gJi3_A@mail.gmail.com> <PH0PR12MB5481216B4B97DCB726B0B12DDC26A@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB5481216B4B97DCB726B0B12DDC26A@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 27 Jun 2023 10:38:03 +0800
Message-ID: <CACGkMEu=HzmLc5Ew1Hk4qogtvNTJMQLoddMFfx2OS8FwJ7dQdQ@mail.gmail.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, 
	"david.edmondson@oracle.com" <david.edmondson@oracle.com>, "sburla@marvell.com" <sburla@marvell.com>, 
	Yishai Hadas <yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>, 
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [virtio-comment] Re: [virtio-dev] Re: [PATCH v3 0/3]
 transport-pci: Introduce legacy registers access using AQ

On Mon, Jun 26, 2023 at 11:52=E2=80=AFAM Parav Pandit <parav@nvidia.com> wr=
ote:
>
>
>
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Sunday, June 25, 2023 11:32 PM
>
> > > Hypervisor flow without involving guest; first sanity round to figure=
 out things
> > can work:
> >
> > Why is this sanity round a must?
> >
> Because there is no point of failing it later when actual rw occurs.

Even with admin virtqueue, the hypervisor should be ready for any
admin command failures somehow.

And with modern devices, the reset is not a must, the hypervisor can
just read device_features to check if _MAC/_HDR is there. And what's
more important, the hypervisor can know if the feature negotiation
succeeds or not. With legacy, there's no such way.

>
> > > 1. reset the device
> > > 2. set ACK and DRIVER bit
> > > 3. read features and make sure _MAC, _HDR are supported.
> >
> > Similar step is required even for AQ since the hypervisor needs to know=
 if legacy
> > commands are supported there.
> >
> No. similar steps are not required on AQ because AQ support discovery is =
done once per owner device. Not for each member device.

This seems a topic beyond legacy. If both modern and transitional
devices are supported, a per device probing or provisioning is still
required. And if provisioning is supported, there's no need to probe
MAC/HDR.

>
> > > 4. if not abort.
> > > 5. reset the device 2nd time so that guest can have right view of thi=
ngs.
> > >
> > > On guest access of legacy area:
> > > 6. reset the device
> > > 7. set ACK and DRIVER bit on guest request 8. read features and make
> > > sure _MAC, _HDR are offered
> > > 8.1 Hope for the best that on two completely unrelated device reset o=
n #1
> > and #6, the device offers exact same feature bits.
> >
> > Explained and discussed in another thread, this is a hard requirement o=
therwise
> > a lot of things would break.
> >
> That limitation is for the past or current.

You need at least a new feature bit.

> As we move forward there is no need to continue with such limitation.
> There may be more work needed to overcome that limitation, but we don=E2=
=80=99t want to build on top of that limitation.

Let's open a dedicated thread for this if necessary.

>
> > > And mention this in the spec 1.x for rest of the future.
> > >
> > > We shouldn't be adding such a limitation to the spec.
> > > We have seen this with mlx5 device where 5 years ago one thought this
> > cannot happen.
> > > And now with modern use case now features changes across two resets f=
or
> > mlx5 device.
> > > Baking such limitation in current spec for past 1.x is sub-optimal.
> > >
> > > ok, so to avoid baking such reset flow nasty things in spec, lets avo=
id flow of
> > #1 to #5 in hypervisor.
> > > So, provision the device to support these new feature bits via AQ.
> > > So AQ is required for feature provisioning anyway.
> > >
> > > So, your point #4 is required in both methods and so it scores same a=
s this
> > proposal.
> > > Hence feature bit is not of an advantage.
> > >
> > > With _MAC now we need writable mac on 1.x config space.
> > > for 1.x writable mac has two requirements.
> > > 1. It must be atomic (not for 0.9.5, but must for 1.x like CVQ)
> >
> > For LEGACY_MAC, we don't need to be atomic. We manage to survive for
> > several years.
> >
> It was cited as issue in past discussed when you and Michael both asked t=
o consider tvq.
> What changed now?

Nothing changed, what I meant is: with admin virtqueue it could be
atomic or not.

>
> The issue is that device hw needs implement special RW registers now for =
the mac for legacy.
> This is the unwanted burden not needed, where AQ is better.

How can you solve the atomic issue in this case? The issue is the
driver where legacy guests write to device configuration space byte by
byte. Modern guests will use cvq.

>
> > > 2. should be synchronous to know success/failure to know when it is
> > > effective
> >
> > It's as simple as allowing mac in the device configuration space writab=
le.
> >
> Not simple for hw at scale.

I don't understand, it uses modern device configuration space. How
does it matter with the scale of admin virtqueue?

> AQ is superior that communicates rarely used information.
>
> > >
> > > Both are present on the CVQ, so yet add another duplicate 1.x scheme =
that
> > fulfill above requirements.
> >
> > I'm not sure how to define duplication, the legacy device configuration=
 space
> > access via admin virtqueue is kind of a duplication in this sense as we=
ll.
> >
> It only exists on AQ for legacy purpose.
> The feature bit defined is not for legacy, hence its duplicated.

It's for legacy mediation and what's more, it allows mac to be
configured without cvq.

>
> > >
> > > ok. So may be let's do AQ command for just mac setting.
> > >
> > > This scores down now for two reasons.
> > > a. Duplicate of existing 1.x feature
> > > b. requires AQ.
> > >
> > > So, from RW mac we moved from 1.x cfg space to AQ. This mediation for=
 1.x is
> > not good.
> >
> > Modern drivers just won't negotiate LEGACY_MAC, so there's no mediation=
 at
> > all.
> As feature, there is no need to prefix it with LEGACY because it=E2=80=99=
s a new feature.
>
> >
> > > And now it's not trivial either as it is not just simple *p_mac =3D X=
.
> > > Hence, #1 of non-trivial starts to looks less appealing.
> > >
> > > Your point #3 about vendor to implement legacy behavior.
> > > If vendor needs to support legacy, vendor anyway needs to implement _=
HDR
> > anyway in data path.
> > > and above MAC change, and feature provisioning.
> >
> > I think there are some misunderstandings here:
> >
> > For legacy behaviour, I mainly meant the behaviour in the corner cases =
that
> > can't be documented (easily) by the spec since it is defined by the cod=
e (e.g
> > Linux drivers and Qemu). LEGACY_MAC/HDR doesn't belong to those since t=
he
> > behaviour is well understood and defined in the spec.
> >
> > It's very hard to audit each corner case and it would easily result in =
endless
> > errata of the hardware. Modern devices have clearly defined behaviour a=
nd it's
> > easier to implement. It's never too late to fix spec if we found a bug.
> >
> I don=E2=80=99t see how that is avoided when one side has undefined corne=
r case that is translated to well defined behavior.

Let me give you an example. The legacy device behaviour is basically
what Qemu codes did, by reusing the existing Qemu virtio device model
codes, most of the issues can be avoided.

> It only means that piece will be in endless errata in sw.

Errata in software is much more simpler/cheaper than hardware, isn't it?

> It still scores same or less.
>
> > >
> > > For legacy there is no extra/special documentation.
> > > All the behavior listed in Legacy interfaces section for configuratio=
n register
> > present applies here.
> >
> > That's not true, the legacy section is the best effort since it's too l=
ate to define
> > (codes came before the spec).
> >
> One can added the missing documentation...

It will be too late for the legacy, and it would be too hard since it
basically tries to describe the exact code behaviour. And there could
be a lot of very hard questions that need to be answered. E.g what
happens if a driver tries to use both modern and legacy interfaces?

>
>
> > >
> > > So, I don't see mac support is trivial by any means compared to propo=
sed
> > scheme for 1.x.
> > > Hence, comparing trivialness of two solutions seems same for your poi=
nt #1
> > once you do mac plumbing.
> > >
> > > Regarding #2 on nesting. I won't claim I understand this as your leve=
l of
> > knowledge.
> > > If you are sauing only the VF is in VM as virtio PCI device to suppor=
ting nested
> > guest, that doesn't have AQ, hence it doesn't work due above issues.
> >
> > This is the most common setup, no?
> >
> Depends on who see it.
> We don=E2=80=99t see common setup for legacy or otherwise.
>
> > The major issues are the transport function is not self contained in a =
device
> > (function). This will cause a lot of trouble when trying to implement n=
esting. E.g
> > you need to assign or emulate SR-IOV from L1 to
> > L(N-1) in order to let L(N) to work.
> >
> Those who do nesting usually do assign the PF as well.

This is not what I was told and it's not flexible.

Thanks


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

