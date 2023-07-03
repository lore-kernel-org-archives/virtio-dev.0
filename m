Return-Path: <virtio-dev-return-13205-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56CB0EB64DC
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Jul 2023 07:43:20 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 75F6F4290E
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Jul 2023 07:43:19 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 48AC998655E
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Jul 2023 07:43:19 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2460E98644B; Mon,  3 Jul 2023 07:43:19 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0EB2998644C
	for <virtio-dev@lists.oasis-open.org>; Mon,  3 Jul 2023 07:43:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: EJ6H9ADjN3SGCly3hJKxfg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688370192; x=1690962192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2dPPz6IGMywVkG9pC8KWFSwchLQk4Ya5ZKo47054v0c=;
        b=d5XX81MYdVK055UxuxPuqFUrq6d1vDSjkmq52HIgJvhPHMpbiEcmXbBcciP6kdxUkI
         BHt0mI1nZJe2bWngSwwWvrBhgZWjWRy8Mvh8UsC48JvIdyh6f2Itl/fr6PoZNhj2PPiH
         0VNRCneHttRk7hzGKm7rH/pnfhMbIdmDE3BykYXmW3By0bBcGkKIcWZe+A2R4lhYpcJz
         1ya2+7LJe2qP9b2Jqtg31Guamfv760UsoCyamixp6TUSROKtGBRaESQNpaTc1G56znzC
         ZovEMHOHKi6HzL7jdblLclqnP4grl1jA49M4vr6sULvHa2gP2QPyT96XCu2S8bUyynl0
         XmGg==
X-Gm-Message-State: ABy/qLb4hSGVRgJOACMxggIUHUGSfUPUORRaTw7RYmX5iBoYpTdEzqo9
	gDGvyNLg+r+cXBK1T+5B06Ped0axSZd5FHTF7PRmuxTixmLZeW+9wHANqrickyU6gn0W3HbwITA
	iq0gVQlaFJVfRe52+R83KA7XOpLS0rHfOa8AB4Q9ohRXJ
X-Received: by 2002:a2e:7812:0:b0:2b6:d0fa:7023 with SMTP id t18-20020a2e7812000000b002b6d0fa7023mr2835564ljc.24.1688370192097;
        Mon, 03 Jul 2023 00:43:12 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHjHtbVDhmhYNZoburjb5ZlaFt8sNFPVEhNd1COg7Ld4FCLUdBu/K4/yjtsNUKki3V6BmSSasgkQkiLics4fSY=
X-Received: by 2002:a2e:7812:0:b0:2b6:d0fa:7023 with SMTP id
 t18-20020a2e7812000000b002b6d0fa7023mr2835523ljc.24.1688370190214; Mon, 03
 Jul 2023 00:43:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230626062210.49020-1-xuanzhuo@linux.alibaba.com>
 <1687854185.3344731-3-xuanzhuo@linux.alibaba.com> <20230627115247-mutt-send-email-mst@kernel.org>
 <1687918864.3728812-2-xuanzhuo@linux.alibaba.com> <20230628112107-mutt-send-email-mst@kernel.org>
 <1688354491.871065-6-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1688354491.871065-6-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 3 Jul 2023 15:42:59 +0800
Message-ID: <CACGkMEvQwc1imSMtfAyJ=rkb12mcdonR=J865WjRMbK0yQTZmQ@mail.gmail.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtio-dev@lists.oasis-open.org, parav@nvidia.com, 
	virtio-comment@lists.oasis-open.org, "Zhu, Lingshan" <lingshan.zhu@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [virtio-dev] Re: [virtio-comment] [RFC PATCH] admin-queue: bind
 the group member to the device

On Mon, Jul 3, 2023 at 11:53=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Wed, 28 Jun 2023 11:41:02 -0400, "Michael S. Tsirkin" <mst@redhat.com>=
 wrote:
> > On Wed, Jun 28, 2023 at 10:21:04AM +0800, Xuan Zhuo wrote:
> > > On Tue, 27 Jun 2023 12:02:41 -0400, "Michael S. Tsirkin" <mst@redhat.=
com> wrote:
> > > > On Tue, Jun 27, 2023 at 04:23:05PM +0800, Xuan Zhuo wrote:
> > > > > So, this is how I understand the process of creating vf:
> > > > >
> > > > > 1. Create a PCI VF, at this time there may be no backend virtio d=
evice, or there
> > > > >     is only a default backend. It does not fully meet our expecta=
tions.
> > > > > 2. Create device or migrate device
> > > > > 3. Bind the backend virtio device to the vf
> > > >
> > > > I can see this making sense as a feature bit that says VFs are not
> > > > initialized by default and must first be setup through an admin com=
mand.
> > > > This will likely need to be a feature bit because it's changing
> > > > behaviour outside of admin commands.
> > > >
> > > > Then, we can have:
> > > >
> > > >   ADMIN_SETUP VF#
> > > >   ADMIN_CLEANUP VF#
> > > >
> > > > I like this because this generalizes CREATE/DESTROY that SIOV guys =
proposed.
> > >
> > > Great!!
> > >
> > > >
> > > >
> > > > Why do we need an id as a level of indirection though? What is wron=
g
> > > > with just using VF# directly?
> > >
> > > I think VF# is ok. I also need to use it. But we need an ID for virti=
o device
> > > not the transport(PF, VF).
> > >
> > > What I want to emphasize is that PCI(pf or vf) is a transport, it is =
only used
> > > to connect the virtio driver and the virtio device. Right?
> > >
> > > The virtio device does not necessarily exist depending on PCI. For ex=
ample, a
> > > virtio device is migrated from another DPU, and it is not associated =
with any
> > > PCI. What I have always wanted to say is that this device(not PCI) mu=
st have its
> > > own ID, which has nothing to do with the transport.
> > >
> > > Now we want to use this migrated device and connect it to the corresp=
onding
> > > vm (migrated from the same host). We can passthrough vf to this vm. B=
ut how do I
> > > tell our DPU to bind this migrated device with this vf?
> > > We can specify the VF by the VF#, but how can we specify the virtio d=
evice?
> > > Maybe there are two migrated virtio device.
> > >
> > > Maybe we should compare it to the case of using PF directly before. T=
he biggest
> > > difference here is that PF is directly hot-plugged by the DPU, so whe=
n a
> > > user(custom) buys a virtio-net device, the DPU directly inserts a new=
 PCI device
> > > on the host. Now the vf is created by the user, and only the user kno=
ws how to
> > > use each one. We cannot directly bind the device purchased or migrate=
d by the
> > > user to a certain vf. We need the user in the host to bind the vf(tra=
nsport) to
> > > a certain virtio device.
> > >
> > > Thanks.
> > >
> > >
> >
> > Maybe I didn't have enough coffee today but I can't figure out what all
> > this means :( For example what does "exist depending" mean?  What does
> > "device is migrated" mean?  What does it mean to be "migrated from the
> > same host"? What is "any PCI"? E.g. I know people did vm migration
> > moving virtio from a hardware device to a software
> > implementation. Is that "not associated with any PCI" ?
> > What is "user(custom)"? how is "the vf is created by the user"?
> > what does it mean to "bind the device .. to a certain vf"?
> > It looks like Parav understand what's going on though, so
> > maybe it's my fault.
> >
> > But fundamentally, the problem is that the spec patch doesn't do
> > anything useful by itself, it relies on some out of spec interface to
> > make these id values make sense. So the TC is reduced to guessing: we
> > could just trust you that it's useful somehow and at the same time
> > serves the purpose whatever it is.
> >
> > But it would be better if instead of trying to explain what that does i=
n
> > vague terms, you post a spec patch that allows doing whatever needs
> > doing for these IDs to make sense through e.g. admin commands.
>
> I try to describe the requirement as a common requirement.
>
> @Parav do you think this is a requirement in your devices?
>
> The core point here is that our virtio-net device is created by customers=
 on the
> management platform. It is not a pure virtio-net device, but also include=
s many
> other features, such as bandwidth, such as VPC information, etc. These ar=
e not
> within the scope of virtio, we cannot configure these information based o=
n the
> admin queue after creating the vf. But we can bind the device created by =
the
> user to vf, which completes the binding of many manufacturer features to =
vf.

It sounds like your device is vDPA. Anyhow, it looks like you need
provision vf and the virtio via vendor specific way. Then we don't
need to bother it in the spec.

>
> In addition to this scenario, in the case of live migration, we can migra=
te a vm
> from one host to another host. During this process, the virtio-net devce =
is also
> migrated from the dpu of one host to the dpu of another host . At this ti=
me, the
> purpose of creating a vf is to insert the migrated virtio-net into the ho=
st. It
> is impossible for us to create a vf to get a brand new device. So also bi=
nd.

If there's are states beyond the scope of virtio, trying to workaround
it in the spec seems sub-optimal.

>
> The core problem of this patch is that we need to assign an id to each de=
vice.
> Is this reasonable? I think this is reasonable, each device can have an i=
d.

Id seems to be fine but why bind is a must for the user? That looks
like two issues.

>
> Virtio device and transport can be unbound and re-bound.

This seems not to be supported by the spec at least now.

Thanks

>
> Thanks.
>
>
> >
> > --
> > MST
> >
> >
> > ---------------------------------------------------------------------
> > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> >
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

