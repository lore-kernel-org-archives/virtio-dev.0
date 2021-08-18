Return-Path: <virtio-dev-return-8564-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 23C59986488
	for <virtio-dev@lists.oasis-open.org>; Wed, 18 Aug 2021 09:23:16 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20210813095216.487591-1-pankaj.gupta.linux@gmail.com>
References: <20210813095216.487591-1-pankaj.gupta.linux@gmail.com>
Date: Wed, 18 Aug 2021 11:22:53 +0200
Message-ID: <87r1errtsi.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH v2] virtio-pmem: PMEM device spec
Content-Type: text/plain
To: Pankaj Gupta <pankaj.gupta.linux@gmail.com>, virtio-dev@lists.oasis-open.org
Cc: stefanha@redhat.com, dan.j.williams@intel.com, david@redhat.com, mst@redhat.com, tstark@linux.microsoft.com, pankaj.gupta@ionos.com, Pankaj Gupta <pankaj.gupta.linux@gmail.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Aug 13 2021, Pankaj Gupta <pankaj.gupta.linux@gmail.com> wrote:

> Posting virtio specification for virtio pmem device. Virtio pmem is a
> paravirtualized device which allows the guest to bypass page cache.
> Virtio pmem kernel driver is merged in Upstream Kernel 5.3. Also, Qemu
> device is merged in Qemu 4.1.
>
> Signed-off-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> ---
> changes from v1 -> v2
> -----------------------
> Thanks to Cornelia, Stefan & David for the v1 review.
> - Use device & driver name instead of host & guest.
> - Remove implementation details from the spec.
> - Define FLUSH_REQUEST.
> - Other suggested changes.
>
>  conformance.tex |  18 ++++++-
>  content.tex     |   1 +
>  virtio-pmem.tex | 128 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 145 insertions(+), 2 deletions(-)
>  create mode 100644 virtio-pmem.tex

(...)

> +\subsection{Driver Operations}\label{sec:Device Types / PMEM Driver / Driver Operation}
> +\drivernormative{\subsubsection}{Driver Operation: Virtqueue command}{Device Types / PMEM Driver / Driver Operation / Virtqueue command}
> +
> +\begin{lstlisting}
> +struct virtio_pmem_req {
> +        __le32 type;
> +};
> +\end{lstlisting}
> +
> +Virtio pmem flush request:
> +\begin{lstlisting}
> +#define VIRTIO_PMEM_REQ_TYPE_FLUSH      0
> +\end{lstlisting}
> +
> +The driver MUST send VIRTIO_PMEM_REQ_TYPE_FLUSH command on request virtqueue.
> +
> +The driver SHOULD be able to handle concurrent FLUSH requests.

I'm wondering what part of all of this should go into a normative
section, and what into a more descriptive paragraph.

Contants, structure definitions etc. can go into a descriptive
paragraph; I don't think we need to spell out that a conforming device
or driver actually needs to use those...

We maybe should have a non-normative paragraph that describes the normal
operation; i.e. the driver queues a flush request on the request queue
when it wants to persist something, the device acts on the flush request
and persists the writes made before the flush. That section could also
give some helpful hints to implementors that should not be binding (if
you have anything like that.)

The driver normative section could then be something like "The driver
MUST NOT consider any writes prior to a flush command to be persistent
until after the device successfully processed that flush command" or
something like that. The device normative section for the flush
operation looks fine to me.

> +
> +\subsection{Device Operations}\label{sec:Device Types / PMEM Driver / Device Operation}
> +\devicenormative{\subsubsection}{Device Operation: Virtqueue flush}{Device Types / PMEM Device / Device Operation / Virtqueue flush}
> +
> +The device MUST ensure that all writes made before a flush request will persist across device reset and power failure before completing the flush request.
> +
> +\devicenormative{\subsubsection}{Device Operation: Virtqueue return}{Device Types / PMEM Device / Device Operation / Virtqueue return}
> +
> +The device MUST return integer "0" for success and "-1" for failure.
> +
> +\subsection{Possible security implications}\label{sec:Device Types / PMEM Device / Possible Security Implications}
> +
> +There could be potential security implications depending on how
> +memory mapped device backing file is used. By default device emulation
> +is done with SHARED mapping. There is a contract between driver and device
> +process to access same backing file for read or write operations.
> +
> +If a malicious driver or device map the same backing file, attacking
> +process can make use of known cache side channel attacks to predict
> +the current state of shared page cache page. If both attacker and 
> +victim somehow execute same shared code after a flush or evict call, 
> +with difference in execution timing attacker could infer another driver
> +local data or device data. Though this is not easy and same challenges
> +exist as with bare metal device system when userspace share same backing file.

I'm not 100% sure about this section. Is it more or less Linux-specific,
or can it be made a bit more implementation agnostic? As this is not my
area of expertise, maybe others can chime in.

> +
> +\subsection{Countermeasures}\label{sec:Device Types / PMEM Device / Possible Security Implications / Countermeasures}
> +
> +\subsubsection{ With SHARED mapping}\label{sec:Device Types / PMEM Device / Possible Security Implications / Countermeasures / SHARED}
> +
> +If device backing backing file is shared with multiple driver or device, 
> +this may act as a metric for page cache side channel attack. As a counter
> +measure every driver should have its own(not shared with another driver)
> +SHARED backing file and gets populated a per device page cache pages.
> +
> +\subsubsection{ With PRIVATE mapping}\label{sec:Device Types / PMEM Device / Possible Security Implications / Countermeasures / PRIVATE}
> +There maybe be chances of side channels attack with PRIVATE
> +memory mapping similar to SHARED with read-only shared mappings.
> +PRIVATE is not used for virtio pmem making this usecase
> +irrelevant.
> +
> +\subsubsection{ Workload specific mapping}\label{sec:Device Types / PMEM Device / Possible Security Implications / Countermeasures / Workload}
> +For SHARED mapping, if workload is single application inside
> +the driver and there is no risk with sharing of data between the devices.
> +Driver sharing same backing file with SHARED mapping can be
> +used as a valid configuration.
> +
> +\subsubsection{ Prevent cache eviction}\label{sec:Device Types / PMEM Device / Possible Security Implications / Countermeasures / Cache eviction}
> +Don't allow cache evict from driver filesystem trim or discard command
> +with virtio pmem. This rules out any possibility of evict-reload
> +page cache side channel attacks if backing disk is shared(SHARED)
> +with mutliple drivers. Though if we use per device backing file with
> +shared mapping this countermeasure is not required.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

