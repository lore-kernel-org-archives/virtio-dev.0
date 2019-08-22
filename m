Return-Path: virtio-dev-return-6007-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7A84C985C7E
	for <virtio-dev@lists.oasis-open.org>; Thu, 22 Aug 2019 11:23:55 +0000 (UTC)
Date: Thu, 22 Aug 2019 13:23:45 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190822132345.2c8920c1.cohuck@redhat.com>
In-Reply-To: <20190813131320.30829-2-stefanha@redhat.com>
References: <20190813131320.30829-1-stefanha@redhat.com>
	<20190813131320.30829-2-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-dev] [PATCH v6 1/2] content: add virtio file system
 device
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Sage Weil <sweil@redhat.com>, "Dr.
 David Alan Gilbert" <dgilbert@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Steven Whitehouse <swhiteho@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Miklos Szeredi <mszeredi@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, 13 Aug 2019 14:13:19 +0100
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
>  virtio-fs.tex    | 224 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 228 insertions(+)
>  create mode 100644 virtio-fs.tex

(...)

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
> +    the device.  Each virtqueue offers identical functionality and there are no
> +    ordering guarantees between requests made available on different queues.
> +    Use of multiple queues is intended to increase performance.

As this came up during review of the qemu implementation of the device:
num_queues is not the number of virtqueues of the device, but rather
the number of request queues -- which is clear from the description,
but not from the field name. Maybe rename this field to
num_request_queues or so?

> +\end{description}

(...)

> +\subsubsection{Device Operation: Request Queues}\label{sec:Device Types / File System Device / Device Operation / Device Operation: Request Queues}
> +
> +The driver enqueues normal requests on an arbitrary request queue. High
> +priority requests are not placed on request queues.  The device processes
> +requests in any order.  The driver is responsible for ensuring that ordering
> +constraints are met by making available a dependent request only after its
> +prerequisite request has been used.
> +
> +Requests have the following format with endianness chosen by the driver as

"chosen by the driver in the FUSE_INIT request used to initiate the
session", maybe? You describe this below, but I think it would be
easier to understand if you mentioned it here already.

> +detailed below:
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
> +For example, the full layout of a FUSE\_READ request is as follows:
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
> +of request types and their contents.
> +
> +The endianness of the FUSE protocol session is detectable by inspecting the
> +uint32\_t \field{in.opcode} field of the FUSE\_INIT request sent by the driver
> +to the device.  This allows the device to determine whether the session is
> +little-endian or big-endian.  The next FUSE\_INIT message terminates the
> +current session and starts a new session with the possibility of changing
> +endianness.

(...)

Otherwise, looks good to me.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

