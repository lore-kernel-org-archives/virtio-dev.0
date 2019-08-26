Return-Path: virtio-dev-return-6018-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E817F9841E7
	for <virtio-dev@lists.oasis-open.org>; Mon, 26 Aug 2019 13:20:16 +0000 (UTC)
Date: Mon, 26 Aug 2019 15:19:49 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190826151949.27aaf2ed.cohuck@redhat.com>
In-Reply-To: <20190823153940.28795-2-stefanha@redhat.com>
References: <20190823153940.28795-1-stefanha@redhat.com>
	<20190823153940.28795-2-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-dev] [PATCH v7 1/2] content: add virtio file system
 device
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>, Sage Weil <sweil@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Steven Whitehouse <swhiteho@redhat.com>, Miklos Szeredi <mszeredi@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, 23 Aug 2019 16:39:39 +0100
Stefan Hajnoczi <stefanha@redhat.com> wrote:

> The virtio file system device transports Linux FUSE requests between a
> FUSE daemon running on the host and the FUSE driver inside the guest.
> 
> The actual FUSE request definitions are not duplicated in the virtio
> specification, similar to how virtio-scsi does not document SCSI
> command details.  FUSE request definitions are available here:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/uapi/linux/fuse.h
> 
> This patch documents the core virtio file system device, which is
> functional but lacks the DAX feature introduced in the next patch.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> v7:
>  * Rename num_queues to num_request_queues [Cornelia]
>  * Clarify that endianness is chosen by the guest driver in the
>    FUSE_INIT message
> v6:
>  * Clarify that num_queues only counts request queues [Cornelia]
>  * State that only high priority requests go on the hiprio queue [Cornelia]
>  * Expand on how endianness works [Cornelia]
>  * Use "driver" and "device" instead of "guest" and "host" [Michael]
>  * Explain how setuid files and device nodes can be a security issue [Michael]
>  * Clarify that security issues with shared file systems involve multiple machines [Michael]
> ---
>  content.tex      |   1 +
>  introduction.tex |   3 +
>  virtio-fs.tex    | 225 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 229 insertions(+)
>  create mode 100644 virtio-fs.tex

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

