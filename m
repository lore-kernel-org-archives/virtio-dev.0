Return-Path: virtio-dev-return-6648-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 71F6C985CD4
	for <virtio-dev@lists.oasis-open.org>; Mon, 13 Jan 2020 09:56:48 +0000 (UTC)
Date: Mon, 13 Jan 2020 10:56:36 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20200113095636.blov62o4gbf27om5@sirius.home.kraxel.org>
References: <20191218130214.170703-1-keiichiw@chromium.org>
 <2137719.ElGaqSPkdT@os-lin-dmo>
 <CAD90Vcbk5DerrFNQdH1wdAX=HxBjMz9-FoNiWm_ryvwsA_YvYA@mail.gmail.com>
 <7740094.NyiUUSuA9g@os-lin-dmo>
MIME-Version: 1.0
In-Reply-To: <7740094.NyiUUSuA9g@os-lin-dmo>
Subject: Re: [virtio-dev] Re: [PATCH v2 0/1] VirtIO video device specification
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Dmitry Sepp <dmitry.sepp@opensynergy.com>
Cc: Keiichi Watanabe <keiichiw@chromium.org>, virtio-dev@lists.oasis-open.org, Tomasz Figa <tfiga@chromium.org>, Linux Media Mailing List <linux-media@vger.kernel.org>, Alexandre Courbot <acourbot@chromium.org>, Alex Lau <alexlau@chromium.org>, Daniel Vetter <daniel@ffwll.ch>, Dylan Reid <dgreid@chromium.org>, Enrico Granata <egranata@google.com>, Frediano Ziglio <fziglio@redhat.com>, Hans Verkuil <hverkuil@xs4all.nl>, =?utf-8?B?U3TDqXBoYW5l?= Marchesin <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, spice-devel@lists.freedesktop.org, David Stevens <stevensd@chromium.org>, uril@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

  Hi,

> This also means that we cannot have unspec for planes layout. Device eith=
er=20
> expects planes in separate buffers or in one buffer with some offsets, th=
ere=20
> cannot be mixed cases.

Hmm.  Is it useful to support both?  Or maybe support the "one buffer +
offsets" case only?  Splitting one buffer into multiple smaller ones
internally if needed shouldn't be a problem, and it would simplify the
interface a bit ...

cheers,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

