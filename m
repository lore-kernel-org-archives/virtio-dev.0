Return-Path: virtio-comment-return-744-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Mon, 17 Jun 2019 14:30:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190617142554-mutt-send-email-mst@kernel.org>
References: <20190320120740.8514-1-dgilbert@redhat.com>
 <20190320120740.8514-2-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320120740.8514-2-dgilbert@redhat.com>
Subject: Re: [virtio-comment] [PATCH v4 1/3] shared memory: Define shared
 memory regions
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org, stefanha@redha.com, cohuck@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Mar 20, 2019 at 12:07:38PM +0000, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Define the requirements and idea behind shared memory regions.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  conformance.tex |  1 +
>  content.tex     |  2 ++
>  shared-mem.tex  | 40 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 43 insertions(+)
>  create mode 100644 shared-mem.tex
> 
> diff --git a/conformance.tex b/conformance.tex
> index ad7e82e..f6c0d50 100644
> --- a/conformance.tex
> +++ b/conformance.tex
> @@ -195,6 +195,7 @@ A device MUST conform to the following normative statements:
>  \item \ref{devicenormative:Basic Facilities of a Virtio Device / Virtqueues / Used Buffer Notification Suppression}
>  \item \ref{devicenormative:Basic Facilities of a Virtio Device / Virtqueues / The Virtqueue Used Ring}
>  \item \ref{devicenormative:Basic Facilities of a Virtio Device / Virtqueues / Available Buffer Notification Suppression}
> +\item \ref{devicenormative:Basic Facilities of a Virtio Device / Shared Memory Regions}
>  \item \ref{devicenormative:Reserved Feature Bits}
>  \end{itemize}
>  
> diff --git a/content.tex b/content.tex
> index ede0ef6..8cd1a38 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -371,6 +371,8 @@ making any more buffers available. When VIRTIO_F_NOTIFICATION_DATA
>  has been negotiated, these notifications would then have
>  identical \field{next_off} and \field{next_wrap} values.
>  
> +\input{shared-mem.tex}
> +
>  \chapter{General Initialization And Device Operation}\label{sec:General Initialization And Device Operation}
>  
>  We start with an overview of device initialization, then expand on the
> diff --git a/shared-mem.tex b/shared-mem.tex
> new file mode 100644
> index 0000000..6dc506a
> --- /dev/null
> +++ b/shared-mem.tex
> @@ -0,0 +1,40 @@
> +\section{Shared Memory Regions}\label{sec:Basic Facilities of a Virtio Device / Shared Memory Regions}
> +
> +Shared memory regions are an additional facility
> +available to devices that need a region of memory that's
> +continuously shared between the host and the guest, rather
> +than passed between them in the way virtqueue elements are.

Please rewrite host->device, guest->driver

> +
> +Example uses include shared caches and version pools for versioned
> +data structures.
> +
> +The region is chosen by the host and presented to the guest, as
> +such it is useful in situations where the memory is accessed on
> +the host by other libraries that can't safely access guest RAM.

I'm not sure what does above mean in context of virtio.
Is this an example?
So maybe:
	For example, with device being part of a
	hypervisor and driver being part of a VM guest
	etc etc

> +
> +A device may have multiple shared memory regions associated with
> +it.  Each region has a \field{shmid} to identify it, the meaning
> +of which is device-specific.
> +
> +Enumeration and location of shared memory regions is performed
> +using a transport-specific data structure and mechanism.

Let's just say in a transport-specific way.

> +
> +Memory consistency rules vary depending on the region and the
> +device and they will be specified as required by each device.
> +
> +\subsection{Addressing within regions}\label{sec:Basic Facilities of a Virtio Device / Shared Memory Regions / Addressing within regions }
> +
> +References into shared memory regions are represented as offsets from
> +the beginning of the region instead of absolute memory addresses.
> +Offsets are used both for references between structures stored
> +within shared memory and for requests placed in virtqueues that
> +refer to shared memory.
> +The \field{shmid} may be explicit or may be inferred from the
> +context of the reference.
> +
> +\devicenormative{\subsection}{Shared Memory Regions}{Basic Facilities of a Virtio
> +Device / Shared Memory Regions}
> +Shared memory regions MUST NOT expose shared memory regions which
> +are used to control the operation of the device, nor to stream
> +data.

regions must not expose regions. confused.
typo?

Also, what does stream data mean?


> +
> -- 
> 2.20.1
> 
> 
> This publicly archived list offers a means to provide input to the
> OASIS Virtual I/O Device (VIRTIO) TC.
> 
> In order to verify user consent to the Feedback License terms and
> to minimize spam in the list archive, subscription is required
> before posting.
> 
> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> List help: virtio-comment-help@lists.oasis-open.org
> List archive: https://lists.oasis-open.org/archives/virtio-comment/
> Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
> List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
> Committee: https://www.oasis-open.org/committees/virtio/
> Join OASIS: https://www.oasis-open.org/join/

This publicly archived list offers a means to provide input to the
OASIS Virtual I/O Device (VIRTIO) TC.

In order to verify user consent to the Feedback License terms and
to minimize spam in the list archive, subscription is required
before posting.

Subscribe: virtio-comment-subscribe@lists.oasis-open.org
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
List help: virtio-comment-help@lists.oasis-open.org
List archive: https://lists.oasis-open.org/archives/virtio-comment/
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

