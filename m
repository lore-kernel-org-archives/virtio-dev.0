Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [PATCH v2] virtio-net: Define configuration field layout before
 its description
Date: Fri, 17 Feb 2023 14:03:47 +0000
Message-ID: <PH0PR12MB54818B17FF02B47F4DCFB45ADCA19@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230209045228.212309-1-parav@nvidia.com>
 <20230217041616-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230217041616-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Friday, February 17, 2023 4:29 AM
>=20
> I think it's ok that this combines text movement and rewording. Splitting=
 up
> would have made very small patches.

Yes. the description modified is linked to the structure change. Hence, it =
was in one patch.
But will relook again if there is logical boundary that I can use to split.

> In fact something I think applies to other contributions too.
> But please do reflect it in the subject.
> Something like "config field layout reorg" would better describe what is =
going
> on.
>=20
> Also pls try to keep subject line length below 50 characters.
> Abbreviation is ok there.
>=20
Ok. will do.

> > -Device configuration fields are listed below, they are read-only for
> > a driver. The \field{mac} address field -always exists (though is only
> > valid if VIRTIO_NET_F_MAC is set), and -\field{status} only exists if
> > VIRTIO_NET_F_STATUS is set. Two -read-only bits (for the driver) are
> currently defined for the status field:
> > -VIRTIO_NET_S_LINK_UP and VIRTIO_NET_S_ANNOUNCE.
> > +The network device has the following device configuration layout.
> > +These device configuration fields are read-only for the driver.
>=20
> First time we are mentioning fields, which "These"?
> Really this sentence is part of field description so I feel it should com=
e after the
> structure.
Make sense.

> And I feel read-only part needs more stress.
> Maybe "All device configuration fields are read-only for the driver"?

Ok.
> Maybe add a driver conformance statement too?
>=20
Will add.

And once reviewed will raise for vote as you explained in other thread.

