Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [PATCH] content.tex Fix Driver notifications label
Date: Wed, 15 Feb 2023 05:31:22 +0000
Message-ID: <PH0PR12MB54815C7D5C3E545CD9DDDE84DCA39@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230203183532.90685-1-parav@nvidia.com>
 <87k00p9331.fsf@redhat.com>
In-Reply-To: <87k00p9331.fsf@redhat.com>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Cornelia Huck <cohuck@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Cornelia Huck <cohuck@redhat.com>
> Sent: Friday, February 10, 2023 6:23 AM
> To: Parav Pandit <parav@nvidia.com>; mst@redhat.com; virtio-
> dev@lists.oasis-open.org
> Cc: virtio-comment@lists.oasis-open.org; Shahaf Shuler
> <shahafs@nvidia.com>; Parav Pandit <parav@nvidia.com>
> Subject: Re: [PATCH] content.tex Fix Driver notifications label
>=20
> On Fri, Feb 03 2023, Parav Pandit <parav@nvidia.com> wrote:
>=20
> > Driver notifications section is under "Basic Facilities of a Virtio
> > Device". However, the label is placed under "Virtqueues" section.
> >
> > Fix the label references.
> >
> > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > ---
> >  content.tex | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
>=20
> Not sure if it was originally intended to sit unter the virtqueues sectio=
n (it was
> lifted up one level as it disappeared under the packet ring section), mig=
ht have
> been.
>=20
> It probably makes sense to not try and move it back into the virtqueues s=
ection,
> and instead do your change. Other opinions?

If there is none, can you please proceed to complete the review?
I assume this editorial fix doesn't need github issue.

Once this fix is in place, I would like to bring Notifications and driver N=
otifications sections close to each other as it has overlapping parts.=20

