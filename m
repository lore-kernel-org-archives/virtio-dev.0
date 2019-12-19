Return-Path: virtio-dev-return-6545-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 01D64985F44
	for <virtio-dev@lists.oasis-open.org>; Thu, 19 Dec 2019 12:54:44 +0000 (UTC)
Date: Thu, 19 Dec 2019 13:54:32 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20191219125432.ogb2gdvmly6iuqti@sirius.home.kraxel.org>
References: <20191218130214.170703-1-keiichiw@chromium.org>
 <20191218130214.170703-2-keiichiw@chromium.org>
 <20191218134037.3jbouht52bxqwfyy@sirius.home.kraxel.org>
 <2570078.xtWa8k4VtA@os-lin-dmo>
MIME-Version: 1.0
In-Reply-To: <2570078.xtWa8k4VtA@os-lin-dmo>
Subject: [virtio-dev] Re: [PATCH v2 1/1] virtio-video: Add virtio video device
 specification
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Dmitry Sepp <dmitry.sepp@opensynergy.com>
Cc: Keiichi Watanabe <keiichiw@chromium.org>, virtio-dev@lists.oasis-open.org, linux-media@vger.kernel.org, acourbot@chromium.org, alexlau@chromium.org, daniel@ffwll.ch, dgreid@chromium.org, egranata@google.com, fziglio@redhat.com, hverkuil@xs4all.nl, marcheu@chromium.org, posciak@chromium.org, spice-devel@lists.freedesktop.org, stevensd@chromium.org, tfiga@chromium.org, uril@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

  Hi,

> > I also can't see why the flag is needed in the first place.  The driver
> > should know which buffers are queued still and be able to figure
> > whenever the drain is complete or not without depending on that flag.
> > So I'd suggest to simply drop it.
> This flag is used not for drain only. In marks the completion of whatever=
=20
> specific buffer sequence, like a full end-of-stream, resolution change, d=
rain=20
> etc. We also need this to handle nested sequences. For instance, a resolu=
tion=20
> change event might happen while in drain.

Ah, ok.  That makes sense (please clarify this in the spec).

cheers,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

