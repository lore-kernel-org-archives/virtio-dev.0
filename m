Return-Path: virtio-dev-return-5782-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 58E81985D74
	for <virtio-dev@lists.oasis-open.org>; Wed, 19 Jun 2019 01:29:19 +0000 (UTC)
Date: Tue, 18 Jun 2019 21:29:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190618210753-mutt-send-email-mst@kernel.org>
References: <20190220124613.22661-1-stefanha@redhat.com>
 <20190220124613.22661-2-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220124613.22661-2-stefanha@redhat.com>
Subject: Re: [virtio-dev] [PATCH v3 1/2] content: add virtio file system
 device
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Miklos Szeredi <mszeredi@redhat.com>, Sage Weil <sweil@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Steven Whitehouse <swhiteho@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Feb 20, 2019 at 12:46:12PM +0000, Stefan Hajnoczi wrote:
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
> --- a/content.tex
> +++ b/content.tex
> @@ -2634,6 +2634,8 @@ Device ID  &  Virtio Device    \\
>  \hline
>  24         &   Memory device \\
>  \hline
> +26         &   file system device \\
> +\hline
>  \end{tabular}
>  
>  Some of the devices above are unspecified by this document,
> @@ -5559,6 +5561,7 @@ descriptor for the \field{sense_len}, \field{residual},
>  \input{virtio-input.tex}
>  \input{virtio-crypto.tex}
>  \input{virtio-vsock.tex}
> +\input{virtio-fs.tex}
>  
>  \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
>  
> diff --git a/introduction.tex b/introduction.tex
> index a4ac01d..6eeda5d 100644
> --- a/introduction.tex
> +++ b/introduction.tex
> @@ -60,6 +60,9 @@ Levels'', BCP 14, RFC 2119, March 1997. \newline\url{http://www.ietf.org/rfc/rfc
>  	\phantomsection\label{intro:SCSI MMC}\textbf{[SCSI MMC]} &
>          SCSI Multimedia Commands,
>          \newline\url{http://www.t10.org/cgi-bin/ac.pl?t=f&f=mmc6r00.pdf}\\
> +	\phantomsection\label{intro:FUSE}\textbf{[FUSE]} &
> +	Linux FUSE interface,
> +	\newline\url{https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/uapi/linux/fuse.h}\\
>  
>  \end{longtable}
>  
> diff --git a/virtio-fs.tex b/virtio-fs.tex
> new file mode 100644
> index 0000000..5df5b9c
> --- /dev/null
> +++ b/virtio-fs.tex
> @@ -0,0 +1,196 @@
> +\section{File System Device}\label{sec:Device Types / File System Device}
> +
> +The virtio file system device provides file system access.  The device may
> +directly manage a file system or act as a gateway to a remote file system.  The
> +details of how files are accessed are hidden by the device interface, allowing
> +for a range of use cases.
> +
> +Unlike block-level storage devices such as virtio block and SCSI, the virtio
> +file system device provides file-level access to data.  The device interface is
> +based on the Linux Filesystem in Userspace (FUSE) protocol.  This consists of
> +requests for file system traversal and access the files and directories within
> +it.  The protocol details are defined by \hyperref[intro:FUSE]{FUSE}.
> +
> +The device acts as the FUSE file system daemon and the driver acts as the FUSE
> +client mounting the file system.  The virtio file system device provides the
> +mechanism for transporting FUSE requests, much like /dev/fuse in a traditional
> +FUSE application.
> +
> +This section relies on definitions from \hyperref[intro:FUSE]{FUSE}.
> +
> +\subsection{Device ID}\label{sec:Device Types / File System Device / Device ID}
> +  26
> +
> +\subsection{Virtqueues}\label{sec:Device Types / File System Device / Virtqueues}
> +
> +\begin{description}
> +\item[0] hiprio
> +\item[1\ldots n] request queues
> +\end{description}
> +
> +\subsection{Feature bits}\label{sec:Device Types / File System Device / Feature bits}
> +
> +There are currently no feature bits defined.
> +
> +\subsection{Device configuration layout}\label{sec:Device Types / File System Device / Device configuration layout}
> +
> +All fields of this configuration are always available.
> +
> +\begin{lstlisting}
> +struct virtio_fs_config {
> +        char tag[36];
> +        le32 num_queues;
> +};
> +\end{lstlisting}
> +
> +\begin{description}
> +\item[\field{tag}] is the name associated with this file system.  The tag is
> +    encoded in UTF-8 and padded with NUL bytes if shorter than the
> +    available space.  This field is not NUL-terminated if the encoded bytes
> +    take up the entire field.
> +\item[\field{num_queues}] is the total number of request virtqueues exposed by
> +    the device. The driver MAY use only one request queue,
> +    or it can use more to achieve better performance.

Pls copy instances of MAY,SHOULD,MUST into conformance sections.
Pls convert text outside of conformance sections to "can"
or "is allowed to" etc.

> +\end{description}
> +
> +\drivernormative{\subsubsection}{Device configuration layout}{Device Types / File System Device / Device configuration layout}
> +
> +The driver MUST NOT write to device configuration fields.
> +
> +\devicenormative{\subsubsection}{Device configuration layout}{Device Types / File System Device / Device configuration layout}
> +
> +The device MUST set \field{num_queues} to 1 or greater.
> +
> +\devicenormative{\subsection}{Device Initialization}{Device Types / File System Device / Device Initialization}
> +
> +On initialization the driver MUST first discover the
> +device's virtqueues.
> +
> +\subsection{Device Operation}\label{sec:Device Types / File System Device / Device Operation}
> +
> +Device operation consists of operating the virtqueues to facilitate file system
> +access.
> +
> +The FUSE request types are as follows:
> +\begin{itemize}
> +\item Normal requests are submitted by the driver and completed by the device.

made available and used, right?

> +\item Interrupt requests are submitted by the driver

again made available?

> to abort requests that the
> +      device may have yet to complete.

... did not use yet

> +\end{itemize}
> +
> +Note that FUSE notification requests are not supported.
> +
> +\subsubsection{Device Operation: Request Queues}\label{sec:Device Types / File System Device / Device Operation / Device Operation: Request Queues}
> +
> +The driver enqueues normal requests on an arbitrary request queue and they are
> +completed by the device on that same queue. It is the responsibility of the
> +driver to ensure strict request ordering for commands placed on different
> +queues, because they are consumed with no order constraints.

again available/used?

> +
> +Requests have the following format:
> +
> +\begin{lstlisting}
> +struct virtio_fs_req {
> +        // Device-readable part
> +        struct fuse_in_header in;
> +        u8 datain[];
> +
> +        // Device-writable part
> +        struct fuse_out_header out;
> +        u8 dataout[];
> +};
> +\end{lstlisting}
> +
> +Note that the words "in" and "out" follow the FUSE meaning and do not indicate
> +the direction of data transfer under VIRTIO.  "In" means input to a request and
> +"out" means output from processing a request.
> +
> +\field{in} is the common header for all types of FUSE requests.
> +
> +\field{datain} consists of request-specific data, if any.  This is identical to
> +the data read from the /dev/fuse device by a FUSE daemon.
> +
> +\field{out} is the completion header common to all types of FUSE requests.
> +
> +\field{dataout} consists of request-specific data, if any.  This is identical
> +to the data written to the /dev/fuse device by a FUSE daemon.
> +
> +For example, the full layout of a FUSE_READ request is as follows:
> +
> +\begin{lstlisting}
> +struct virtio_fs_read_req {
> +        // Device-readable part
> +        struct fuse_in_header in;
> +        union {
> +                struct fuse_read_in readin;
> +                u8 datain[sizeof(struct fuse_read_in)];
> +        };
> +
> +        // Device-writable part
> +        struct fuse_out_header out;
> +        u8 dataout[out.len - sizeof(struct fuse_out_header)];
> +};
> +\end{lstlisting}
> +
> +The FUSE protocol documented in \hyperref[intro:FUSE]{FUSE} specifies the set
> +of request types and their contents.  All request fields are little-endian.

I think this bears stressing some more.
Maybe "note that standard FUSE format does not specify endian-ness.
for virtio-fs, all fields are little-endian".

> +
> +\subsubsection{Device Operation: High Priority Queue}\label{sec:Device Types / File System Device / Device Operation / Device Operation: High Priority Queue}
> +
> +The hiprio queue follows the same request format as the requests queue.

As request queues?

>  This
> +queue only contains FUSE_INTERRUPT, FUSE_FORGET, and FUSE_BATCH_FORGET
> +requests.
> +
> +Interrupt and forget requests have a higher priority than normal requests.  In
> +order to ensure that they can always be delivered, even if all request queues
> +are full,


> a separate queue is used.

.. the separate hiprio queue is used for these requests - otherwise one wonders what is
that separate queue/

and I would change the order of this otherwise it's unclear
whether it's only used when queues are full.
E.g.

	The separate hiprio queue is used for these requests in order to
	ensure that they can be delivered even if all request queues
	are full.



> +
> +\devicenormative{\paragraph}{Device Operation: High Priority Queue}{Device Types / File System Device / Device Operation / Device Operation: High Priority Queue}
> +
> +The device SHOULD attempt to process the hiprio queue promptly.
> +
> +The device MAY process request queues concurrently with the hiprio queue.


I think one can make a stronger requirement: device must not
block processing hiprio because of a request queue - is
that right?

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


Last sentence is unclear. where does it follow from? did you mean
"however"?

> +
> +It is possible to maintain the FUSE session across live migration either by
> +transferring the state or by redirecting requests from the new host to the old
> +host where the state resides.  The details of how to achieve this are
> +implementation-dependent and are not visible at the device interface level.

One of the questions around transferring state is how to handle
version compatibility.
Linux does not need to worry because it never moves processes
to a different kernel without killing all userspace processes.


FUSE has version negotiation so I think it's solvable:
basically when device is instantiated it can be forced to
downgrade to support a specific protocol version,
that works on both sides.

But I think it's worth describing here at this high level.

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

