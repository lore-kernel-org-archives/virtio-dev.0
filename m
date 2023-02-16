Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [PATCH] changelog: Fix missing reference to driver notifications
Date: Thu, 16 Feb 2023 21:13:12 +0000
Message-ID: <PH0PR12MB54812E87A2EE7C14D72C3FE2DCA09@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230216053457.414126-1-parav@nvidia.com>
 <87ttzm9gz0.fsf@redhat.com>
In-Reply-To: <87ttzm9gz0.fsf@redhat.com>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Cornelia Huck <cohuck@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Cornelia Huck <cohuck@redhat.com>
> Sent: Thursday, February 16, 2023 3:01 AM
>=20
> On Thu, Feb 16 2023, Parav Pandit <parav@nvidia.com> wrote:
>=20
> > Cited commit in fixes tag missed to update the reference to drivers
> > notifications section in past change log.
> > Fix the reference.
> >
> > Fixes: be2ce1ee17e0 ("content.tex Fix Driver notifications label")
> > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > ---
> >  cl-os.tex | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> Does it really make sense to patch the changelog? This is about the
> 1.1->1.2 changes, and I'd assume it is only relevant for the released
> 1.2 spec. We'll replace the changelog anyway when we do the 1.3 release.
>
Right. I got it.
It should be fine to drop this patch.
I took a blind scan to make sure all the previous links exists now.
It isn't necessary from 1.2 to 1.3 as those entries will be removed as you =
say.
=20
> [Speaking of the 1.3 release, we really should be planning for it. Maybe =
target
> June or so, with a freeze in April?]
Very good point. Yes.
Not fully familiar yet, if its June end, may be May is alright too dependin=
g on changes in coming months.
I am sure you and Michael are better place to make this call.

