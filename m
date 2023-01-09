Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [virtio-comment] [PATCH v1 13/20] virtio-rpmb: Maintain rpmb
 device spec in separate directory
Date: Mon, 9 Jan 2023 14:08:46 +0000
Message-ID: <PH0PR12MB548166AEA5215A6DF55E45A4DCFE9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230101180824.325172-1-parav@nvidia.com>
 <20230101180824.325172-14-parav@nvidia.com> <874jszeuw4.fsf@redhat.com>
 <20230109083413-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230109083413-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Monday, January 9, 2023 8:36 AM
>=20
> On Mon, Jan 09, 2023 at 01:48:27PM +0100, Cornelia Huck wrote:
> > On Sun, Jan 01 2023, Parav Pandit <parav@nvidia.com> wrote:
> >
> > > Place device specification, its driver and device conformance into
> > > its own directory to have self contained device specification.
> > >
> > > Fixes: https://github.com/oasis-tcs/virtio-spec/issues/153
> > > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > > ---
> > > changelog:
> > > v0->v1:
> > > - new patch
> > > ---
> > >  conformance.tex                               | 23 ++---------------=
--
> > >  content.tex                                   |  1 -
> > >  .../virtio-rpmb/device-conformance.tex        | 13 +++++++++++
> > >  .../virtio-rpmb/device.tex                    |  0
> > >  .../virtio-rpmb/driver-conformance.tex        |  7 ++++++
> > >  5 files changed, 22 insertions(+), 22 deletions(-)  create mode
> > > 100644 device-types/virtio-rpmb/device-conformance.tex
> > >  rename virtio-rpmb.tex =3D> device-types/virtio-rpmb/device.tex
> > > (100%)  create mode 100644
> > > device-types/virtio-rpmb/driver-conformance.tex
> > >
> >
> > (...)
> >
> > > diff --git a/content.tex b/content.tex index a486e36..13a2a94 100644
> > > --- a/content.tex
> > > +++ b/content.tex
> > > @@ -3014,7 +3014,6 @@ \chapter{Device Types}\label{sec:Device Types}
> > > \import{device-types/virtio-crypto/}{device}
> > >  \import{device-types/virtio-vsock/}{device}
> > >  \import{device-types/virtio-fs/}{device}
> > > -\input{virtio-rpmb.tex}
> >
> > This is missing
> >
> > \import{device-types/virtio-rpmb/}{device}
> >
> > (I noticed broken references when building with the patches applied)
>=20
>=20
> Oh, good catch. Parav, I'd really like patch submitters to run the build =
and
> review the resulting files.
I did the build and generated the pdf.
But for sure missed several of the entries.
I am finding out why I missed this and saw valid entries.

I am revising the series v2.

> I guess we should withdraw the ballot for now and wait until a fixed vers=
ion.
> Agree?
>=20
> > >  \input{virtio-iommu.tex}
> > >  \input{virtio-sound.tex}
> > >  \input{virtio-mem.tex}

