Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [PATCH v3 1/4] Add virtio Admin virtqueue
Date: Tue, 8 Feb 2022 07:04:12 +0000
Message-ID: <PH0PR12MB548104AB80FA36544DB3D7D0DC2D9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220203075716.11684-1-mgurtovoy@nvidia.com>
 <20220203075716.11684-2-mgurtovoy@nvidia.com>
 <20220207052843-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548164CFE929F59EEDBD3557DC2D9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220208014039-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220208014039-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>, "stefanha@redhat.com" <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Tuesday, February 8, 2022 12:13 PM

> On Tue, Feb 08, 2022 at 06:25:41AM +0000, Parav Pandit wrote:
> >
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Monday, February 7, 2022 4:09 PM
> > >
> > > Next, trying to think about scalable iov extensions. So we will have
> > > groups of VFs and then SFs as the next level.
> > > How does one differentiate between the two?
> > > Maybe reserve a field for "destination type"?
> > >
> > We already discussed this in v2.
> > SF will have different identification than 16-bits. And no one knows wh=
at
> that would be.
> > We just cannot reserve some arbitrary bytes for unknown.
> > You suggested in v2 to reserve 4 bytes for sf_id, and I explained you t=
hat 4
> bytes may not be enough.
> >
> > Whether SFs are on top of VFs or SFs are on top of PFs or both is compl=
etely
> different spec.
> > Whether PF will manage SFs of the VFs or it will be done nested manner =
by
> VF etc is a completely different discussion than what is being proposed h=
ere.
> > Whether PF will manage the SF is yet another big question. We work with
> users and they dislike this.
> > To address it, some OS has a different management interface (not visibl=
e to
> PF) for SF life cycle even though SFs are anchored on a PF.
> >
> > So SF/iov extension discussion has long way to go for community to firs=
t
> understand the use cases before crafting some extension.
> >
> > So lets not complicate and mix things here for a blurry definition of s=
calable
> iov/sf extension.
>=20
> Some reserved bytes won't hurt. 2 bytes for type gives us 64k types, soun=
ds like
> that should be enough.
It doesn't stop there.
Mentioning some destination type, interrupt type, etc also requires reservi=
ng bytes for different device id type, interrupt type and more.
We past this stage long ago after discussing this in v1 at [1].
It is just better and cleaner to define a different structure to describe S=
F/iov and its configuration.

[1] https://markmail.org/search/?q=3DAdd+virtio+Admin+Virtqueue+specificati=
on&q=3Dlist%3Aorg.oasis-open.lists.virtio-dev#query:Add%20virtio%20Admin%20=
Virtqueue%20specification%20list%3Aorg.oasis-open.lists.virtio-dev+page:2+m=
id:ncyxqhjlvusjfust+state:results

