Return-Path: <virtio-dev-return-12190-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E2ECC77B6E
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 05:38:15 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 7E4052B03C
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 05:38:14 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 53216986549
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 05:38:14 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 3A13798650E; Wed, 12 Apr 2023 05:38:14 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2706398650F
	for <virtio-dev@lists.oasis-open.org>; Wed, 12 Apr 2023 05:38:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: bQFBQ8DFNrSuoxI0a5_fvA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681277891; x=1683869891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KMwLQDRAHGf++cJcJ+1K7gQL0+Ucp6U72qMsCb3eKxg=;
        b=uz9ZTVkLWLIKSgZSbE9ofghRB17c8Hv3iuSRlt1/d035B9aQEEGVgdXTZdAEOJRcJS
         4u+savub5T9T01f9mjAmM9O31UvG6bg2eEByKoX2JqSj70PIao9fzJxk/Bf62Nvu+yoP
         JlDVhuDKuJ4Gj+oukD8YPuSh6VS6UM+l8jbQwyOEj+wUbAKOqpRgkINfjx6OtkwsTzGv
         Cj50TG/ImlSHb0rqtBfaHNM+TKy56p+TVhaOITYs+tXtS9/+yshxSzNVE9+JuVSSat2V
         00oUWZe9cbxx73BgZ2Nc6SR98SkGjhCKD5NZOiPjHXdPU7KOzbUATVT/oWSl9a1PGkaM
         Q3Yg==
X-Gm-Message-State: AAQBX9fb5TAu6yJoIDkx7yuN4AWLSugkFNJcYtETAm+ufDm+Rr3EWycQ
	o7QwIYtnb75EoVop7vfpkaamjtFLNfI0wt4iAPC23a9f9NX+l8ZulkVMWfgA14XVBBcI4kQcXzR
	z2eKZZjVbkkTIBso3DJGsbN62yFZu9XKf5ToxCa19ragQ
X-Received: by 2002:aca:2105:0:b0:37f:ab56:ff42 with SMTP id 5-20020aca2105000000b0037fab56ff42mr1295138oiz.9.1681277891329;
        Tue, 11 Apr 2023 22:38:11 -0700 (PDT)
X-Google-Smtp-Source: AKy350b3RtNrRrmrlXKpuQK6FqwWrL8TbPgPSZk2+gG9kuoWZrKAD5v3wZm3VSn6LZsYtSmF6/6OpBNMCdU87YY6UAU=
X-Received: by 2002:aca:2105:0:b0:37f:ab56:ff42 with SMTP id
 5-20020aca2105000000b0037fab56ff42mr1295129oiz.9.1681277891065; Tue, 11 Apr
 2023 22:38:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230330225834.506969-1-parav@nvidia.com> <20230330225834.506969-9-parav@nvidia.com>
 <CACGkMEtMOy4B-O-52ka+9P3OBQ_hs1KvdjWodNYg-XKLff+giw@mail.gmail.com>
 <307a9f8f-6184-0403-97ab-1b1c16d4fd3c@nvidia.com> <CACGkMEucOwwFDMqyWA+DgYV7X=9f5-P4Ba_AP=5kTsjna=n+7A@mail.gmail.com>
 <PH0PR12MB548194B46A3E32329C10D00EDC9A9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230411172207-mutt-send-email-mst@kernel.org> <CACGkMEsSxnn0+T6ng99HV-PwA3kEe6J050GNDKJjcjBQfQxbfA@mail.gmail.com>
 <20230412001803-mutt-send-email-mst@kernel.org> <CACGkMEtfFsiNVesHU=TWWPgDBzXw_49xrYujb42egMJPZg8__Q@mail.gmail.com>
 <20230412012356-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230412012356-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 12 Apr 2023 13:37:59 +0800
Message-ID: <CACGkMEuFtgw4E3ZORp+cKEZi_sf8m99Vn-JTeX=XuY3P7oNt9w@mail.gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>, 
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, 
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>, 
	Satananda Burla <sburla@marvell.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [virtio-comment] Re: [virtio-dev] [PATCH 08/11] transport-pci:
 Introduce virtio extended capability

On Wed, Apr 12, 2023 at 1:25=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, Apr 12, 2023 at 12:53:52PM +0800, Jason Wang wrote:
> > On Wed, Apr 12, 2023 at 12:20=E2=80=AFPM Michael S. Tsirkin <mst@redhat=
.com> wrote:
> > >
> > > On Wed, Apr 12, 2023 at 12:07:26PM +0800, Jason Wang wrote:
> > > > On Wed, Apr 12, 2023 at 5:25=E2=80=AFAM Michael S. Tsirkin <mst@red=
hat.com> wrote:
> > > > >
> > > > > On Tue, Apr 11, 2023 at 07:01:16PM +0000, Parav Pandit wrote:
> > > > > >
> > > > > > > From: virtio-dev@lists.oasis-open.org <virtio-dev@lists.oasis=
-open.org> On
> > > > > > > Behalf Of Jason Wang
> > > > > > > Sent: Monday, April 10, 2023 11:29 PM
> > > > > >
> > > > > > > > However, it is not backward compatible, if the device place=
 them in
> > > > > > > > extended capability, it will not work.
> > > > > > > >
> > > > > > >
> > > > > > > It is kind of intended since it is only used for new PCI-E fe=
atures:
> > > > > > >
> > > > > > New fields in new extended pci cap area is fine.
> > > > > > Migrating old fields to be present in the new extended pci cap,=
 is not your intention. Right?
> > > > > >
> > > > > > > "
> > > > > > > +The location of the virtio structures that depend on the PCI=
 Express
> > > > > > > +capability are specified using a vendor-specific extended ca=
pabilities
> > > > > > > +on the extended capabilities list in PCI Express extended co=
nfiguration
> > > > > > > +space of the device.
> > > > > > > "
> > > > > > >
> > > > > > > > To make it backward compatible, a device needs to expose ex=
isting
> > > > > > > > structure in legacy area. And extended structure for same c=
apability
> > > > > > > > in extended pci capability region.
> > > > > > > >
> > > > > > > > In other words, it will have to be a both places.
> > > > > > >
> > > > > > > Then we will run out of config space again?
> > > > > > No.
> > > > > > Only currently defined caps to be placed in two places.
> > > > > > New fields don=E2=80=99t need to be placed in PCI cap, because =
no driver is looking there.
> > > > > >
> > > > > > We probably already discussed this in previous email by now.
> > > > > >
> > > > > > > Otherwise we need to deal with the
> > > > > > > case when existing structures were only placed at extended ca=
pability. Michael
> > > > > > > suggest to add a new feature, but the driver may not negotiat=
e the feature
> > > > > > > which requires more thought.
> > > > > > >
> > > > > > Not sure I understand feature bit.
> > > > >
> > > > > This is because we have a concept of dependency between
> > > > > features but not a concept of dependency of feature on
> > > > > capability.
> > > > >
> > > > > > PCI transport fields existence is usually not dependent on uppe=
r layer protocol.
> > > > > >
> > > > > > > > We may need it even sooner than this because the AQ patch i=
s expanding
> > > > > > > > the structure located in legacy area.
> > > > > > >
> > > > > > > Just to make sure I understand this, assuming we have adminq,=
 any reason a
> > > > > > > dedicated pcie ext cap is required?
> > > > > > >
> > > > > > No. it was my short sight. I responded right after above text t=
hat AQ doesn=E2=80=99t need cap extension.
> > > > >
> > > > >
> > > > >
> > > > > You know, thinking about this, I begin to feel that we should
> > > > > require that if at least one extended config exists then
> > > > > all caps present in the regular config are *also*
> > > > > mirrored in the extended config. IOW extended >=3D regular.
> > > > > The reason is that extended config can be emulated more efficient=
ly
> > > > > (2x less exits).
> > > >
> > > > Any reason for it to get less exits?
> > >
> > > For a variety of reasons having to do with buggy hardware e.g. linux
> > > likes to use cf8/cfc for legacy ranges. 2 accesses are required for e=
ach
> > > read/write.  extended space is just 1.
> > >
> >
> > Ok.
> >
> > >
> > > > At least it has not been done in
> > > > current Qemu's emulation. (And do we really care about the performa=
nce
> > > > of config space access?)
> > > >
> > > > Thanks
> > >
> > > For boot speed, yes. Not minor 5% things but 2x, sure.
> >
> > If we care about boot speed we should avoid using the PCI layer in the
> > guest completely.
> >
> > Thanks
>
> Woa. And do what? Add a ton of functionality in a PV way to MMIO?

Probably, we have microVM already. And hyperv drops PCI since Gen2.

> NUMA, MSI, power management .... the list goes on and on.
> If you have pci on the host it is way easier to pass that
> through to guest than do a completely different thing.

It's a balance. If you want functionality, PCI is probably a must. But
if you care about only the boot speed, the boot speed is not slowed
down by a single device but the whole PCI layer.

Thanks

>
> --
> MST
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

