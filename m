Return-Path: virtio-dev-return-6598-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 229AF984400
	for <virtio-dev@lists.oasis-open.org>; Mon,  6 Jan 2020 09:29:14 +0000 (UTC)
From: Dmitry Sepp <dmitry.sepp@opensynergy.com>
Date: Mon, 6 Jan 2020 10:29:08 +0100
Message-ID: <7363398.GW5YExTkCf@os-lin-dmo>
In-Reply-To: <20200106083335.jmzhavtlq7ppgtic@sirius.home.kraxel.org>
References: <20191218130214.170703-1-keiichiw@chromium.org> <CAAFQd5ANkgPdu71Oo6YjFPJ2dT24GK_Ne5=Omp6Sh+6FXT2BTw@mail.gmail.com> <20200106083335.jmzhavtlq7ppgtic@sirius.home.kraxel.org>
MIME-Version: 1.0
Subject: Re: [virtio-dev] Re: [PATCH v2 1/1] virtio-video: Add virtio video device specification
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 7Bit
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Tomasz Figa <tfiga@chromium.org>, virtio-dev@lists.oasis-open.org, Keiichi Watanabe <keiichiw@chromium.org>, Linux Media Mailing List <linux-media@vger.kernel.org>, Alexandre Courbot <acourbot@chromium.org>, Alex Lau <alexlau@chromium.org>, Daniel Vetter <daniel@ffwll.ch>, Dylan Reid <dgreid@chromium.org>, Enrico Granata <egranata@google.com>, Frediano Ziglio <fziglio@redhat.com>, Hans Verkuil <hverkuil@xs4all.nl>, =?ISO-8859-1?Q?St=E9phane?= Marchesin <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, spice-devel@lists.freedesktop.org, David Stevens <stevensd@chromium.org>, uril@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

Hi,

On Montag, 6. Januar 2020 09:33:35 CET Gerd Hoffmann wrote:
>   Hi,
> 
> > > We also see the need to add a max_streams value to this structure so as
> > > to
> > > explicitly provide a limit on the number of streams the guest can
> > > create.
> > 
> > What would be the advantage over just trying to create one and
> > failing? The maximum number would be only meaningful for the special
> > case when the streams are always only created by one user space
> > process. Otherwise, if several processes do that, they are not aware
> > of each other and the number could be higher than they can actually
> > create, because other processes could have some streams created
> > already.
> 
> Also the number of streams might not be fixed but depend on stream
> parameters, i.e. hardware can decode one hd or two sd streams ...
> 
Ok, you are right. We'd better return an error from the device side.

Regards,
Dmitry.

> cheers,
>   Gerd



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

