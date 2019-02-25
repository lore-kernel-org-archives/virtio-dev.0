Return-Path: virtio-dev-return-5517-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 687F6985AA5
	for <virtio-dev@lists.oasis-open.org>; Mon, 25 Feb 2019 16:11:57 +0000 (UTC)
Date: Mon, 25 Feb 2019 16:11:49 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190225161148.GD2710@work-vm>
References: <20190220124613.22661-1-stefanha@redhat.com>
 <20190220124613.22661-2-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220124613.22661-2-stefanha@redhat.com>
Subject: [virtio-dev] Re: [PATCH v3 1/2] content: add virtio file system device
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Miklos Szeredi <mszeredi@redhat.com>, Sage Weil <sweil@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Steven Whitehouse <swhiteho@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

* Stefan Hajnoczi (stefanha@redhat.com) wrote:
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
>  content.tex      |   3 +
>  introduction.tex |   3 +
>  virtio-fs.tex    | 196 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 202 insertions(+)
>  create mode 100644 virtio-fs.tex
> 
> diff --git a/content.tex b/content.tex
> index 836ee52..ac41fdb 100644

> +The FUSE protocol documented in \hyperref[intro:FUSE]{FUSE} specifies the set
> +of request types and their contents.  All request fields are little-endian.

FUSE doesn't seem to define it's endianness - and I'm not sure it's
worth it for us to define it and do the work of adding a byteswapping
shim.  It would be reasonably invasive in the kernel code to do that
if we're the only user, and really I think the chances of having a
cross-endian user are pretty slim; so adding invasive code for a
non-existent user seems a bad thing.
IMHO we should just stick with the existing FUSE definition; I believe
it's possible to detect a byteswapped interface by validating the
'opcode' field of the fuse_in_header; existing daemons should just error
on this; in the unlikely event that someone discovers they really want
a cross endian implementation then they can add that byteswapping in
their daemon.

We should still keep the virtio level little endian of course.

Dave

> +\subsubsection{Device Operation: High Priority Queue}\label{sec:Device Types / File System Device / Device Operation / Device Operation: High Priority Queue}
> +
> +The hiprio queue follows the same request format as the requests queue.  This
> +queue only contains FUSE_INTERRUPT, FUSE_FORGET, and FUSE_BATCH_FORGET
> +requests.
> +
> +Interrupt and forget requests have a higher priority than normal requests.  In
> +order to ensure that they can always be delivered, even if all request queues
> +are full, a separate queue is used.
> +
> +\devicenormative{\paragraph}{Device Operation: High Priority Queue}{Device Types / File System Device / Device Operation / Device Operation: High Priority Queue}
> +
> +The device SHOULD attempt to process the hiprio queue promptly.
> +
> +The device MAY process request queues concurrently with the hiprio queue.
> +
> +\drivernormative{\paragraph}{Device Operation: High Priority Queue}{Device Types / File System Device / Device Operation / Device Operation: High Priority Queue}
> +
> +The driver MUST submit FUSE_INTERRUPT, FUSE_FORGET, and FUSE_BATCH_FORGET requests solely on the hiprio queue.
> +
> +The driver MUST anticipate that request queues are processed concurrently with the hiprio queue.
> +
> +\subsubsection{Security Considerations}\label{sec:Device Types / File System Device / Security Considerations}
> +
> +The device provides access to a file system that may contain files owned by
> +different POSIX user ids and group ids.  The device has no secure way of
> +differentiating between users originating requests via the driver.  Therefore
> +the device accepts the POSIX user ids and group ids provided by the driver and
> +security is enforced by the driver rather than the device.  It is nevertheless
> +possible for devices to implement POSIX user id and group id mapping or
> +whitelisting to control the ownership and access available to the driver.
> +
> +The file system may contain special files including device nodes and setuid
> +executable files.  These properties are defined by the file type and mode,
> +which may be set by the driver when creating new files or changed at a later
> +time.  These special files present a security risk when the file system is
> +shared with another system, such as the host or another guest.  This issue can
> +be solved on some operating systems using mount options that ignore special
> +files.  It is also possible for devices to implement restrictions on special
> +files by refusing their creation.
> +
> +When the device provides shared access to a file system the possibility of
> +symlink race conditions, exhausting file system capacity, and overwriting or
> +deleting files used by others must be taken into account.  These issues have a
> +long history in multi-user operating systems and should not be overlooked with
> +virtio devices.
> +
> +\subsubsection{Live migration considerations}\label{sec:Device Types / File System Device / Live Migration Considerations}
> +
> +When a guest is migrated to a new host it is necessary to consider the FUSE
> +session and its state.  The continuity of FUSE inode numbers (also known as
> +nodeids) and fh values is necessary so the driver can continue operation
> +without disruption.  Therefore it is trivial to migrate before a FUSE session
> +has been started with FUSE_INIT.
> +
> +It is possible to maintain the FUSE session across live migration either by
> +transferring the state or by redirecting requests from the new host to the old
> +host where the state resides.  The details of how to achieve this are
> +implementation-dependent and are not visible at the device interface level.
> -- 
> 2.20.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

