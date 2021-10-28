Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [virtio-dev] RE: [PATCH v2] Add device reset timeout field
Date: Thu, 28 Oct 2021 06:06:23 +0000
Message-ID: <PH0PR12MB5481F984DDD2F3228A128CFADC869@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <CACGkMEthjkX3pV+1L9Eg-nJOArSUfmDRY8UCK_2LJ7-oxO6SpQ@mail.gmail.com>
 <DM8PR12MB548048016A0311F809BF0E67DCB99@DM8PR12MB5480.namprd12.prod.outlook.com>
 <CACGkMEuP6nZCSyz8piHYdMzwSKGgZbn65SBx486C-Lm2jbw5TA@mail.gmail.com>
 <PH0PR12MB5481C32F9D9A54AFA4E337A3DC809@PH0PR12MB5481.namprd12.prod.outlook.com>
 <2984c445-a7fd-97c4-34aa-3a40778a0fcd@redhat.com>
 <PH0PR12MB54810528108E4EB12CC1C401DC839@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtBJavHQr2SaMiz8TSTt-fCsm3WoJMfRYEO=dr-=Ld-1Q@mail.gmail.com>
 <PH0PR12MB54818FC7BD40A16F656CAE90DC859@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211027040559-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481CEC3BB8BB3EC0B0A368BDC869@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211028014301-mutt-send-email-mst@kernel.org>
In-Reply-To: <20211028014301-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Cornelia Huck <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Max Gurtovoy <mgurtovoy@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Thursday, October 28, 2021 11:21 AM
>=20
> On Thu, Oct 28, 2021 at 04:01:52AM +0000, Parav Pandit wrote:
> > >   how it looks like, whether there is a timeout is
> > >   a separate question.
> >
> > > E.g. a read counter sounds
> > >   more generic, if device is stuck it can just stop
> > >   incrementing it.
> > This is not scalable solution for hundreds of devices and it breaks the=
 layering
> too.
> > A virtio layer itself is not in up_state to perform counter update.
> > A non virtio layer is expected to implement this counter. This is not r=
ight.
>=20
> Donnu what does the above mean. My point is simple: there's little differ=
ence
> between device being stuck during firmware boot and device being stuck ri=
ght
> after boot.
Virtio functionality is something to be implemented by the virtio layer in =
the device.
When the device is booting, virtio layer may not have yet booted to update =
this counter. (device is not stuck).
Some other layer before the virtio layer within the device is asked to impl=
ement virtio counters.

And hence it incorrect to have such counter to indicate that the device is =
booting.

A init bit is good enough to indicate that initialization has not yet finis=
hed. When the virtio layer is booted in the device, it can connect to this =
layer to update about its init status.
This is far more scalable and don't break layers.

Secondly, a free flowing counter implementation for tens of hundreds of dev=
ices doesn't scale in pre-init stage.

