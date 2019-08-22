Return-Path: virtio-dev-return-6008-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 50C4C985C7E
	for <virtio-dev@lists.oasis-open.org>; Thu, 22 Aug 2019 11:34:15 +0000 (UTC)
Date: Thu, 22 Aug 2019 13:34:05 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190822133405.7a0fb101.cohuck@redhat.com>
In-Reply-To: <20190813131320.30829-3-stefanha@redhat.com>
References: <20190813131320.30829-1-stefanha@redhat.com>
	<20190813131320.30829-3-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-dev] [PATCH v6 2/2] virtio-fs: add DAX window
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Sage Weil <sweil@redhat.com>, "Dr.
 David Alan Gilbert" <dgilbert@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Steven Whitehouse <swhiteho@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Miklos Szeredi <mszeredi@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, 13 Aug 2019 14:13:20 +0100
Stefan Hajnoczi <stefanha@redhat.com> wrote:

> Describe how shared memory region ID 0 is the DAX window and how
> FUSE_SETUPMAPPING maps file ranges into the window.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> The FUSE_SETUPMAPPING message is part of the virtio-fs Linux patches:
> https://gitlab.com/virtio-fs/linux/blob/virtio-fs/include/uapi/linux/fuse.h
> 
> v6:
>  * Document timing side-channel attacks [Michael]
> ---
>  virtio-fs.tex | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
> 
> diff --git a/virtio-fs.tex b/virtio-fs.tex
> index 81adf85..154b043 100644
> --- a/virtio-fs.tex
> +++ b/virtio-fs.tex
> @@ -178,6 +178,51 @@ \subsubsection{Device Operation: High Priority Queue}\label{sec:Device Types / F
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
> +Shared memory region ID 0 is called the DAX window.  Drivers map this shared
> +memory region with writeback caching as if it were regular RAM.  The contents
> +of the DAX window are undefined unless a mapping exists for that range.

Are drivers still free to use FUSE_{READ,WRITE}?

> +
> +The driver maps a file range into the DAX window using the FUSE\_SETUPMAPPING
> +request.  Alignment constraints for FUSE\_SETUPMAPPING and FUSE\_REMOVEMAPPING
> +requests are communicated during FUSE\_INIT negotiation.
> +
> +When a FUSE\_SETUPMAPPING request perfectly overlaps a previous mapping, the
> +previous mapping is replaced.  When a mapping partially overlaps a previous
> +mapping, the previous mapping is split into one or two smaller mappings.  When
> +a mapping is partially unmapped it is also split into one or two smaller
> +mappings.
> +
> +Establishing new mappings or splitting existing mappings consumes resources.
> +If the device runs out of resources the FUSE\_SETUPMAPPING request fails until
> +resources are available again following FUSE\_REMOVEMAPPING.
> +
> +After FUSE\_SETUPMAPPING has completed successfully the file range is
> +accessible from the DAX window at the offset provided by the driver in the
> +request.  A mapping is removed using the FUSE\_REMOVEMAPPING request.
> +
> +Data is only guaranteed to be persistent when a FUSE\_FSYNC request is used by
> +the device after having been made available by the driver following the write.
> +
> +\devicenormative{\paragraph}{Device Operation: DAX Window}{Device Types / File System Device / Device Operation / Device Operation: DAX Window}
> +
> +The device MUST allow mappings that completely or partially overlap existing mappings within the DAX window.
> +
> +The device MUST reject mappings that would go beyond the end of the DAX window.
> +
> +\drivernormative{\paragraph}{Device Operation: DAX Window}{Device Types / File System Device / Device Operation / Device Operation: DAX Window}
> +
> +The driver SHOULD be prepared to find shared memory region ID 0 absent and fall back to FUSE\_READ and FUSE\_WRITE requests.

Should the _device_ also be prepared that the driver does not use the
dax window? Likely yes (old drivers etc.); do we need to spell it out?

> +
> +The driver MUST NOT access DAX window areas that have not been mapped.
> +
>  \subsubsection{Security Considerations}\label{sec:Device Types / File System Device / Security Considerations}
>  
>  The device provides access to a file system containing files owned by one or

(...)

Otherwise, looks good to me.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

