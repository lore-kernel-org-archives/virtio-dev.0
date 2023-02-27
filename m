Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [PATCH 3/3] transport-pci: Relocate common config legacy
 interface
Date: Mon, 27 Feb 2023 03:07:41 +0000
Message-ID: <PH0PR12MB5481691F4FADD7A4660D849CDCAF9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230225223001.430522-1-parav@nvidia.com>
 <20230225223001.430522-4-parav@nvidia.com>
 <20230225181523-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230225181523-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Saturday, February 25, 2023 6:16 PM
>=20
> On Sun, Feb 26, 2023 at 12:30:01AM +0200, Parav Pandit wrote:
> > Relocate legacy interface section of common configuration structure
> > near where 1.x based common configuration structure is defined.
> >
> > This aligns the spec to follow rest of the other Legacy interfaces
> > section.
> >
> > Fixes: https://github.com/oasis-tcs/virtio-spec/issues/164
> > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > ---
> >  conformance.tex   |   3 +-
> >  transport-pci.tex | 186
> > +++++++++++++++++++++++-----------------------
> >  2 files changed, 95 insertions(+), 94 deletions(-)
> >
>=20
> I can't be bothered to check whether this actually just moves text around=
 or
> also changes a bunch of stuff on the way.
>=20
I will generate pdf after these each patch in this series to make sure that=
 no text is changed.

