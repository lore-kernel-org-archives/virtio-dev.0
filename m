Return-Path: virtio-dev-return-4916-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4DAB89849FF
	for <virtio-dev@lists.oasis-open.org>; Mon, 29 Oct 2018 11:05:13 +0000 (UTC)
Date: Mon, 29 Oct 2018 12:05:07 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181029110507.qmgn3eq3zzpsl46b@sirius.home.kraxel.org>
References: <20181024121551.8715-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181024121551.8715-1-kraxel@redhat.com>
Subject: Re: [virtio-dev] [PATCH v3] Add VIRTIO_GPU_F_EDID to virtio-gpu.
To: "Michael S. Tsirkin" <mst@redhat.com>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Oct 24, 2018 at 02:15:51PM +0200, Gerd Hoffmann wrote:
> The feature allows the guest request an EDID blob (describing monitor
> capabilities) for a given scanout (aka virtual monitor connector).
> 
> It brings a new command message, which has just a scanout field (beside
> the standard virtio-gpu header) and a response message which carries the
> EDID data.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/22

cheers,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

