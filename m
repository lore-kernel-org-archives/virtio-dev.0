Return-Path: <virtio-dev-return-13065-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 142EBC001B0
	for <virtio-dev@archiver.kernel.org>; Mon, 26 Jun 2023 03:32:24 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 4EF704292C
	for <virtio-dev@archiver.kernel.org>; Mon, 26 Jun 2023 03:32:24 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3EE28986415
	for <virtio-dev@archiver.kernel.org>; Mon, 26 Jun 2023 03:32:24 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2E42098636F; Mon, 26 Jun 2023 03:32:24 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 130DB986383
	for <virtio-dev@lists.oasis-open.org>; Mon, 26 Jun 2023 03:32:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: glADya8qMruxXb5LX74kDg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687750333; x=1690342333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FfEpLNNjMLPFds2jheC/z/iXXaO81/DPjEw5RUUKlQY=;
        b=e4pkqwEoGSfpBtwmVcdPPTzIziD6FHx7b+yKAW77LS80OKQ1i7zSI1PZjwDPFf7ds/
         ct4aOeqXxiK4/rkPg05lUx39TlZ2qp7kbcAb2PdV87v5fPjMD5jeHoSPc+AWFIWo+7z1
         6Xblyjhc3R+uosUeda7YYTGXLa97qSp9PWgaijPfQbCtE2LMIEdr1KC3VJoZ2dFQF5fH
         5JIzHqT9JsOUgreYiY0t7NL3AzYMCYKUQ4jZs9Dcjh+W0cQRptK+2BfK9MowZ7NaOSer
         7uK3IC0Iwtf9sDS+2HD+W/s5bEOK6fVH9k//7DoIeVu0ZgyEuYUqPqOdMH4CVisc2fHo
         Qhag==
X-Gm-Message-State: AC+VfDyBoa4cQwWZHYwfOa7VHKok3dbH5NpWPGPr+daGndRDB+et1OzE
	YqP6CJSc3JyBAbuo5nQOaHYON5sEEeflLLVdJDGTU/UKGTUx5tD2zFkG/R+LZfRPS/hIT4oLBwt
	Cc+dwNxj1hWPCCqhYWSi709ad15rmTxRyZ0k6IbbeVrTD
X-Received: by 2002:a2e:9b18:0:b0:2b5:a70a:9b3c with SMTP id u24-20020a2e9b18000000b002b5a70a9b3cmr2098494lji.46.1687750333179;
        Sun, 25 Jun 2023 20:32:13 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5ROnVRVTSduy1ZFgP+cWuDHljpst9KeQl5O1ZXPvpMZ0MpYDjUfrP3nQh1T2OtqNutIup1eoQjhhE/y2gGbSw=
X-Received: by 2002:a2e:9b18:0:b0:2b5:a70a:9b3c with SMTP id
 u24-20020a2e9b18000000b002b5a70a9b3cmr2098490lji.46.1687750332844; Sun, 25
 Jun 2023 20:32:12 -0700 (PDT)
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
In-Reply-To: <PH0PR12MB54817CE9205B222B57680AE4DC51A@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 26 Jun 2023 11:32:01 +0800
Message-ID: <CACGkMEvVEgywkt6ZzWNRicceexDZ+aDzv-SusUHC5+G6gJi3_A@mail.gmail.com>
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

On Sat, Jun 10, 2023 at 1:12=E2=80=AFAM Parav Pandit <parav@nvidia.com> wro=
te:
>
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Friday, June 9, 2023 3:22 AM
> >
> > On Fri, Jun 09, 2023 at 02:27:01PM +0800, Jason Wang wrote:
> > > > I would like to keep the stateful interactions of 1.x device outsid=
e of 0.9.5.
> > >
> > > I don't think this is a real problem, but let's see the drawbacks of
> > > this proposal:
> > >
> > > 1) non-trivial changes of full new transport alike ABI
> > > 2) can't work for nesting
> > > 3) require vendor to implement legacy behaviour which can't be
> > > documented precisely
> > > 4) require admin virtqueue to work
> > >
> > > We won't have the above issues if we use modern + legacy header/mac.
> > >
> > > Thanks
> >
> >
> > All this is true. But it's by design. It makes the legacy thing as isol=
ated as
> > possible. Because let's be frank we won't be able to drop legacy suppor=
t in like
> > 10 years. But hardware vendors will do that quickly if they can't sell =
hardware.
>
> I don't think above 4 points are true for below reasoning.
>
> Hypervisor flow without involving guest; first sanity round to figure out=
 things can work:

Why is this sanity round a must?

> 1. reset the device
> 2. set ACK and DRIVER bit
> 3. read features and make sure _MAC, _HDR are supported.

Similar step is required even for AQ since the hypervisor needs to
know if legacy commands are supported there.

> 4. if not abort.
> 5. reset the device 2nd time so that guest can have right view of things.
>
> On guest access of legacy area:
> 6. reset the device
> 7. set ACK and DRIVER bit on guest request
> 8. read features and make sure _MAC, _HDR are offered
> 8.1 Hope for the best that on two completely unrelated device reset on #1=
 and #6, the device offers exact same feature bits.

Explained and discussed in another thread, this is a hard requirement
otherwise a lot of things would break.

> And mention this in the spec 1.x for rest of the future.
>
> We shouldn't be adding such a limitation to the spec.
> We have seen this with mlx5 device where 5 years ago one thought this can=
not happen.
> And now with modern use case now features changes across two resets for m=
lx5 device.
> Baking such limitation in current spec for past 1.x is sub-optimal.
>
> ok, so to avoid baking such reset flow nasty things in spec, lets avoid f=
low of #1 to #5 in hypervisor.
> So, provision the device to support these new feature bits via AQ.
> So AQ is required for feature provisioning anyway.
>
> So, your point #4 is required in both methods and so it scores same as th=
is proposal.
> Hence feature bit is not of an advantage.
>
> With _MAC now we need writable mac on 1.x config space.
> for 1.x writable mac has two requirements.
> 1. It must be atomic (not for 0.9.5, but must for 1.x like CVQ)

For LEGACY_MAC, we don't need to be atomic. We manage to survive for
several years.

> 2. should be synchronous to know success/failure to know when it is effec=
tive

It's as simple as allowing mac in the device configuration space writable.

>
> Both are present on the CVQ, so yet add another duplicate 1.x scheme that=
 fulfill above requirements.

I'm not sure how to define duplication, the legacy device
configuration space access via admin virtqueue is kind of a
duplication in this sense as well.

>
> ok. So may be let's do AQ command for just mac setting.
>
> This scores down now for two reasons.
> a. Duplicate of existing 1.x feature
> b. requires AQ.
>
> So, from RW mac we moved from 1.x cfg space to AQ. This mediation for 1.x=
 is not good.

Modern drivers just won't negotiate LEGACY_MAC, so there's no mediation at =
all.

> And now it's not trivial either as it is not just simple *p_mac =3D X.
> Hence, #1 of non-trivial starts to looks less appealing.
>
> Your point #3 about vendor to implement legacy behavior.
> If vendor needs to support legacy, vendor anyway needs to implement _HDR =
anyway in data path.
> and above MAC change, and feature provisioning.

I think there are some misunderstandings here:

For legacy behaviour, I mainly meant the behaviour in the corner cases
that can't be documented (easily) by the spec since it is defined by
the code (e.g Linux drivers and Qemu). LEGACY_MAC/HDR doesn't belong
to those since the behaviour is well understood and defined in the
spec.

It's very hard to audit each corner case and it would easily result in
endless errata of the hardware. Modern devices have clearly defined
behaviour and it's easier to implement. It's never too late to fix
spec if we found a bug.

>
> For legacy there is no extra/special documentation.
> All the behavior listed in Legacy interfaces section for configuration re=
gister present applies here.

That's not true, the legacy section is the best effort since it's too
late to define (codes came before the spec).

>
> So, I don't see mac support is trivial by any means compared to proposed =
scheme for 1.x.
> Hence, comparing trivialness of two solutions seems same for your point #=
1 once you do mac plumbing.
>
> Regarding #2 on nesting. I won't claim I understand this as your level of=
 knowledge.
> If you are sauing only the VF is in VM as virtio PCI device to supporting=
 nested guest, that doesn't have AQ, hence it doesn't work due above issues=
.

This is the most common setup, no?

The major issues are the transport function is not self contained in a
device (function). This will cause a lot of trouble when trying to
implement nesting. E.g you need to assign or emulate SR-IOV from L1 to
L(N-1) in order to let L(N) to work.

Thanks

>
> Then yes, but than it is back to square one, where you need sequence #1 t=
o #8 to be done + non-forward-looking spec changes on reset flow.
>
> In that alternative, one can say, hey skip steps #1 to #5, and on step #8=
 doesn't have required feature bit, mark the device FAILED.
> But this is common case and its late in the init flow to discover it.
>
> And now MAC cannot be set atomically either in nesting with just feature =
bit without ugly and non-trivial spec updates.
> And when one needs nesting with legacy, probably PV is better.
>
> As Michael said,
> Overall isolating legacy to AQ for config, intx and by reusing 1.x's noti=
fication is good trade off where 1.x device level interface is kept as deta=
ched from the legacy as possible.
>
> This is why the notification address query also was desired via AQ as pro=
posed in v3, but it is small trade off if you think it should be discovered=
 via PCI cap like v5.
>
> This publicly archived list offers a means to provide input to the
> OASIS Virtual I/O Device (VIRTIO) TC.
>
> In order to verify user consent to the Feedback License terms and
> to minimize spam in the list archive, subscription is required
> before posting.
>
> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> List help: virtio-comment-help@lists.oasis-open.org
> List archive: https://lists.oasis-open.org/archives/virtio-comment/
> Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
> List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-l=
ists
> Committee: https://www.oasis-open.org/committees/virtio/
> Join OASIS: https://www.oasis-open.org/join/
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

