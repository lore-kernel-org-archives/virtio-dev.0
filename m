Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [PATCH v3 1/2] virtio-net: Describe dev cfg fields read only
Date: Thu, 23 Feb 2023 05:50:07 +0000
Message-ID: <PH0PR12MB548196EE7943A0388E52AB02DCAB9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230217154529.33508-2-parav@nvidia.com>
 <87wn4byqqb.fsf@redhat.com> <20230221124013-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481AC76D8FDB8E53956EAE4DCA59@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230221125057-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54815BA778BE4039755B7D6FDCA59@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230221130713-mutt-send-email-mst@kernel.org> <87356yaxaz.fsf@redhat.com>
 <20230222064936-mutt-send-email-mst@kernel.org> <87wn49aopg.fsf@redhat.com>
 <20230222075157-mutt-send-email-mst@kernel.org> <87ttzdal0p.fsf@redhat.com>
In-Reply-To: <87ttzdal0p.fsf@redhat.com>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Cornelia Huck <cohuck@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>



> From: Cornelia Huck <cohuck@redhat.com>
> Sent: Wednesday, February 22, 2023 8:27 AM

> > We can just skip adding a new requirement completely - we'll never get
> > there with a compliant driver.  This is what we do e.g. for MMIO.
> > Why not?
>=20
> That would be fine with me as well.
>=20
> > This has an advantage as this allows backing config with regular RAM.
> > Also I feel that since it always said "read only for driver" then this
> > implies a restriction on driver not the device.
>=20
> Indeed. The normative statement below should be enough to make that "read=
-
> only for the driver" thing obvious.
>=20
> >
> >> >
> >> >
> >> >> >
> >> >> >>
> >> >> >> Driver section:
> >> >> >> Driver must not write to read-only fields.
> >> >>
> >> >> "The driver MUST NOT write to any config space field."

I addressed the comments in v4 at [1].

[1] https://lists.oasis-open.org/archives/virtio-dev/202302/msg00523.html
Please review.

