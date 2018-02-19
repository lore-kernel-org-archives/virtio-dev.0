Return-Path: virtio-dev-return-3236-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 8217D58191B1
	for <virtio-dev@lists.oasis-open.org>; Mon, 19 Feb 2018 05:11:46 -0800 (PST)
Date: Mon, 19 Feb 2018 14:11:39 +0100
From: =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>
Message-ID: <20180219141139.14e0a9d9@fiorina>
In-Reply-To: <20180214000454-mutt-send-email-mst@kernel.org>
References: <cover.1512476043.git.tgolembi@redhat.com>
	<938dc32019864c9c19259bdddd64a53b6b99efef.1512476043.git.tgolembi@redhat.com>
	<20180205130824.79f570bc@fiorina>
	<1e6717d5-a1bc-3409-b01f-24ea761659fb@oracle.com>
	<20180214000454-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [Qemu-devel] [PATCH v2 1/1] virtio-balloon: include statistics
 of disk/file caches
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jonathan Helman <jonathan.helman@oracle.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, Wei Wang <wei.w.wang@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, 14 Feb 2018 00:07:53 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Tue, Feb 13, 2018 at 12:29:39PM -0800, Jonathan Helman wrote:
> >=20
> >=20
> > On 02/05/2018 04:08 AM, Tom=C3=A1=C5=A1 Golembiovsk=C3=BD wrote: =20
> > > ping
> > >=20
> > > On Tue,  5 Dec 2017 13:14:46 +0100
> > > Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com> wrote:
> > >  =20
> >=20
> > It would be good to include the corresponding upstream kernel change in=
 the
> > commit message. This would be similar to a previous change:
> > https://lists.gnu.org/archive/html/qemu-devel/2016-02/msg05555.html =20
>=20
> good idea, but this has been merged by now.

Maybe next time, sorry.


> > > > Signed-off-by: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.c=
om>
> > > > ---
> > > >   hw/virtio/virtio-balloon.c                      | 1 +
> > > >   include/standard-headers/linux/virtio_balloon.h | 3 ++-
> > > >   2 files changed, 3 insertions(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> > > > index 37cde38982..8141326a51 100644
> > > > --- a/hw/virtio/virtio-balloon.c
> > > > +++ b/hw/virtio/virtio-balloon.c
> > > > @@ -50,6 +50,7 @@ static const char *balloon_stat_names[] =3D {
> > > >      [VIRTIO_BALLOON_S_MEMFREE] =3D "stat-free-memory",
> > > >      [VIRTIO_BALLOON_S_MEMTOT] =3D "stat-total-memory",
> > > >      [VIRTIO_BALLOON_S_AVAIL] =3D "stat-available-memory",
> > > > +   [VIRTIO_BALLOON_S_CACHES] =3D "stat-disk-caches",
> > > >      [VIRTIO_BALLOON_S_NR] =3D NULL
> > > >   };
> > > > diff --git a/include/standard-headers/linux/virtio_balloon.h b/incl=
ude/standard-headers/linux/virtio_balloon.h
> > > > index 9d06ccd066..7b0a41b8fc 100644
> > > > --- a/include/standard-headers/linux/virtio_balloon.h
> > > > +++ b/include/standard-headers/linux/virtio_balloon.h
> > > > @@ -52,7 +52,8 @@ struct virtio_balloon_config {
> > > >   #define VIRTIO_BALLOON_S_MEMFREE  4   /* Total amount of free mem=
ory */
> > > >   #define VIRTIO_BALLOON_S_MEMTOT   5   /* Total amount of memory */
> > > >   #define VIRTIO_BALLOON_S_AVAIL    6   /* Available memory as in /=
proc */
> > > > -#define VIRTIO_BALLOON_S_NR       7
> > > > +#define VIRTIO_BALLOON_S_CACHES   7   /* Disk caches */ =20
> >=20
> > I've been wondering, VIRTIO_BALLOON_S_AVAIL is not in the virtio spec (=
see
> > Section 5.5.6.3). It seems like this header file needs to be in sync wi=
th
> > the virtio spec in order to make this change.
> >=20
> > I have a similar change to add a new statistic and was wondering this. =
=20
>=20
> Absolutely. Tom=C3=A1=C5=A1?

Sent. I also included description for the VIRTIO_BALLOON_S_AVAIL that
was missing.


> > > > +#define VIRTIO_BALLOON_S_NR       8
> > > >   /*
> > > >    * Memory statistics structure.
> > > > --=20
> > > > 2.15.1
> > > >  =20
> > >=20
> > >  =20
> >=20
> > You need to add your new stat to the list of stats in
> > docs/virtio-balloon-stats.txt.
> >=20
> > Jon =20
>=20
> Can't hurt, I agree.

Sent.

    Tomas

--=20
Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

