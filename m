Return-Path: virtio-dev-return-4907-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 261C0985BC0
	for <virtio-dev@lists.oasis-open.org>; Tue, 23 Oct 2018 15:53:23 +0000 (UTC)
Date: Tue, 23 Oct 2018 17:53:09 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181023155309.6oei7fr7uzkjv7ez@lupin.home.kraxel.org>
References: <20181023130624.10593-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181023130624.10593-1-kraxel@redhat.com>
Subject: [virtio-dev] Re: [PATCH v2] Add VIRTIO_GPU_F_EDID to virtio-gpu.
To: "Michael S. Tsirkin" <mst@redhat.com>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Oct 23, 2018 at 03:06:24PM +0200, Gerd Hoffmann wrote:
> The feature allows the guest request an EDID blob (describing monitor
> capabilities) for a given scanout (aka virtual monitor connector).
> 
> It brings a new command message, which has just a scanout field (beside
> the standard virtio-gpu header) and a response message which carries the
> EDID data.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/22

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

