Return-Path: virtio-dev-return-6019-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4B4629841E7
	for <virtio-dev@lists.oasis-open.org>; Mon, 26 Aug 2019 13:29:02 +0000 (UTC)
Date: Mon, 26 Aug 2019 15:28:52 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190826152852.02d00c3e.cohuck@redhat.com>
In-Reply-To: <20190823153940.28795-3-stefanha@redhat.com>
References: <20190823153940.28795-1-stefanha@redhat.com>
	<20190823153940.28795-3-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-dev] [PATCH v7 2/2] virtio-fs: add DAX window
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>, Sage Weil <sweil@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Steven Whitehouse <swhiteho@redhat.com>, Miklos Szeredi <mszeredi@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, 23 Aug 2019 16:39:40 +0100
Stefan Hajnoczi <stefanha@redhat.com> wrote:

> Describe how shared memory region ID 0 is the DAX window and how
> FUSE_SETUPMAPPING maps file ranges into the window.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> The FUSE_SETUPMAPPING message is part of the virtio-fs Linux patches:
> https://gitlab.com/virtio-fs/linux/blob/virtio-fs/include/uapi/linux/fuse.h
> 
> v7:
>  * Clarify that the DAX Window is optional and can be used together with
>    FUSE_READ/FUSE_WRITE requests [Cornelia]
> v6:
>  * Document timing side-channel attacks [Michael]
> ---
>  virtio-fs.tex | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 66 insertions(+) 

(...)

> +\drivernormative{\paragraph}{Device Operation: DAX Window}{Device Types / File System Device / Device Operation / Device Operation: DAX Window}
> +
> +The driver SHOULD be prepared to find shared memory region ID 0 absent and fall back to FUSE\_READ and FUSE\_WRITE requests.
> +
> +The driver MAY use FUSE\_READ and FUSE\_WRITE requests and also access file contents through the DAX Window.

"The driver MAY both use FUSE_READ and FUSE_WRITE requests and access
file contents through the DAX Window." ?

Not sure whether that makes it clearer that it is fine to use a
combination of both methods.

> +
> +The driver MUST NOT access DAX window areas that have not been mapped.
> +

Otherwise, looks good.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

