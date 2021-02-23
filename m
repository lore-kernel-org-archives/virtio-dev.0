Return-Path: virtio-dev-return-8029-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 86CF4986028
	for <virtio-dev@lists.oasis-open.org>; Tue, 23 Feb 2021 12:59:48 +0000 (UTC)
Date: Tue, 23 Feb 2021 07:59:40 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20210223075813-mutt-send-email-mst@kernel.org>
References: <20210222153444.348390-1-anton.yakovlev@opensynergy.com>
 <20210223070839-mutt-send-email-mst@kernel.org>
 <bce13fa2-3ee5-0c6c-5761-17f0389c2d7b@opensynergy.com>
MIME-Version: 1.0
In-Reply-To: <bce13fa2-3ee5-0c6c-5761-17f0389c2d7b@opensynergy.com>
Subject: Re: [virtio-dev] Re: [PATCH v5 0/9] ALSA: add virtio sound driver
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Cc: virtualization@lists.linux-foundation.org, alsa-devel@alsa-project.org, virtio-dev@lists.oasis-open.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Feb 23, 2021 at 01:33:57PM +0100, Anton Yakovlev wrote:
> On 23.02.2021 13:09, Michael S. Tsirkin wrote:
> > On Mon, Feb 22, 2021 at 04:34:35PM +0100, Anton Yakovlev wrote:
> > > This series implements a driver part of the virtio sound device
> > > specification v8 [1].
> > > 
> > > The driver supports PCM playback and capture substreams, jack and
> > > channel map controls. A message-based transport is used to write/read
> > > PCM frames to/from a device.
> > > 
> > > As a device part was used OpenSynergy proprietary implementation.
> > > 
> > > v5 changes:
> > >   - Fixed another bunch of sparse warnings
> > >     (replaced virtio_cread() -> virtio_cread_le()), no functional changes.
> > > (Sorry, I didn't know how to run sparse locally, now everything should be fixed)
> > > 
> > > [1] https://lists.oasis-open.org/archives/virtio-dev/202003/msg00185.html
> > 
> > 
> > In the future please number patches from 1, not from 2.
> > thanks!
> 
> But they are numbered automatically by git. Patch #1 is for virtio_ids.h

Weird somehow I was missing patch #1. Applied now, thanks!

> 
> > > 
> > > Anton Yakovlev (9):
> > >    uapi: virtio_ids: add a sound device type ID from OASIS spec
> > >    ALSA: virtio: add virtio sound driver
> > >    ALSA: virtio: handling control messages
> > >    ALSA: virtio: build PCM devices and substream hardware descriptors
> > >    ALSA: virtio: handling control and I/O messages for the PCM device
> > >    ALSA: virtio: PCM substream operators
> > >    ALSA: virtio: introduce jack support
> > >    ALSA: virtio: introduce PCM channel map support
> > >    ALSA: virtio: introduce device suspend/resume support
> > > 
> > >   MAINTAINERS                     |   9 +
> > >   include/uapi/linux/virtio_ids.h |   1 +
> > >   include/uapi/linux/virtio_snd.h | 334 +++++++++++++++++++++
> > >   sound/Kconfig                   |   2 +
> > >   sound/Makefile                  |   3 +-
> > >   sound/virtio/Kconfig            |  10 +
> > >   sound/virtio/Makefile           |  13 +
> > >   sound/virtio/virtio_card.c      | 462 +++++++++++++++++++++++++++++
> > >   sound/virtio/virtio_card.h      | 113 ++++++++
> > >   sound/virtio/virtio_chmap.c     | 219 ++++++++++++++
> > >   sound/virtio/virtio_ctl_msg.c   | 310 ++++++++++++++++++++
> > >   sound/virtio/virtio_ctl_msg.h   |  78 +++++
> > >   sound/virtio/virtio_jack.c      | 233 +++++++++++++++
> > >   sound/virtio/virtio_pcm.c       | 498 ++++++++++++++++++++++++++++++++
> > >   sound/virtio/virtio_pcm.h       | 120 ++++++++
> > >   sound/virtio/virtio_pcm_msg.c   | 392 +++++++++++++++++++++++++
> > >   sound/virtio/virtio_pcm_ops.c   | 491 +++++++++++++++++++++++++++++++
> > >   17 files changed, 3287 insertions(+), 1 deletion(-)
> > >   create mode 100644 include/uapi/linux/virtio_snd.h
> > >   create mode 100644 sound/virtio/Kconfig
> > >   create mode 100644 sound/virtio/Makefile
> > >   create mode 100644 sound/virtio/virtio_card.c
> > >   create mode 100644 sound/virtio/virtio_card.h
> > >   create mode 100644 sound/virtio/virtio_chmap.c
> > >   create mode 100644 sound/virtio/virtio_ctl_msg.c
> > >   create mode 100644 sound/virtio/virtio_ctl_msg.h
> > >   create mode 100644 sound/virtio/virtio_jack.c
> > >   create mode 100644 sound/virtio/virtio_pcm.c
> > >   create mode 100644 sound/virtio/virtio_pcm.h
> > >   create mode 100644 sound/virtio/virtio_pcm_msg.c
> > >   create mode 100644 sound/virtio/virtio_pcm_ops.c
> > > 
> > > --
> > > 2.30.0
> > > 
> > 
> > 
> > ---------------------------------------------------------------------
> > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> > 
> > 
> 
> -- 
> Anton Yakovlev
> Senior Software Engineer
> 
> OpenSynergy GmbH
> Rotherstr. 20, 10245 Berlin


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

