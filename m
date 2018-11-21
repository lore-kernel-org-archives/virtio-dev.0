Return-Path: virtio-dev-return-4985-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 638999841EC
	for <virtio-dev@lists.oasis-open.org>; Wed, 21 Nov 2018 08:54:25 +0000 (UTC)
Date: Wed, 21 Nov 2018 09:54:22 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181121085422.mk4ob6vhwbnufqzl@sirius.home.kraxel.org>
References: <20181030063206.19528-1-kraxel@redhat.com>
 <20181030063206.19528-3-kraxel@redhat.com>
 <20181030093804.GQ21967@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181030093804.GQ21967@phenom.ffwll.local>
Subject: [virtio-dev] Re: [PATCH v4 2/2] drm/virtio: add edid support
To: virtio-dev@lists.oasis-open.org, dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Oct 30, 2018 at 10:38:04AM +0100, Daniel Vetter wrote:
> On Tue, Oct 30, 2018 at 07:32:06AM +0100, Gerd Hoffmann wrote:
> > linux guest driver implementation of the VIRTIO_GPU_F_EDID feature.
> > 
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> 
> Like with bochs, I think drm_do_get_edid() here is overkill and fairly
> pointless.

Like with bochs it makes sense to use drm_do_get_edid(), because it
handles edid override and other common stuff.  Not that this should
actually be needed for virtual devices, but I think it still makes sense
for consistency with other drivers, and it might be handy for testing
too.

cheers,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

