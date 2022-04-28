Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [virtio-dev] [PATCH v2] virtio: Improve queue_reset polarity to
 match to default reset state
Date: Thu, 28 Apr 2022 01:49:38 +0000
Message-ID: <PH0PR12MB5481BFEF514B5D7E7B4ED085DCFD9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220427102559.305669-1-parav@nvidia.com>
 <20220427163003-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220427163003-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>



> From: virtio-dev@lists.oasis-open.org <virtio-dev@lists.oasis-open.org> O=
n
> Behalf Of Michael S. Tsirkin
> On Wed, Apr 27, 2022 at 01:25:59PM +0300, Parav Pandit wrote:
> > Signed-off-by: Parav Pandit <parav@nvidia.com>
>=20
> Parav, spec comments need to be posted to virtio-comment please.
>=20
I missed it, you said previously too.
Added now starting this email and v3.


> >  The device MUST reset the queue when 1 is written to
> > \field{queue_reset}, and -present a 1 in \field{queue_reset} after the
> > queue has been reset, until the
> > +present 0 in \field{queue_reset} after the queue has been reset,
>=20
> ... ok
>=20
> > until the
> >  driver re-enables the queue via \field{queue_enable} or the device is
> reset.
>=20
> this part is just confusing. neither reset nor queue_enable will set
> queue_reset.
> just drop it?
>=20
Yeah.
I took Cornelia's suggested draft and rewrote the device and driver side de=
scription.

> > +\field{queue_reset} to reset the queue, driver MUST verify that the
> > +queue has been reset by reading back \field{queue_reset} until device
> returns a value of 0.
> > +Device continue
>=20
> continues
>=20
> > to report
>=20
> we say present elsewhere, let's be consistent
>=20
> > value of 1 for the \field{queue_reset} until device finishes
> > +the queue reset request.
>=20
> I'd just say "until after queue reset" consistent with what we say elsewh=
ere.
>=20
> > When the device completes the queue reset, \field{queue_reset}
> > +and \field{queue_enable} set to zero
>=20
> are set to 0
>=20
> >, indicating
> > +that specified queue is ready to be enabled again. The driver MAY
> > +re-enable the queue by writing 1 to
>=20
> the part describing how the device works should be moved to the device
> section and be more specific with MUST/MAY.
>=20
> > +\field{queue_enable} after ensuring that other virtqueue fields have
> >  been set up correctly. The driver MAY set driver-writeable queue
> > configuration  values to different values than those that were used bef=
ore
> the queue reset.
> >  (see \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtq=
ueue
> Reset}).
> > @@ -2015,7 +2018,7 @@ \subsection{MMIO Device Register
> > Layout}\label{sec:Virtio Transport Options / Vi
>=20
> same comments below.
>=20

All above comments are taken care now with Cornelia's wording for your inpu=
t and by correctly updating device side section now.
Sending v3.
Thanks.

