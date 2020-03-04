Return-Path: virtio-dev-return-6885-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 58D19985D7E
	for <virtio-dev@lists.oasis-open.org>; Wed,  4 Mar 2020 07:48:53 +0000 (UTC)
Date: Wed, 4 Mar 2020 08:48:41 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20200304074841.gbfzhxorta3pfk4f@sirius.home.kraxel.org>
References: <20200302121524.7543-1-stevensd@chromium.org>
 <20200302121524.7543-2-stevensd@chromium.org>
MIME-Version: 1.0
In-Reply-To: <20200302121524.7543-2-stevensd@chromium.org>
Subject: [virtio-dev] Re: [PATCH v2 1/4] dma-buf: add support for virtio exported objects
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: David Stevens <stevensd@chromium.org>
Cc: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Sumit Semwal <sumit.semwal@linaro.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Mar 02, 2020 at 09:15:21PM +0900, David Stevens wrote:
> This change adds a new dma-buf operation that allows dma-bufs to be used
> by virtio drivers to share exported objects. The new operation allows
> the importing driver to query the exporting driver for the UUID which
> identifies the underlying exported object.
>=20
> Signed-off-by: David Stevens <stevensd@chromium.org>
> ---
>  drivers/dma-buf/dma-buf.c | 14 ++++++++++++++
>  include/linux/dma-buf.h   | 22 ++++++++++++++++++++++
>  2 files changed, 36 insertions(+)
>=20
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index d4097856c86b..a04632284ec2 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -1158,6 +1158,20 @@ void dma_buf_vunmap(struct dma_buf *dmabuf, void *=
vaddr)
>  }
>  EXPORT_SYMBOL_GPL(dma_buf_vunmap);
> =20
> +#ifdef CONFIG_VIRTIO
> +int dma_buf_get_uuid(struct dma_buf *dmabuf, uuid_t *uuid)

Hmm, I think I would drop the #ifdef

cheers,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

