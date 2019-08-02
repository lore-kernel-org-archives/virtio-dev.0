Return-Path: virtio-dev-return-5915-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 812D8985D51
	for <virtio-dev@lists.oasis-open.org>; Fri,  2 Aug 2019 15:49:58 +0000 (UTC)
Date: Fri, 2 Aug 2019 16:49:51 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190802154951.GC22284@stefanha-x1.localdomain>
References: <20190726095338.24991-1-stefanha@redhat.com>
 <20190726095338.24991-2-stefanha@redhat.com>
 <20190731115846.3c2e11f2.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731115846.3c2e11f2.cohuck@redhat.com>
Subject: Re: [virtio-dev] [PATCH v5 1/2] content: add virtio file system
 device
To: Cornelia Huck <cohuck@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Sage Weil <sweil@redhat.com>, Steven Whitehouse <swhiteho@redhat.com>, Miklos Szeredi <mszeredi@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jul 31, 2019 at 11:58:46AM +0200, Cornelia Huck wrote:
> On Fri, 26 Jul 2019 10:53:37 +0100
> Stefan Hajnoczi <stefanha@redhat.com> wrote:
> > +\drivernormative{\subsubsection}{Device configuration layout}{Device Types / File System Device / Device configuration layout}
> > +
> > +The driver MUST NOT write to device configuration fields.
> > +
> > +The driver MAY use from one up to \field{num_queues} virtqueues.
> 
> s/virtqueues/request virtqueues/ ? I'm still a bit unsure about the
> requirements for queue usage, see below.

Will fix, thanks.

> 
> > +
> > +\devicenormative{\subsubsection}{Device configuration layout}{Device Types / File System Device / Device configuration layout}
> > +
> > +The device MUST set \field{num_queues} to 1 or greater.
> > +
> > +\subsection{Device Initialization}\label{Device Types / File System Device / Device Initialization}
> > +
> > +On initialization the driver first discovers the device's virtqueues.  The FUSE
> > +session is started by sending a FUSE\_INIT request as defined by the FUSE
> > +protocol on one request virtqueue.  All virtqueues provide access to the same
> > +FUSE session and therefore only one FUSE\_INIT request is required regardless
> > +of the number of available virtqueues.
> > +
> > +\subsection{Device Operation}\label{sec:Device Types / File System Device / Device Operation}
> > +
> > +Device operation consists of operating the virtqueues to facilitate file system
> > +access.
> > +
> > +The FUSE request types are as follows:
> > +\begin{itemize}
> > +\item Normal requests are made available by the driver and used by the device.
> 
> These go via the normal request queues...
> 
> > +\item Interrupt requests are made available by the driver to abort requests
> > +      that the device has not used yet.
> 
> ...and these via the hiprio queue?

Yes.

> 
> > +\end{itemize}
> > +
> > +Note that FUSE notification requests are not supported.
> > +
> > +\subsubsection{Device Operation: Request Queues}\label{sec:Device Types / File System Device / Device Operation / Device Operation: Request Queues}
> > +
> > +The driver enqueues normal requests on an arbitrary request queue and they are
> > +completed by the device on that same queue.
> 
> Do we need a device normative statement that requests MUST be completed
> on the queue they have been submitted on?

That would be impossible since the request struct has both IN and OUT
elements.  virtio-fs is a request+response queue design like
virtio-blk/virtio-scsi, not a rx/tx queue design like
virtio-net/virtio-vsock.

> 
> > The device processes requests in
> > +any order.  The driver is responsible for ensuring that ordering constraints
> > +are met by making available a dependent request only after its prerequisite
> > +request has been used.
> > +
> > +Requests have the following format:
> 
> These can be either LE or BE from what is stated below, right? Maybe
> spell it out here already?

I will add "with the endianness chosen by the driver as detailed below".

> 
> > +
> > +\begin{lstlisting}
> > +struct virtio_fs_req {
> > +        // Device-readable part
> > +        struct fuse_in_header in;
> > +        u8 datain[];
> > +
> > +        // Device-writable part
> > +        struct fuse_out_header out;
> > +        u8 dataout[];
> > +};
> > +\end{lstlisting}
> > +
> > +Note that the words "in" and "out" follow the FUSE meaning and do not indicate
> > +the direction of data transfer under VIRTIO.  "In" means input to a request and
> > +"out" means output from processing a request.
> > +
> > +\field{in} is the common header for all types of FUSE requests.
> > +
> > +\field{datain} consists of request-specific data, if any.  This is identical to
> > +the data read from the /dev/fuse device by a FUSE daemon.
> > +
> > +\field{out} is the completion header common to all types of FUSE requests.
> > +
> > +\field{dataout} consists of request-specific data, if any.  This is identical
> > +to the data written to the /dev/fuse device by a FUSE daemon.
> > +
> > +For example, the full layout of a FUSE\_READ request is as follows:
> > +
> > +\begin{lstlisting}
> > +struct virtio_fs_read_req {
> > +        // Device-readable part
> > +        struct fuse_in_header in;
> > +        union {
> > +                struct fuse_read_in readin;
> > +                u8 datain[sizeof(struct fuse_read_in)];
> > +        };
> > +
> > +        // Device-writable part
> > +        struct fuse_out_header out;
> > +        u8 dataout[out.len - sizeof(struct fuse_out_header)];
> > +};
> > +\end{lstlisting}
> > +
> > +The FUSE protocol documented in \hyperref[intro:FUSE]{FUSE} specifies the set
> > +of request types and their contents.
> > +
> > +The endianness of the FUSE protocol session is detectable by inspecting the
> > +uint32\_t \field{in.opcode} field of the FUSE\_INIT request sent by the driver
> > +to the device.  This allows the device to determine whether the session is
> > +little-endian or big-endian.
> 
> Do we need a driver normative statement that the driver MUST NOT send a
> request with a different endianness once it established the session's
> endianness via FUSE_INIT?

It is valid to send another FUSE_INIT to switch to a fresh session.  In
that case the driver could change the endianness again.  I think we want
this just in case a weird system without fixed endianness has a
bootloader running in little-endian and a guest kernel running in
big-endian, for example.

I will document this in the next revision.

> 
> > +
> > +\subsubsection{Device Operation: High Priority Queue}\label{sec:Device Types / File System Device / Device Operation / Device Operation: High Priority Queue}
> > +
> > +The hiprio queue follows the same request format as the request queues.  This
> > +queue only contains FUSE\_INTERRUPT, FUSE\_FORGET, and FUSE\_BATCH\_FORGET
> > +requests.
> 
> Does this also imply that normal request queues can't be used for
> interrupt and forget requests? The normative statement below seems to
> imply that, but I think the text here does not make it clear already.

Yes, these requests must only be placed on the hiprio queue.  Will
clarify, thanks!

> > +
> > +Interrupt and forget requests have a higher priority than normal requests.  The
> > +separate hiprio queue is used for these requests to ensure they can be
> > +delivered even when all request queues are full.
> > +
> > +\devicenormative{\paragraph}{Device Operation: High Priority Queue}{Device Types / File System Device / Device Operation / Device Operation: High Priority Queue}
> > +
> > +The device MUST NOT pause processing of the hiprio queue due to activity on a
> > +normal request queue.
> > +
> > +The device MAY process request queues concurrently with the hiprio queue.
> > +
> > +\drivernormative{\paragraph}{Device Operation: High Priority Queue}{Device Types / File System Device / Device Operation / Device Operation: High Priority Queue}
> > +
> > +The driver MUST submit FUSE\_INTERRUPT, FUSE\_FORGET, and FUSE\_BATCH\_FORGET requests solely on the hiprio queue.
> 
> This specifies that the driver MUST submit interrupt and forget request
> via the hiprio queue, but it does not specify that no other requests
> may go via the hiprio queue, what the descriptive text above implies.

Will clarify.

Thank you for your review!

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

