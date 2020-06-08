Return-Path: virtio-dev-return-7452-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 117BF985A3E
	for <virtio-dev@lists.oasis-open.org>; Mon,  8 Jun 2020 15:17:38 +0000 (UTC)
Date: Mon, 8 Jun 2020 11:17:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20200608111647-mutt-send-email-mst@kernel.org>
References: <20200311112004.47138-1-stevensd@chromium.org>
 <20200311112004.47138-5-stevensd@chromium.org>
 <20200513123326-mutt-send-email-mst@kernel.org>
 <CAD=HUj5qcMLw__LfJizR6nzCR9Qmu21Sjk3i0j_8+=rxt1Hk=w@mail.gmail.com>
 <20200608054234-mutt-send-email-mst@kernel.org>
 <CAD=HUj6kF2JFyC9c0CY5_f-cv6r97501Z2f8D9x0VhQpRen+bw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAD=HUj6kF2JFyC9c0CY5_f-cv6r97501Z2f8D9x0VhQpRen+bw@mail.gmail.com>
Subject: [virtio-dev] Re: [PATCH v3 4/4] drm/virtio: Support virtgpu exported resources
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: David Stevens <stevensd@chromium.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Jason Wang <jasowang@redhat.com>, Sumit Semwal <sumit.semwal@linaro.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, open list <linux-kernel@vger.kernel.org>, ML dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, Linux Media Mailing List <linux-media@vger.kernel.org>, "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Jun 08, 2020 at 07:36:55PM +0900, David Stevens wrote:
> On Mon, Jun 8, 2020 at 6:43 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Fri, May 15, 2020 at 04:26:15PM +0900, David Stevens wrote:
> > > > > +     if (virtio_has_feature(vgdev->vdev, VIRTIO_GPU_F_RESOURCE_UUID)) {
> > > > > +             vgdev->has_resource_assign_uuid = true;
> > > > > +     }
> > > >
> > > >
> > > > Just a question: this relies on DMA bufs so I assume it is
> > > > not really assumed to work when DMA API is bypassed, right?
> > > > Rather than worry what does it mean, how about just
> > > > disabling  this feature without PLATFORM_DMA for now?
> > >
> > > By PLATFORM_DMA, do you mean CONFIG_DMA_SHARED_BUFFER?
> >
> > Sorry, no. I mean VIRTIO_F_IOMMU_PLATFORM which in the
> > future will be renamed to VIRTIO_F_PLATFORM_ACCESS.
> 
> Shouldn't things work independent of whether or not that feature is
> set? If a virtio driver properly uses the dma_buf APIs (which virtgpu
> seems to), then that should take care of any mapping/synchronization
> related to VIRTIO_F_IOMMU_PLATFORM. If anything, the case where
> VIRTIO_F_IOMMU_PLATFORM isn't set is easier, since then we know that
> the "the device has same access [sic] to memory addresses supplied to
> it as the driver has", according to the specification.
> 
> -David

I don't know much about drm so I can't tell, I was hoping Gerd can
explain.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

