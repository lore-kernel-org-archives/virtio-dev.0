Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [virtio-dev] [PATCH v3 06/20] virtio-mem-balloon: Maintain mem
 balloon device spec in separate directory
Date: Wed, 11 Jan 2023 16:01:42 +0000
Message-ID: <PH0PR12MB5481F8DF03266EA84A2C3D2BDCFC9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230110230358.528098-1-parav@nvidia.com>
 <20230110230358.528098-7-parav@nvidia.com>
 <b95d3aab-21c0-8256-a8bd-09e5b45cd206@redhat.com>
 <PH0PR12MB54814D2E4FAABC0A72EA5CE3DCFC9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <c3d29199-df2a-6a13-e88c-b52d20fa04ff@redhat.com> <87sfghvzd0.fsf@redhat.com>
In-Reply-To: <87sfghvzd0.fsf@redhat.com>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Cornelia Huck <cohuck@redhat.com>
> Sent: Wednesday, January 11, 2023 10:57 AM
>=20
> On Wed, Jan 11 2023, David Hildenbrand <david@redhat.com> wrote:
>=20
> > On 11.01.23 16:01, Parav Pandit wrote:
> >> Hi David,
> >
> > Hi Parav,
> >
> >>
> >>> From: David Hildenbrand <david@redhat.com>
> >>> Sent: Wednesday, January 11, 2023 9:14 AM
> >>> To: Parav Pandit <parav@nvidia.com>; mst@redhat.com;
> >>> virtio-dev@lists.oasis- open.org; cohuck@redhat.com
> >>> Cc: virtio-comment@lists.oasis-open.org
> >>> Subject: Re: [virtio-dev] [PATCH v3 06/20] virtio-mem-balloon:
> >>> Maintain mem balloon device spec in separate directory
> >>>
> >>> On 11.01.23 00:03, Parav Pandit wrote:
> >>>> Move virtio memory balloon device specification to its own file
> >>>> similar to recent virtio devices.
> >>>> While at it, place device specification, its driver and device
> >>>> conformance into its own directory to have self contained device
> >>>> specification.
> >>>>
> >>>> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/153
> >>>> Signed-off-by: Parav Pandit <parav@nvidia.com>
> >>>>
> >>>
> >>> There is virtio-mem and there is virtio-balloon. Calling
> >>> virtio-balloon "virtio- mem-balloon" can easily lead to quite some
> >>> confusion. Any particular reason why not to stick to "virtio-balloon"=
 ?
> >>>
> >> Historically Linux memory balloon driver in linux is placed as
> >> virtio_balloon.c
> >
> > See below. id=3D5 has widespread "virtio-balloon" terminology use. id=
=3D13
> > is what creates confusion.
> >
> >> In virtio spec, in the device type is it named as "Traditional memory =
balloon
> device".
> >> So, I named the directory name close to actual spec content name.
> >> Adding legacy/traditional was too long. :) May be virtio-mem-legacy
> >> is better to differentiate between legacy and new mem device?
> >
> > As it has nothing to do with virtio-mem, that would be confusing.
> > Also, legacy doesn't quite catch the semantics.
>=20
> Indeed, "Traditional" !=3D "legacy".
>=20
> >
> >>
> >> In this patchset, directories are named with "virtio-" prefix such as =
virtio-
> pmem, virtio-sound.
> >>
> >> Another option (which I prefer as I write now) is, How about we drop
> >> "virtio-" prefix in the directory name because this is the virtio spec=
.
> >>
> >> And have names as
> >> device-types/sound
> >> device-types/legacy-mem-balloon
> >> device-types/mem
> >> device-types/pmem
> >>
> >> This is short and covers balloon part too?
> >
> > Looking at
> > https://lore.kernel.org/all/20220516204913.542894-71-mst@redhat.com/
> >
> > We seem to have virtio-balloon (id=3D5) and virtio-mem-balloon (if=3D13=
).
> >
> > virtio-balloon is what's actually implemented and used. "Traditional"
> > is a bit misleading here.
> >
> > IMHO, we could/should
> >
> > * Name it "balloon" here
> > * Make "id=3D13" reserved and remove the notion of "memory balloon" fro=
m
> >    the spec
> > * Call "id=3D5" "Memory Balloon" and remove the notion of "Traditional"=
.
> >    It's the one that exists.
>=20
> I think the "Traditional" came from the idea that we eventually wanted to=
 come
> up with a new ballooner that doesn't come with any legacy baggage that th=
e
You meant "traditional baggage" and not "legacy baggage"?

> current ballooner might have. AFAIK, that idea has been abandoned in the
> years since we introduced virtio-1, nobody has proposed something for id =
13.
> Your suggestion makes sense to me, but we probably should do it on top of=
 the
> patch set here.
>=20
> For this series, using virtio-balloon for the file name makes the most se=
nse to
> me.
Can you please explain this?
The spec description for this device is " Traditional Memory Balloon Device=
".
So why do you want to drop the "memory" part of it? Can it balloon non memo=
ry resources?
Or is it to avoid confusion with device id 24?

Also, I want to drop the prefix "virtio_" in the directory names.
Any opinion on that?
Dropping and adding back will be too labor intensive.
So, want to settle down on that before sending v4.

