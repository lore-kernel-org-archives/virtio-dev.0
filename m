Return-Path: virtio-dev-return-3315-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 9B27D58191A9
	for <virtio-dev@lists.oasis-open.org>; Wed, 28 Feb 2018 01:36:11 -0800 (PST)
Date: Wed, 28 Feb 2018 10:35:53 +0100
From: =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>
Message-ID: <20180228103553.6bb6687b@fiorina>
In-Reply-To: <20180227215553-mutt-send-email-mst@kernel.org>
References: <61ea318df06f6e50c5f9cfffaaae85aa51ae5b58.1519045824.git.tgolembi@redhat.com>
	<20180220171544.GC12161@stefanha-x1.localdomain>
	<20180221001135.41bc13a1@fiorina>
	<20180221113328.GB19501@stefanha-x1.localdomain>
	<20180221184417.7d5bf2df@fiorina>
	<20180227215553-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [virtio-dev] [PATCH] content: document balloon memory
 statistics
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, virtio-dev@lists.oasis-open.org, Jonathan Helman <jonathan.helman@oracle.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, 27 Feb 2018 21:56:04 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Wed, Feb 21, 2018 at 06:44:17PM +0100, Tom=C3=A1=C5=A1 Golembiovsk=C3=
=BD wrote:
> > On Wed, 21 Feb 2018 11:33:28 +0000
> > Stefan Hajnoczi <stefanha@redhat.com> wrote:
> >  =20
> > > On Wed, Feb 21, 2018 at 12:11:35AM +0100, Tom=C3=A1=C5=A1 Golembiovsk=
=C3=BD wrote: =20
> > > > On Tue, 20 Feb 2018 17:15:44 +0000
> > > > Stefan Hajnoczi <stefanha@redhat.com> wrote:
> > > >  =20
> > > > > On Mon, Feb 19, 2018 at 02:10:29PM +0100, Tom=C3=A1=C5=A1 Golembi=
ovsk=C3=BD wrote: =20
> > > > > > +\item[VIRTIO_BALLOON_S_CACHES (7)] The amount of memory curren=
tly used for
> > > > > > +  caching files and other data from disk (in bytes).
> > > > > >  \end{description}   =20
> > > > >=20
> > > > > This one is somewhat vague.  I'm not sure if it means guest page =
cache
> > > > > specifically or something more general.
> > > > >=20
> > > > > On the other hand, the numbers tend to be OS specific... =20
> > > >=20
> > > > We should come up with a definition that is as definite as possible
> > > > while leaving room for all systems to substitute a value that is
> > > > natively available. So if anyone has a better formulation then plea=
se
> > > > advise. The original intent was not to create a Linux specific fiel=
d.
> > > >=20
> > > > On Linux the value corresponds to Buffers + Cached + SwapCached mem=
ory
> > > > stats. Correct me if I'm wrong but that should be all clean pages t=
hat
> > > > have a counterpart on disk and can be quickly reclaimed and used for
> > > > something else (without additional IO). =20
> > >=20
> > > Thanks for clarifying.  Based on what you posted, how about:
> > >=20
> > > "The amount of memory, in bytes, that can be quickly reclaimed without
> > > additional I/O.  Typically these pages are used for caching files from
> > > disk."
> > >=20
> > > ? =20
> >=20
> > Sounds reasonable, thanks
> >=20
> >     Tomas =20
>=20
> OK - will you post v2 then?

I already have:
https://lists.oasis-open.org/archives/virtio-dev/201802/msg00141.html

>=20
> >  =20
> > >  =20
> > > > On Windows this roughly corresponds to the standby list. Or maybe
> > > > standby list plus something else. I suppose there may be some
> > > > alternative on BSD too.
> > > >=20
> > > >     Tomas
> > > >=20
> > > >=20
> > > > --=20
> > > > Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com> =20
> >=20
> >=20
> > --=20
> > Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com> =20


--=20
Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

