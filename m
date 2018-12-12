Return-Path: virtio-dev-return-5187-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 364EA985D33
	for <virtio-dev@lists.oasis-open.org>; Wed, 12 Dec 2018 09:26:04 +0000 (UTC)
Date: Wed, 12 Dec 2018 10:25:56 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181212102556.65bd43d3.cohuck@redhat.com>
In-Reply-To: <20181211125156.22523-1-stefanha@redhat.com>
References: <20181211125156.22523-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-dev] [VIRTIO RFC] content: add virtio file system
 device
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Vivek Goyal <vgoyal@redhat.com>, Sage Weil <sweil@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Miklos Szeredi <mszeredi@redhat.com>, Steven Whitehouse <swhiteho@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, 11 Dec 2018 12:51:56 +0000
Stefan Hajnoczi <stefanha@redhat.com> wrote:

> The work-in-progress virtio file system device transports Linux FUSE
> requests between a FUSE daemon running on the host and the FUSE driver
> inside the guest.
> 
> This is an early version of the spec that maps FUSE requests to
> virtqueues.  No changes are needed to the FUSE request format.
> 
> Multiqueue is supported for normal requests.  FUSE_INTERRUPT and
> FUSE_FORGET requests are only sent on the dedicated hiprio queue.
> Notifications are sent on the notifications queue.
> 
> The FUSE driver currently works in a "pull" model where userspace reads
> requests from /dev/fuse one at a time.  Virtqueues are a "push" model
> where the FUSE driver will need to enqueue requests onto a specific
> virtqueue and wait for the guest to process them.
> 
> The request queue buffers are completed by the device when the request
> has been processed and struct fuse_out_header has been filled out.  The
> FUSE driver then picks up the completed request and processes it as if
> the FUSE daemon had written to /dev/fuse.
> 
> Notifications involve device-to-driver communication.  Since virtqueues
> live in guest RAM, the device cannot initiate communication.  Instead
> the notifications queue is populated with empty buffers by the FUSE
> driver (similar to a NIC rx queue).  The device then "completes" a
> buffer when it wishes to notify the driver.  Replies to the notification
> are place in a normal request queue, they do not go via the
> notifications queue.
> 
> Note that this design assumes that the driver knows the required buffer
> size for each request.  My understanding is that this is true in FUSE.
> The only exception is FUSE_NOTIFY_STORE, and even there the FUSE
> implementation has a limit of 32 pages, which makes for a natural buffer
> size limit for the notifications queue.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> The HTML version of this draft spec is available at
> https://stefanha.github.io/virtio/virtio-fs.html#x1-38800010.
> 
> This is mostly for reference and serious review isn't necessary yet.
> 
> For more information on virtio-fs, see https://virtio-fs.gitlab.io/.
> 
> Once the implementation matures we will send a real VIRTIO spec patch.
> 
>  content.tex      |   3 +
>  introduction.tex |   3 +
>  virtio-fs.tex    | 208 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 214 insertions(+)
>  create mode 100644 virtio-fs.tex
> 
> diff --git a/content.tex b/content.tex
> index b101d1b..4d38c5a 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -2528,6 +2528,8 @@ Device ID  &  Virtio Device    \\
>  \hline
>  24         &   Memory device \\
>  \hline
> +26         &   file system device \\

Would it make sense to go ahead and reserve this id now?

> +\hline
>  \end{tabular}
>  
>  Some of the devices above are unspecified by this document,

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

