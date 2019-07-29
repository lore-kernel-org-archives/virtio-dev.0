Return-Path: virtio-dev-return-5890-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3A304984342
	for <virtio-dev@lists.oasis-open.org>; Mon, 29 Jul 2019 11:20:44 +0000 (UTC)
Date: Mon, 29 Jul 2019 07:20:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190729062417-mutt-send-email-mst@kernel.org>
References: <20190326094106.17760-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326094106.17760-1-pbonzini@redhat.com>
Subject: [virtio-dev] reserving virtio device IDs (was Re: [virtio] [PATCH] Reserve id for
 virtio-audio device)
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Paolo Bonzini <bonzini@gnu.org>, anthony.xu@intel.com, acrn-dev@lists.projectacrn.org, acrn-tsc@lists.projectacrn.org, wei.a.deng@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Mar 26, 2019 at 10:41:06AM +0100, Paolo Bonzini wrote:
> From: Paolo Bonzini <bonzini@gnu.org>
> 
> Project ACRN has a virtio-audio device. Unfortunately, the id they are using is
> already reserved in the virtio specification, but it is nevertheless useful to
> have one.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  content.tex | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/content.tex b/content.tex
> index ede0ef6..96e2bad 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -2634,6 +2634,8 @@ Device ID  &  Virtio Device    \\
>  \hline
>  24         &   Memory device \\
>  \hline
> +25         &   Audio device \\
> +\hline
>  \end{tabular}
>  
>  Some of the devices above are unspecified by this document,


Below's the list of virtio ids used by project ACRN.

Dear project acrn developers, would you like to reserve virtio device
IDs in use by your project?  The process is quite easy, minimally
subscribe to virtio-comment and then email virtio-comment mailing list.

If you want to go the extra mile you can prepare a spec patch along the
lines shown above by Paolo.

This of course only makes sense assumes you are ready to settle on
specific IDs and interested in interoperating with drivers written by
others.  If not I wonder whether your purpose could be best served by the
experimental range.


I am concerned that projects assigning themselves IDs without being
listed in a central place will sooner or later lead to incorrect drivers
loading on incorrect devices.

More specifically, it looks like you are implementing legacy virtio
devices (not 1.0 spec compliant) in the hypervisor. That's of course
your choice but in that case I think it would be preferable to use ID
values below 0x1040, which have been reserved for this purpose. In
particular that will allow adding virtio 1.0 support with minimal pain
down the road.

Here's a list of IDs I found in the source:


#define	VIRTIO_DEV_RPMB		0x8601
#define	VIRTIO_DEV_HECI		0x8602
#define	VIRTIO_DEV_AUDIO	0x8603
#define	VIRTIO_DEV_IPU		0x8604
#define	VIRTIO_DEV_TSN		0x8605
#define	VIRTIO_DEV_HYPERDMABUF	0x8606
#define	VIRTIO_DEV_HDCP		0x8607
#define	VIRTIO_DEV_COREU	0x8608
#define	VIRTIO_DEV_GPIO		0x8609
#define VIRTIO_DEV_I2C		0x860a


Does this reflect what you are using now?  Also, would you happen to
know whether the ID 25 is used anywhere?  That would correspond to PCI
IDs 0x1059 (modern) or 0x19 (legacy/transitional).

Thanks in advance!
-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

