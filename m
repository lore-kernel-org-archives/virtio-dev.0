Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [PATCH v3 1/4] Add virtio Admin virtqueue
Date: Tue, 8 Feb 2022 13:32:12 +0000
Message-ID: <PH0PR12MB54816EBF061770CC91E0435DDC2D9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220203075716.11684-1-mgurtovoy@nvidia.com>
 <20220203075716.11684-2-mgurtovoy@nvidia.com>
 <20220207052843-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548164CFE929F59EEDBD3557DC2D9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220208014039-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548104AB80FA36544DB3D7D0DC2D9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <878rulv6kq.fsf@redhat.com>
In-Reply-To: <878rulv6kq.fsf@redhat.com>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Cornelia Huck <cohuck@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>, "stefanha@redhat.com" <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Cornelia Huck <cohuck@redhat.com>
> Sent: Tuesday, February 8, 2022 6:50 PM
>=20
> On Tue, Feb 08 2022, Parav Pandit <parav@nvidia.com> wrote:
>=20
> >> From: Michael S. Tsirkin <mst@redhat.com>
> >> Sent: Tuesday, February 8, 2022 12:13 PM
> >
> >> On Tue, Feb 08, 2022 at 06:25:41AM +0000, Parav Pandit wrote:
> >> >
> >> > > From: Michael S. Tsirkin <mst@redhat.com>
> >> > > Sent: Monday, February 7, 2022 4:09 PM
> >> > >
> >> > > Next, trying to think about scalable iov extensions. So we will
> >> > > have groups of VFs and then SFs as the next level.
> >> > > How does one differentiate between the two?
> >> > > Maybe reserve a field for "destination type"?
> >> > >
> >> > We already discussed this in v2.
> >> > SF will have different identification than 16-bits. And no one
> >> > knows what
> >> that would be.
> >> > We just cannot reserve some arbitrary bytes for unknown.
> >> > You suggested in v2 to reserve 4 bytes for sf_id, and I explained
> >> > you that 4
> >> bytes may not be enough.
> >> >
> >> > Whether SFs are on top of VFs or SFs are on top of PFs or both is
> >> > completely
> >> different spec.
> >> > Whether PF will manage SFs of the VFs or it will be done nested
> >> > manner by
> >> VF etc is a completely different discussion than what is being propose=
d here.
> >> > Whether PF will manage the SF is yet another big question. We work
> >> > with
> >> users and they dislike this.
> >> > To address it, some OS has a different management interface (not
> >> > visible to
> >> PF) for SF life cycle even though SFs are anchored on a PF.
> >> >
> >> > So SF/iov extension discussion has long way to go for community to
> >> > first
> >> understand the use cases before crafting some extension.
> >> >
> >> > So lets not complicate and mix things here for a blurry definition
> >> > of scalable
> >> iov/sf extension.
> >>
> >> Some reserved bytes won't hurt. 2 bytes for type gives us 64k types,
> >> sounds like that should be enough.
> > It doesn't stop there.
> > Mentioning some destination type, interrupt type, etc also requires res=
erving
> bytes for different device id type, interrupt type and more.
> > We past this stage long ago after discussing this in v1 at [1].
> > It is just better and cleaner to define a different structure to descri=
be SF/iov
> and its configuration.
>=20
> I have the feeling that we might be overcomplicating this. We have some
> groups of targets (a device, a group, that more complicated SF thingy), a=
nd we
> want to distinguish between them. That's easy enough to cover via some ki=
nd of
> enum-equivalent (0 =3D=3D same dev, 1 =3D=3D target a dev id, 2 =3D=3D ta=
rget a group id, 3
> =3D=3D multi-layer target) and some spec how 1 and 2 should look like (as=
 I'd expect
> them to be common for many different things).=20
Do we have a concrete example of a command that can be targeted for same de=
vice and a target device, which requires differentiating their destination?=
 If so, lets discuss and then it make sense to add for the well-defined use=
 case.

> The SF thingy can be covered
> by 3, and we'll probably want to make that one command-specific, as the w=
hole
> setup does not have enough things we can standardize on.
This comment has underlying assumption that there are nested layers. And th=
at assumption may not be true at all.
At least for iov extension of intel and SF of Mellanox (already open source=
 for 1+ year) doesn't have the nested layers as today as far as I understan=
d.

>=20
> Does that make sense? This standardizes the simpler setups, and gives eno=
ugh
> flexibility for the more complicated ones. If we have another simpler set=
up in
> the future, it can become type 4, 5, etc.
I feel that without a use case we are over complicating the commands by int=
roducing group/target id etc.

So better to first come up with a valid use case and a device that supports=
 it, which needs a group.
Otherwise a target id can be a long string of PCI device =3D 0000:03:00.0 o=
r a BDF or a VF number or a VF of a different PCI PF or a SF number 32-bit =
or SF UUID or a VF on a remote DPU system or PCI device on transparent brid=
ge or something else.

Without knowing the grouping and a nonexistence device we shouldn't complic=
ate the commands.

There are enough opcodes (64K) that can define new structure for more compl=
ex devices.

