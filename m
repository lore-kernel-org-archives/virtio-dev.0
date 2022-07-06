Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [virtio-dev] RE: [PATCH v5 0/7] Introduce device group and device
 management
Date: Wed, 6 Jul 2022 20:45:26 +0000
Message-ID: <PH0PR12MB54817E0D45D613834A3C42A4DC809@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220426225824.5918-1-mgurtovoy@nvidia.com>
 <20220705095514-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481D9416A601E6F2D4A32FFDC819@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220706061051-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220706061051-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Oren Duer <oren@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, "aadam@redhat.com" <aadam@redhat.com>, "virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Wednesday, July 6, 2022 7:00 AM

> > Reader and writer via different channel is really a hack.
> > It still doesn't help to have efficient hw.
> >
> > What is the technical reason to use feature bits which has strong relat=
ionships
> with device initialization sequence?
>=20
> The reason is it's a reasonably well understood mechanism, already addres=
sing
> questions like lifecycle, dependencies, extensibility.  For example, one =
might
> reasonably ask what happens if driver uses commands to change number of
> MSI-X vectors, then disables the capability bit related to relevant comma=
nds?
> Should device forget the allocated vectors? There's no longer a way to ch=
ange
> the allocation...
> If the set of allowed commands are locked in place until reset then it's =
clearer.
>=20
I can't think of a real use case why a driver would do something like this.
But say its done, it means that driver is not interested of assigning the M=
SI-X resource anymore from the AQ.
The PF driver did something nasty that it should well behave.
All configurations done stays as-is.

The first line of virtio spec introducing virtqueue is : " The mechanism fo=
r bulk data transport on virtio devices is pretentiously called a virtqueue=
".

This is no different than doing queue_reset on the AQ, what happens on the =
resource configuration done via AQ before reset?
What happens to packets and IO sent via virtio before the queue reset?
If virtqueue is destroyed and recreate.. things happened before cannot be r=
everted.
Same behavior when capabilities are switched off...
Device won't allow any new configuration.

This is matter of wording it...

This is important; I will get this text added in the v6.

> Again I am sure the specific question can be answered. But I would really=
 just like
> to see the admin queue proposal get finalized as quickly as possible, thi=
s means
> making compromizes to reuse as much of existing functionality as possible=
. And
> we can add extensions down the road.
>=20
We can add new capability command later, but there is no point duplicating =
the feature bit at that point.

> > The proposed bits are AQ functionality bits and not per_say device feat=
ure
> bits?
>=20
> Could not parse this sentence.
>=20
Meaning capabilities negotiated is about what all different config will hap=
pen via AQ.

> > This enables to build device in lot more flexible (and frankly simple w=
ay).
> > Looking at sw guest driver being simple to use existing limited 64-bits=
 is just
> one part of it.
>=20
> I'm not sure what does this refers to. What was suggested using e.g. feat=
ure bits
> 64 to 127, not stealing some of the 64 ones in use.
> All existing transports support doing that without adding any new transpo=
rt
> specific interfaces.
>=20
> Yes adding commands to tweak features might be benefitial.  I just sugges=
t
> splitting that out simply because this might or might not make sense for =
all
> features.  For example, a related common request is modifying feature bit=
s and
> generally some config space on the device side to facilitate migration ac=
ross
> devices with varying features.
> Should that be included in the proposal then?
>=20
> > And when AQ exists, most of the plumbing comes for free.
> > So I fail to see the simplicity benefit of overloading feature bits for=
 things that
> has no relation to device init sequence.
>=20
> Well most of feature bits are not *directly* tied to device init sequence=
.
Sure, but that was past. When feature bits introduced unrelated to device i=
nit sequence, at that time there was no AQ in the same spec update.
So it might have been fine then.

>=20
> The similicity just comes from reusing an existing mechanism so people do=
 not
> need to learn a new one.
>=20
I think the device efficiency weights more than driver code learning about =
AQ specific bits in generic device init sequence.

> Again I don't know what to do with this. I feel if it's put up for vote i=
n the current
> form it's likely to fail. I propose cutting out as much as possible as a =
first step, so
> we can make progress. Specifically the MSI-X commands are clearly PF spec=
ific
> so there's no concern about VF memory use at all.  We can worry about oth=
er
> types of command down the road when it becomes relevant.

Since feature bits proposes are limited to PF, I agree that current short c=
ut is fine to place in 64-127 feature bits.

When/if similar functionality is needed at scale for the VF or SIOV devices=
, placing them in 64-127 bits area weight way less for sake of "people fami=
liarity to feature bits".
Do you agree?

