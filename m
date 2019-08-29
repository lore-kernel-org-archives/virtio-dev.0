Return-Path: virtio-dev-return-6026-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 60091985CDA
	for <virtio-dev@lists.oasis-open.org>; Thu, 29 Aug 2019 14:00:09 +0000 (UTC)
Date: Thu, 29 Aug 2019 16:00:00 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190829160000.0ab6d885.cohuck@redhat.com>
In-Reply-To: <20190829135206.24231-3-stefanha@redhat.com>
References: <20190829135206.24231-1-stefanha@redhat.com>
	<20190829135206.24231-3-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-dev] [PATCH v8 2/2] virtio-fs: add DAX window
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Miklos Szeredi <mszeredi@redhat.com>, Steven Whitehouse <swhiteho@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Sage Weil <sweil@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, 29 Aug 2019 14:52:06 +0100
Stefan Hajnoczi <stefanha@redhat.com> wrote:

> Describe how shared memory region ID 0 is the DAX window and how
> FUSE_SETUPMAPPING maps file ranges into the window.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> The FUSE_SETUPMAPPING message is part of the virtio-fs Linux patches:
> https://gitlab.com/virtio-fs/linux/blob/virtio-fs/include/uapi/linux/fuse.h
> 
> v8:
>  * Make language about using both FUSE_READ/FUSE_WRITE and the DAX
>    Window clearer [Cornelia]
> v7:
>  * Clarify that the DAX Window is optional and can be used together with
>    FUSE_READ/FUSE_WRITE requests [Cornelia]
> v6:
>  * Document timing side-channel attacks [Michael]
> ---
>  virtio-fs.tex | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 66 insertions(+)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

