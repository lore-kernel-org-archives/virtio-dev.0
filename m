Return-Path: virtio-dev-return-6596-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8BA31984400
	for <virtio-dev@lists.oasis-open.org>; Mon,  6 Jan 2020 08:33:48 +0000 (UTC)
Date: Mon, 6 Jan 2020 09:33:35 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20200106083335.jmzhavtlq7ppgtic@sirius.home.kraxel.org>
References: <20191218130214.170703-1-keiichiw@chromium.org>
 <20191218130214.170703-2-keiichiw@chromium.org>
 <2932378.s8JBUXtX1Y@os-lin-dmo>
 <2322065.f0tlG9Vh6p@os-lin-dmo>
 <CAAFQd5ANkgPdu71Oo6YjFPJ2dT24GK_Ne5=Omp6Sh+6FXT2BTw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAAFQd5ANkgPdu71Oo6YjFPJ2dT24GK_Ne5=Omp6Sh+6FXT2BTw@mail.gmail.com>
Subject: Re: [virtio-dev] Re: [PATCH v2 1/1] virtio-video: Add virtio video
 device specification
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Tomasz Figa <tfiga@chromium.org>
Cc: Dmitry Sepp <dmitry.sepp@opensynergy.com>, virtio-dev@lists.oasis-open.org, Keiichi Watanabe <keiichiw@chromium.org>, Linux Media Mailing List <linux-media@vger.kernel.org>, Alexandre Courbot <acourbot@chromium.org>, Alex Lau <alexlau@chromium.org>, Daniel Vetter <daniel@ffwll.ch>, Dylan Reid <dgreid@chromium.org>, Enrico Granata <egranata@google.com>, Frediano Ziglio <fziglio@redhat.com>, Hans Verkuil <hverkuil@xs4all.nl>, =?utf-8?B?U3TDqXBoYW5l?= Marchesin <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, spice-devel@lists.freedesktop.org, David Stevens <stevensd@chromium.org>, uril@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

  Hi,

> > We also see the need to add a max_streams value to this structure so as=
 to
> > explicitly provide a limit on the number of streams the guest can creat=
e.
>=20
> What would be the advantage over just trying to create one and
> failing? The maximum number would be only meaningful for the special
> case when the streams are always only created by one user space
> process. Otherwise, if several processes do that, they are not aware
> of each other and the number could be higher than they can actually
> create, because other processes could have some streams created
> already.

Also the number of streams might not be fixed but depend on stream
parameters, i.e. hardware can decode one hd or two sd streams ...

cheers,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

