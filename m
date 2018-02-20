Return-Path: virtio-dev-return-3248-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id D0BD6581806A
	for <virtio-dev@lists.oasis-open.org>; Tue, 20 Feb 2018 15:11:49 -0800 (PST)
Date: Wed, 21 Feb 2018 00:11:35 +0100
From: =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>
Message-ID: <20180221001135.41bc13a1@fiorina>
In-Reply-To: <20180220171544.GC12161@stefanha-x1.localdomain>
References: <61ea318df06f6e50c5f9cfffaaae85aa51ae5b58.1519045824.git.tgolembi@redhat.com>
	<20180220171544.GC12161@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [virtio-dev] [PATCH] content: document balloon memory
 statistics
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Jonathan Helman <jonathan.helman@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, 20 Feb 2018 17:15:44 +0000
Stefan Hajnoczi <stefanha@redhat.com> wrote:

> On Mon, Feb 19, 2018 at 02:10:29PM +0100, Tom=C3=A1=C5=A1 Golembiovsk=C3=
=BD wrote:
> > +\item[VIRTIO_BALLOON_S_CACHES (7)] The amount of memory currently used=
 for
> > +  caching files and other data from disk (in bytes).
> >  \end{description} =20
>=20
> This one is somewhat vague.  I'm not sure if it means guest page cache
> specifically or something more general.
>=20
> On the other hand, the numbers tend to be OS specific...

We should come up with a definition that is as definite as possible
while leaving room for all systems to substitute a value that is
natively available. So if anyone has a better formulation then please
advise. The original intent was not to create a Linux specific field.

On Linux the value corresponds to Buffers + Cached + SwapCached memory
stats. Correct me if I'm wrong but that should be all clean pages that
have a counterpart on disk and can be quickly reclaimed and used for
something else (without additional IO).

On Windows this roughly corresponds to the standby list. Or maybe
standby list plus something else. I suppose there may be some
alternative on BSD too.

    Tomas


--=20
Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

