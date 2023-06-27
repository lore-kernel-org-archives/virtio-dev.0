Return-Path: <virtio-dev-return-13096-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7B7EEB64D9
	for <virtio-dev@archiver.kernel.org>; Tue, 27 Jun 2023 04:33:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 03CF5755ED
	for <virtio-dev@archiver.kernel.org>; Tue, 27 Jun 2023 04:33:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E174B98641C
	for <virtio-dev@archiver.kernel.org>; Tue, 27 Jun 2023 04:33:39 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id D37AE986312; Tue, 27 Jun 2023 04:33:39 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BDD7098635C
	for <virtio-dev@lists.oasis-open.org>; Tue, 27 Jun 2023 04:33:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 0LhdfUgxPL2AV0iEAM93nw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687840412; x=1690432412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JKZGnYJzqRhADvu1FWFpUXM75JPAlfydl7gBDrHGFZM=;
        b=Tn1PZAUxKWN07ea4DeH0TEaBB4Epv404uCf4wzWmV46ALoXxMHCPmVJKWvNwThku6R
         9eziyVX1vSWFHEC3wPEXlEjPkpwGwbYk53P3B5kIqufBO9eUDcZjNdWZH/isHXzvkMuh
         aNGmvBMNcUS1Rx0rMgRw6Sb951FudocJIiuWYNdPDLnsi++2gb9CkTxLE4zk6ubKVbNo
         xnFPyCNtOvlSpRIXyrrfdj8N8AHX7p03Q/VQTA7ggi+iQFX45Argh4vIcu4uVlydhGqb
         i7exg8LGIMKHWNtNWrr6iau4AfVPR8QyVGCOnURWb0ZtQ6uY/A1AKShde+KHdyDZE/ZS
         IGcw==
X-Gm-Message-State: AC+VfDzNl+5kKGLwiMUUsvbjfnLUvZuaHmeaBkw8Rd9eCL0yDDsGMhGf
	IBKNYTpcolmlMcNTBAE+7tKimo6fq6ooLYlajbiyq0nxKEFtC1XqNb021bRE5PS1Z3U4XrK43ck
	WghIKzc02CtUKsjHXB55Iz7x06HCdDFmEn1yD7T3S/5N3
X-Received: by 2002:a19:7113:0:b0:4f6:8eb:50ca with SMTP id m19-20020a197113000000b004f608eb50camr18113211lfc.33.1687840412210;
        Mon, 26 Jun 2023 21:33:32 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7Frm1cwT1PfTvZcahFnNKR8PsBUu0MUtmlnXbwjcIu+WSWxGc89HDh8HDn8Mxas1sRbCqwGia6kUDfCPiNnxI=
X-Received: by 2002:a19:7113:0:b0:4f6:8eb:50ca with SMTP id
 m19-20020a197113000000b004f608eb50camr18113189lfc.33.1687840411720; Mon, 26
 Jun 2023 21:33:31 -0700 (PDT)
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
 <CACGkMEvVEgywkt6ZzWNRicceexDZ+aDzv-SusUHC5+G6gJi3_A@mail.gmail.com>
 <PH0PR12MB5481216B4B97DCB726B0B12DDC26A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEu=HzmLc5Ew1Hk4qogtvNTJMQLoddMFfx2OS8FwJ7dQdQ@mail.gmail.com> <PH0PR12MB54816E008E2E037898ED7D23DC27A@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB54816E008E2E037898ED7D23DC27A@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 27 Jun 2023 12:33:20 +0800
Message-ID: <CACGkMEupQg+xer4ab2ckXUZ5TsjDFEjvLr-7YXvbsDXsW532jw@mail.gmail.com>
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

On Tue, Jun 27, 2023 at 11:17=E2=80=AFAM Parav Pandit <parav@nvidia.com> wr=
ote:
>
>
>
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Monday, June 26, 2023 10:38 PM
>
> > > >
> > > Because there is no point of failing it later when actual rw occurs.
> >
> > Even with admin virtqueue, the hypervisor should be ready for any admin
> > command failures somehow.
> >
> Yes, device failures can happen regardless.
>
> > And with modern devices, the reset is not a must, the hypervisor can ju=
st read
> > device_features to check if _MAC/_HDR is there.
>
> >
> I read the spec differently as,
> The driver MUST follow this sequence to initialize a device:
> 1. Reset the device.

It's not the initialization, it's a probing of supported features.

>
> > And what's more important,
> > the hypervisor can know if the feature negotiation succeeds or not. Wit=
h
> > legacy, there's no such way.
> Again, we are not fixing the legacy here.

I mean, it's not worse than failing silently in the legacy case so we
don't need to care.

>
> > >
> > > > > 1. reset the device
> > > > > 2. set ACK and DRIVER bit
> > > > > 3. read features and make sure _MAC, _HDR are supported.
> > > >
> > > > Similar step is required even for AQ since the hypervisor needs to
> > > > know if legacy commands are supported there.
> > > >
> > > No. similar steps are not required on AQ because AQ support discovery=
 is
> > done once per owner device. Not for each member device.
> >
> > This seems a topic beyond legacy. If both modern and transitional devic=
es are
> > supported, a per device probing or provisioning is still required. And =
if
> > provisioning is supported, there's no need to probe MAC/HDR.
> >
> That is possible to rely on the AQ.
>  > >
> > > > > 4. if not abort.
> > > > > 5. reset the device 2nd time so that guest can have right view of=
 things.
> > > > >
> > > > > On guest access of legacy area:
> > > > > 6. reset the device
> > > > > 7. set ACK and DRIVER bit on guest request 8. read features and
> > > > > make sure _MAC, _HDR are offered
> > > > > 8.1 Hope for the best that on two completely unrelated device
> > > > > reset on #1
> > > > and #6, the device offers exact same feature bits.
> > > >
> > > > Explained and discussed in another thread, this is a hard
> > > > requirement otherwise a lot of things would break.
> > > >
> > > That limitation is for the past or current.
> >
> > You need at least a new feature bit.
> >
> Not needed, current mechanism is just fine as there is member device driv=
er to owner communication.
>
> > > As we move forward there is no need to continue with such limitation.
> > > There may be more work needed to overcome that limitation, but we don=
=E2=80=99t
> > want to build on top of that limitation.
> >
> > Let's open a dedicated thread for this if necessary.
> >
> Ok. We don=E2=80=99t want to have that assumption and build interface.
>
> > >
> > > > > And mention this in the spec 1.x for rest of the future.
> > > > >
> > > > > We shouldn't be adding such a limitation to the spec.
> > > > > We have seen this with mlx5 device where 5 years ago one thought
> > > > > this
> > > > cannot happen.
> > > > > And now with modern use case now features changes across two
> > > > > resets for
> > > > mlx5 device.
> > > > > Baking such limitation in current spec for past 1.x is sub-optima=
l.
> > > > >
> > > > > ok, so to avoid baking such reset flow nasty things in spec, lets
> > > > > avoid flow of
> > > > #1 to #5 in hypervisor.
> > > > > So, provision the device to support these new feature bits via AQ=
.
> > > > > So AQ is required for feature provisioning anyway.
> > > > >
> > > > > So, your point #4 is required in both methods and so it scores
> > > > > same as this
> > > > proposal.
> > > > > Hence feature bit is not of an advantage.
> > > > >
> > > > > With _MAC now we need writable mac on 1.x config space.
> > > > > for 1.x writable mac has two requirements.
> > > > > 1. It must be atomic (not for 0.9.5, but must for 1.x like CVQ)
> > > >
> > > > For LEGACY_MAC, we don't need to be atomic. We manage to survive fo=
r
> > > > several years.
> > > >
> > > It was cited as issue in past discussed when you and Michael both ask=
ed to
> > consider tvq.
> > > What changed now?
> >
> > Nothing changed, what I meant is: with admin virtqueue it could be atom=
ic or
> > not.
> >
> I don=E2=80=99t know why you keep circling back on it.
>
> Why do you ask below "how atomicity is achieved if it is not important?"
>
> > >
> > > The issue is that device hw needs implement special RW registers now =
for the
> > mac for legacy.
> > > This is the unwanted burden not needed, where AQ is better.
> >
> > How can you solve the atomic issue in this case? The issue is the drive=
r where
> > legacy guests write to device configuration space byte by byte.
> You contradict yourself, above you say that we managed, here you say its =
issue.
>
> It does write byte by byte, a hypervisor can collect 6 bytes and write al=
l together in one go.
>
> It seems that now the past issue of atomicity was raised and solved with =
AQ, you start to oppose that it...

Let me clarify:

Let's first look at the ABI solely:

+struct virtio_admin_cmd_ld_reg_wr_data {
+       u8 offset; /* Starting byte offset of the device register(s) to wri=
te */
+       u8 register[];
+};

For accessing mac, it could be atomic or not.

Hypervisor can try to collect 6 bytes for atomicy but again it's best
effort and may (for Linux) or may not work for all kinds of guests.

>
> > Modern guests will use cvq.
> >
> Sure.
>
> > >
> > > > > 2. should be synchronous to know success/failure to know when it
> > > > > is effective
> > > >
> > > > It's as simple as allowing mac in the device configuration space wr=
itable.
> > > >
> > > Not simple for hw at scale.
> >
> > I don't understand, it uses modern device configuration space. How does=
 it
> > matter with the scale of admin virtqueue?
> >
> The new feature bit demands mac address in config space to be read write.=
 Modern device doesnt have it as RW.
> This burden is unnecessary to carry forward.

How much burden if we just make 6 byte RW per device?

> An AQ eliminates such heavy device side implementation.
>
> > > AQ is superior that communicates rarely used information.
> > >
> > > > >
> > > > > Both are present on the CVQ, so yet add another duplicate 1.x
> > > > > scheme that
> > > > fulfill above requirements.
> > > >
> > > > I'm not sure how to define duplication, the legacy device
> > > > configuration space access via admin virtqueue is kind of a duplica=
tion in
> > this sense as well.
> > > >
> > > It only exists on AQ for legacy purpose.
> > > The feature bit defined is not for legacy, hence its duplicated.
> >
> > It's for legacy mediation and what's more, it allows mac to be configur=
ed
> > without cvq.
> >
> This fundamental thing is not a gain, but a negative aspect to complicate=
 the device PCI.

Is this minor stuff more complicated than the entire admin virtqueue stuff?

The point is methodology, mediation on top of modern devices is
simpler, and a lot of other methods could be used if LEGACY_MAC
doesn't suffice.

> It even contradicts for current spec definition " Device configuration sp=
ace is generally used for rarely-changing or initialization-time parameters=
".

I don't see how, mac is rarely changed, and for blocks we have
writeable stuffs like wce as well.

>
> > > I don=E2=80=99t see how that is avoided when one side has undefined c=
orner case that
> > is translated to well defined behavior.
> >
> > Let me give you an example. The legacy device behaviour is basically wh=
at
> > Qemu codes did, by reusing the existing Qemu virtio device model codes,=
 most
> > of the issues can be avoided.
> >
> You are welcome to document them in legacy interface section.

Well, you can't describe the behaviour of several kilo lines of code precis=
ely.

>
> > > It only means that piece will be in endless errata in sw.
> >
> > Errata in software is much more simpler/cheaper than hardware, isn't it=
?
> >
> AQ has ability to implement things in less hw centric way.
> And sw when necessary can always decide which AQ commands to use.
> So it is more flexible.

A lot of examples have been demonstrated, software erratas is much
more flexible. It's really common to workaround hardware errata in
kernel or BIOS.

>
> > > It still scores same or less.
> > >
> > > > >
> > > > > For legacy there is no extra/special documentation.
> > > > > All the behavior listed in Legacy interfaces section for
> > > > > configuration register
> > > > present applies here.
> > > >
> > > > That's not true, the legacy section is the best effort since it's
> > > > too late to define (codes came before the spec).
> > > >
> > > One can added the missing documentation...
> >
> > It will be too late for the legacy, and it would be too hard since it b=
asically tries
> > to describe the exact code behaviour. And there could be a lot of very =
hard
> > questions that need to be answered. E.g what happens if a driver tries =
to use
> > both modern and legacy interfaces?
> >
> It is no different than what is defined already in transitional device.

Can you show me where the spec answers this question?

Thanks

> No point repeating same questions again, please.
>
>
> > >
> > >
> > > > >
> > > > > So, I don't see mac support is trivial by any means compared to
> > > > > proposed
> > > > scheme for 1.x.
> > > > > Hence, comparing trivialness of two solutions seems same for your
> > > > > point #1
> > > > once you do mac plumbing.
> > > > >
> > > > > Regarding #2 on nesting. I won't claim I understand this as your
> > > > > level of
> > > > knowledge.
> > > > > If you are sauing only the VF is in VM as virtio PCI device to
> > > > > supporting nested
> > > > guest, that doesn't have AQ, hence it doesn't work due above issues=
.
> > > >
> > > > This is the most common setup, no?
> > > >
> > > Depends on who see it.
> > > We don=E2=80=99t see common setup for legacy or otherwise.
> > >
> > > > The major issues are the transport function is not self contained i=
n
> > > > a device (function). This will cause a lot of trouble when trying t=
o
> > > > implement nesting. E.g you need to assign or emulate SR-IOV from L1
> > > > to
> > > > L(N-1) in order to let L(N) to work.
> > > >
> > > Those who do nesting usually do assign the PF as well.
> >
> > This is not what I was told and it's not flexible.
> One food type does not solve hunger for whole world.
> So one can come up with more elaborate solution as time progresses, we ar=
e hoping that legacy doesnt reach to that point.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

