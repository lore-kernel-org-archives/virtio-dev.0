Return-Path: <virtio-comment-return-3792-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Parav Pandit <parav@nvidia.com>
Date: Wed, 11 Jan 2023 13:40:26 +0000
Message-ID: <PH0PR12MB5481114D80FD0F83C96DC215DCFC9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230110230358.528098-1-parav@nvidia.com>
 <20230110230358.528098-20-parav@nvidia.com> <87y1q9wdgs.fsf@redhat.com>
In-Reply-To: <87y1q9wdgs.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-comment] RE: [PATCH v3 19/20] virtio-gpio: Maintain gpio device spec in
 separate directory
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Cornelia Huck <cohuck@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Cornelia Huck <cohuck@redhat.com>
> Sent: Wednesday, January 11, 2023 5:52 AM
>=20
> On Wed, Jan 11 2023, Parav Pandit <parav@nvidia.com> wrote:
>=20
> > Place device specification, its driver and device conformance into its
> > own directory to have self contained device specification.
> >
> > Fixes: https://github.com/oasis-tcs/virtio-spec/issues/153
> > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > ---
> > changelog:
> > v2->v3:
> > - file name changed from device.tex to description.tex
> > - use input instead of import to insert a file
> > v1->v2:
> > - added missing device conformance reference
> > v0->v1:
> > - new patch
> > ---
> >  conformance.tex                               | 22 ++-----------------
> >  content.tex                                   |  4 ++--
> >  .../virtio-gpio/description.tex               |  0
> >  .../virtio-gpio/device-conformance.tex        |  9 ++++++++
> >  .../virtio-gpio/driver-conformance.tex        |  9 ++++++++
> >  5 files changed, 22 insertions(+), 22 deletions(-)  rename
> > virtio-gpio.tex =3D> device-types/virtio-gpio/description.tex (100%)
> > create mode 100644 device-types/virtio-gpio/device-conformance.tex
> >  create mode 100644 device-types/virtio-gpio/driver-conformance.tex
>=20
> (...)
>=20
> > diff --git a/content.tex b/content.tex index 977a2cd..bc67e63 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -3020,8 +3020,8 @@ \chapter{Device Types}\label{sec:Device Types}
> > \input{device-types/virtio-mem/description.tex}
> >  \input{device-types/virtio-i2c/description.tex}
> >  \input{device-types/virtio-scmi/description.tex}
> > -\input{virtio-gpio.tex}
> > -\input{virtio-pmem.tex}
> > +\input{device-types/virtio-gpio/description.tex}
> > +\input{device-types/virtio-pmem/description.tex}
>=20
> The virtio-pmem change should have gone into the following patch?
>=20
It should be in next patch.
The rebasing messed this up.
Bisection is important. Let me fix it.

> (We don't really care about bisectability, so not a big deal; but somethi=
ng that
> should be fixed if a respin is needed.)

This publicly archived list offers a means to provide input to the=0D
OASIS Virtual I/O Device (VIRTIO) TC.=0D
=0D
In order to verify user consent to the Feedback License terms and=0D
to minimize spam in the list archive, subscription is required=0D
before posting.=0D
=0D
Subscribe: virtio-comment-subscribe@lists.oasis-open.org=0D
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org=0D
List help: virtio-comment-help@lists.oasis-open.org=0D
List archive: https://lists.oasis-open.org/archives/virtio-comment/=0D
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf=
=0D
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lis=
ts=0D
Committee: https://www.oasis-open.org/committees/virtio/=0D
Join OASIS: https://www.oasis-open.org/join/

