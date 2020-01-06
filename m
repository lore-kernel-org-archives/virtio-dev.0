Return-Path: virtio-dev-return-6597-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A8A1E984400
	for <virtio-dev@lists.oasis-open.org>; Mon,  6 Jan 2020 08:47:17 +0000 (UTC)
Date: Mon, 6 Jan 2020 09:47:01 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20200106084701.3v5eew3bh4nh67sc@sirius.home.kraxel.org>
References: <20191218130214.170703-1-keiichiw@chromium.org>
 <20191218130214.170703-2-keiichiw@chromium.org>
 <2358784.0s52YacUgI@os-lin-dmo>
MIME-Version: 1.0
In-Reply-To: <2358784.0s52YacUgI@os-lin-dmo>
Subject: [virtio-dev] Re: [PATCH v2 1/1] virtio-video: Add virtio video device
 specification
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Dmitry Sepp <dmitry.sepp@opensynergy.com>
Cc: Keiichi Watanabe <keiichiw@chromium.org>, virtio-dev@lists.oasis-open.org, linux-media@vger.kernel.org, acourbot@chromium.org, alexlau@chromium.org, daniel@ffwll.ch, dgreid@chromium.org, egranata@google.com, fziglio@redhat.com, hverkuil@xs4all.nl, marcheu@chromium.org, posciak@chromium.org, spice-devel@lists.freedesktop.org, stevensd@chromium.org, tfiga@chromium.org, uril@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

  Hi,

> How should one deal with multiplanar formats? Do we create one resource p=
er=20
> plane? Otherwise we need a way to send mem entries for each plane in one=
=20
> request.

DRM uses arrays of handles and offsets (see struct drm_framebuffer).  A
handle references a gem object (roughly the same as a resource), and the
offset specifies the start of the plane within the gem object.  That
allows both a single gem object with planes stored at different offsets
and one gem object per plane.  virtio-video could do the same, or pick
one of the two approaches and support only that.

cheers,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

