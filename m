Return-Path: virtio-dev-return-5784-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 47BBF985D74
	for <virtio-dev@lists.oasis-open.org>; Wed, 19 Jun 2019 01:41:30 +0000 (UTC)
Date: Tue, 18 Jun 2019 21:41:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190618213147-mutt-send-email-mst@kernel.org>
References: <20190220124613.22661-1-stefanha@redhat.com>
 <20190220124613.22661-3-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220124613.22661-3-stefanha@redhat.com>
Subject: Re: [virtio-dev] [PATCH v3 2/2] virtio-fs: add DAX window
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Miklos Szeredi <mszeredi@redhat.com>, Sage Weil <sweil@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Steven Whitehouse <swhiteho@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Feb 20, 2019 at 12:46:13PM +0000, Stefan Hajnoczi wrote:
> Describe how shared memory region ID 0 is the DAX window and how
> FUSE_SETUPMAPPING maps file ranges into the window.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> Note that this depends on the shared memory resource specification
> extension that David Gilbert is working on.
> https://lists.oasis-open.org/archives/virtio-comment/201901/msg00000.html
> 
> The FUSE_SETUPMAPPING message is part of the virtio-fs Linux patches:
> https://gitlab.com/virtio-fs/linux/blob/virtio-fs/include/uapi/linux/fuse.h
> ---
>  virtio-fs.tex | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/virtio-fs.tex b/virtio-fs.tex
> index 5df5b9c..abb1e48 100644
> --- a/virtio-fs.tex
> +++ b/virtio-fs.tex
> @@ -157,6 +157,31 @@ The driver MUST submit FUSE_INTERRUPT, FUSE_FORGET, and FUSE_BATCH_FORGET reques
>  
>  The driver MUST anticipate that request queues are processed concurrently with the hiprio queue.
>  
> +\subsubsection{Device Operation: DAX Window}\label{sec:Device Types / File System Device / Device Operation / Device Operation: DAX Window}
> +
> +FUSE\_READ and FUSE\_WRITE requests transfer file contents between the
> +driver-provided buffer and the device.  In cases where data transfer is
> +undesirable, the device can map file contents into the DAX window shared memory
> +region.  The driver then accesses file contents directly in device-owned memory
> +without a data transfer.
> +
> +Shared memory region ID 0 is called the DAX window.  The driver maps a file
> +range into the DAX window using the FUSE\_SETUPMAPPING request.  The mapping is
> +removed using the FUSE\_REMOVEMAPPING request.

I don't see FUSE\_SETUPMAPPING or FUSE\_REMOVEMAPPING  under
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/uapi/linux/fuse.h
Is it just me?

> +
> +After FUSE\_SETUPMAPPING has completed successfully the file range is accessible
> +from the DAX window at the offset provided by the driver in the request.

Dgilbert's patches describing shared memory say that
the legal ways to set up mappings are all implementation-dependent.
How does driver know which attributes to use for the
mapping?

Also, we recently had a discussion about DAX support on hosts
and safety wrt crashes. Do we need to expose this
information to guests maybe?


Finally, do we want to have a way to express that the filesystem
only allows RO mappings?


> +
> +\devicenormative{\paragraph}{Device Operation: DAX Window}{Device Types / File System Device / Device Operation / Device Operation: DAX Window}
> +
> +The device MUST allow mappings that completely or partially overlap existing mappings within the DAX window.


Any alignment requirements?

Also, with no limit on mappings, it looks like guest can use up lots of
host VMAs quickly. Shouldn't there be a limit on # of mappings?


> +
> +The device MUST reject mappings that would go beyond the end of the DAX window.
> +
> +\drivernormative{\paragraph}{Device Operation: DAX Window}{Device Types / File System Device / Device Operation / Device Operation: DAX Window}
> +
> +The driver SHOULD be prepared to find shared memory region ID 0 absent and fall back to FUSE\_READ and FUSE\_WRITE requests.
> +
>  \subsubsection{Security Considerations}\label{sec:Device Types / File System Device / Security Considerations}
>  
>  The device provides access to a file system that may contain files owned by
> -- 
> 2.20.1
> 
> 
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

