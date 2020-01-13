Return-Path: virtio-dev-return-6650-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E5046985CD4
	for <virtio-dev@lists.oasis-open.org>; Mon, 13 Jan 2020 11:05:31 +0000 (UTC)
Date: Mon, 13 Jan 2020 12:05:21 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20200113110521.5ogc3fcy4zq32yzg@sirius.home.kraxel.org>
References: <20191218130214.170703-1-keiichiw@chromium.org>
 <7740094.NyiUUSuA9g@os-lin-dmo>
 <20200113095636.blov62o4gbf27om5@sirius.home.kraxel.org>
 <12433898.dW097sEU6C@os-lin-dmo>
MIME-Version: 1.0
In-Reply-To: <12433898.dW097sEU6C@os-lin-dmo>
Subject: Re: [virtio-dev] Re: [PATCH v2 0/1] VirtIO video device specification
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Dmitry Sepp <dmitry.sepp@opensynergy.com>
Cc: spice-devel@lists.freedesktop.org, Keiichi Watanabe <keiichiw@chromium.org>, virtio-dev@lists.oasis-open.org, Tomasz Figa <tfiga@chromium.org>, Linux Media Mailing List <linux-media@vger.kernel.org>, Alexandre Courbot <acourbot@chromium.org>, Alex Lau <alexlau@chromium.org>, Daniel Vetter <daniel@ffwll.ch>, Dylan Reid <dgreid@chromium.org>, Enrico Granata <egranata@google.com>, Frediano Ziglio <fziglio@redhat.com>, Hans Verkuil <hverkuil@xs4all.nl>, =?utf-8?B?U3TDqXBoYW5l?= Marchesin <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, David Stevens <stevensd@chromium.org>, uril@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Jan 13, 2020 at 11:41:45AM +0100, Dmitry Sepp wrote:
> Hi Gerd,
>=20
> Thanks for reviewing!
>=20
> On Montag, 13. Januar 2020 10:56:36 CET Gerd Hoffmann wrote:
> >   Hi,
> >=20
> > > This also means that we cannot have unspec for planes layout. Device
> > > either
> > > expects planes in separate buffers or in one buffer with some offsets=
,
> > > there cannot be mixed cases.
> >=20
> > Hmm.  Is it useful to support both?  Or maybe support the "one buffer +
> > offsets" case only?  Splitting one buffer into multiple smaller ones
> > internally if needed shouldn't be a problem, and it would simplify the
> > interface a bit ...
> >=20
>=20
> Ok, let's consider the following case:
>  - the device expects planes in separate buffers.
>  - say, Android on the guest side also imports planes in separate buffers=
 into the driver.
>  - but he driver only supports one buffer + offsets.
>=20
> Do you mean the driver then can join the underlying page lists and set of=
fsets then? Yes,=20
> this would probably make sense.

Well, no.  Tomasz Figa had splitted the devices into three groups:

  (1) requires single buffer.
  (2) allows any layout (including the one (1) devices want).
  (3) requires per-plane buffers.

Category (3) devices are apparently rare and old.  Both category (1)+(2)
devices can handle single buffers just fine.  So maybe support only
that?

Hope it's more clear this time,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

