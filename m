Return-Path: virtio-dev-return-7672-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D0FE8985A9A
	for <virtio-dev@lists.oasis-open.org>; Tue, 18 Aug 2020 01:52:31 +0000 (UTC)
MIME-Version: 1.0
References: <20200609012518.198908-1-stevensd@chromium.org>
 <20200609055021-mutt-send-email-mst@kernel.org> <CAD=HUj7wJfoKj_K44Cs9eEmh=OQHZ1+qz7ZHxoscHjYgOMXvZQ@mail.gmail.com>
 <20200817105008.mi3ukh6kxgi37gjs@sirius.home.kraxel.org> <20200817111234.i7pqtnnk2ciw4rqb@sirius.home.kraxel.org>
In-Reply-To: <20200817111234.i7pqtnnk2ciw4rqb@sirius.home.kraxel.org>
From: David Stevens <stevensd@chromium.org>
Date: Mon, 17 Aug 2020 18:52:19 -0700
Message-ID: <CAD=HUj65N3ejzYgUcpHLvPHguXFDC-B4OFeNOfvSML1zdoNRPg@mail.gmail.com>
Subject: Re: [virtio-dev] Re: [PATCH v5 0/3] Support virtio cross-device resources
Content-Type: text/plain; charset="UTF-8"
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>, Jason Wang <jasowang@redhat.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, open list <linux-kernel@vger.kernel.org>, ML dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, Linux Media Mailing List <linux-media@vger.kernel.org>, "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>, virtio-dev@lists.oasis-open.org, alex.williamson@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Aug 17, 2020 at 4:12 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Mon, Aug 17, 2020 at 12:50:08PM +0200, Gerd Hoffmann wrote:
> > On Tue, Jun 23, 2020 at 10:31:28AM +0900, David Stevens wrote:
> > > Unless there are any remaining objections to these patches, what are
> > > the next steps towards getting these merged? Sorry, I'm not familiar
> > > with the workflow for contributing patches to Linux.
> >
> > Sorry, just have been busy and not paying as much attention to drm
> > patches as usual.  Playing catch-up now.  Queued for drm-misc-next,
> > unless something goes wrong in my testing the patches should land
> > in linux-next soon and be merged upstream in the next merge window.
>
> Oh, spoke too soon.  scripts/checkpatch.pl has a bunch of codestyle
> warnings.  Can you fix them and resend?

Sent a new version to fix the line length warning. There's still a
MAINTAINER warning, but I think the new virtio_dma_buf file can fall
under virtio core (and the existing wildcards do match it), rather
than get its own MAINTAINER entry. I can break it out into its own
thing if that's better, though.

-David

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

