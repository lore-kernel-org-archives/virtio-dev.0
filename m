Return-Path: virtio-dev-return-5918-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E2E1F985DB0
	for <virtio-dev@lists.oasis-open.org>; Sat,  3 Aug 2019 21:21:25 +0000 (UTC)
Date: Sat, 3 Aug 2019 17:21:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190803171259-mutt-send-email-mst@kernel.org>
References: <20190726095338.24991-1-stefanha@redhat.com>
 <20190726095338.24991-2-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726095338.24991-2-stefanha@redhat.com>
Subject: Re: [virtio-dev] [PATCH v5 1/2] content: add virtio file system
 device
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Sage Weil <sweil@redhat.com>, Steven Whitehouse <swhiteho@redhat.com>, Miklos Szeredi <mszeredi@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Jul 26, 2019 at 10:53:37AM +0100, Stefan Hajnoczi wrote:
> +\subsubsection{Security Considerations}\label{sec:Device Types / File System Device / Security Considerations}

One issue not addressed here at all is sharing the filesystem cache.
Is that a security consiteration at all?
A shared resource is often an information sidechannel.


> +
> +The device provides access to a file system containing files owned by one or
> +more POSIX user ids and group ids.  The device has no secure way of
> +differentiating between users originating requests via the driver.  Therefore
> +the device accepts the POSIX user ids and group ids provided by the driver and
> +security is enforced by the driver rather than the device.  It is nevertheless
> +possible for devices to implement POSIX user id and group id mapping or
> +whitelisting to control the ownership and access available to the driver.
> +
> +File systems containing special files including device nodes and setuid
> +executable files pose a security concern.  These properties are defined by the
> +file type and mode, which are set by the driver when creating new files or by
> +changes at a later time.  These special files present a security risk when the
> +file system is shared with another system, such as the host or another guest.

is this a risk to someone using the device, another system
with which this one is sharing, or both?

> +This issue can be solved on some operating systems using mount options that
> +ignore special files.

For this to be effective should not device provide a way for device
to report that the issue exists?

>  It is also possible for devices to implement
> +restrictions on special files by refusing their creation.

And then it can safely be mounted without above flags?
How would a device do this? The list above is not exhaustive.

> +
> +When the device provides shared access to a file system, symlink race
> +conditions, exhausting file system capacity, and overwriting or deleting files
> +used by others are factors to consider.  These issues have a long history in
> +multi-user operating systems and also apply to virtio-fs.  They are typically
> +managed at the file system administration level by providing shared access only
> +to mutually trusted users.

Can we be a bit more explicit here? I think this discusses
a device accessing a shared filesystem with some other
device. I am guessing it's the administrator of the filesystem, right?


-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

