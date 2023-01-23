Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [PATCH] virtio-net: Improve control vq introductory description
Date: Mon, 23 Jan 2023 12:21:54 +0000
Message-ID: <PH0PR12MB5481FA4749D7BD558F210E64DCC89@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230123011651.804147-1-parav@nvidia.com>
 <87cz75cvyd.fsf@redhat.com>
In-Reply-To: <87cz75cvyd.fsf@redhat.com>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Cornelia Huck <cohuck@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>



> From: Cornelia Huck <cohuck@redhat.com>
> Sent: Monday, January 23, 2023 6:49 AM
>=20
> On Mon, Jan 23 2023, Parav Pandit <parav@nvidia.com> wrote:
>=20
> > The control VQ of the virtio network device is used for controlling
> > multiple features, not just advanced steering control. The control VQ
> > dynamically changes multiple features of the initialized device.
> >
> > Hence, update this area of control VQ introductory description.
> >
> > This patch is on top of [1].
> >
> > [1]
> > https://lists.oasis-open.org/archives/virtio-dev/202301/msg00272.html
>=20
> [Side note: better put notes like that beneath the "---" delimiter, so th=
at they
> don't end up in the changelog, where they won't be of much interest anymo=
re.]
>
Yes. will do in v1.
=20
[..]
> I think that whole paragraph needs some editing; apart from your card/dev=
ice
> terminology change, it hasn't seem updates in ages.
>=20
> - the "most complex device supported so far" half sentence, while not
>   untrue, doesn't really add much to the understanding of what the net
>   device does
> - same for the "It has enhanced rapidly..." statement
> - more importantly, it still talks about single receive/transmit queues,
>   while multiqueue has been specified for ages; this also makes the "A
>   third command queue" statement a bit confusing
>=20
> What about generalizing this change to a "virtio-net: Improve introductor=
y
> description" update to something like the following, copying the purpose =
of the
> control queue from the description further
> below:
>=20
> "The virtio network device is a virtual ethernet device with a complex an=
d
> configurable set of features. One or more pairs of virtqueues are used fo=
r
> receiving and transmitting packets: Empty buffers are placed in the first
> virtqueue of the pair for receiving packets, and outgoing packets are enq=
ueued
> into the other for transmission. An optional command queue is used to
> dynamically manipulate various features of the initialized device which w=
ould
> not easily map into the configuration space."

Yes, even better.
Will send v1 with proposed changes and on top of previous patch.

