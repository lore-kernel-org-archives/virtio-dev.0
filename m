Return-Path: virtio-comment-return-691-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Tue, 5 Mar 2019 18:54:24 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190305185424.342673ef.cohuck@redhat.com>
In-Reply-To: <20190304132531.10507-2-dgilbert@redhat.com>
References: <20190304132531.10507-1-dgilbert@redhat.com>
	<20190304132531.10507-2-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [virtio-comment] Re: [PATCH v3 1/3] shared memory: Define shared memory regions
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, stefanha@redhat.com, sebastien.boeuf@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon,  4 Mar 2019 13:25:29 +0000
"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:

> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Define the requirements and idea behind shared memory regions.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  conformance.tex |  1 +
>  content.tex     |  2 ++
>  shared-mem.tex  | 40 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 43 insertions(+)
>  create mode 100644 shared-mem.tex
> 
(...)
> diff --git a/shared-mem.tex b/shared-mem.tex
> new file mode 100644
> index 0000000..86b0050
> --- /dev/null
> +++ b/shared-mem.tex
> @@ -0,0 +1,40 @@
> +\section{Shared Memory Regions}\label{sec:Basic Facilities of a Virtio Device / Shared Memory Regions}
> +
> +Shared memory regions are an additional facility
> +available to devices that need a region of memory that's
> +continuously shared between the host and the guest, rather
> +than passed between them in the way virtqueue elements are.
> +
> +Example uses include shared caches and version pools for versioned
> +data structures.
> +
> +The region is chosen by the host and presented to the guest, as
> +such it is useful in situations where the memory is accessed on
> +the host by other libraries that can't safely access guest RAM.
> +
> +A device may have multiple shared memory regions associated with
> +it.  Each region has a \field{shmid} to identify it, the meaning
> +of which is device-specific.
> +
> +Enumeration and location of shared memory regions is performed
> +using a transport-specific data structure and mechanism.
> +
> +Memory consistency rules vary depending on the region and the
> +device and they will be specified as required by each device.
> +
> +\subsection{Addressing within regions}\label{sec:Basic Facilities of a Virtio Device / Shared Memory Regions / Addressing within regions }
> +
> +Commands sent over the virtqueues may refer to data within the
> +shared memory regions, for example a command may be used by a
> +driver to cause a device to add or remove a mapping within
> +a region.  When referring to data, the addresses will normally be
> +offsets within a particular region rather than absolute host or
> +guest addresses.  The \field{shmid} may be explicit or may be
> +inferred from the command type.

It's probably reasonable to frame it like that instead of making it a
normative statement.

Maybe "the addresses are expected to be offsets"? It would feel odd if
most devices handled it like that and then an oddball device came
along...

> +
> +\devicenormative{\subsection}{Shared Memory Regions}{Basic Facilities of a Virtio
> +Device / Shared Memory Regions}
> +Shared memory regions MUST NOT expose shared memory regions which
> +are used to control the operation of the device, nor to stream
> +data.
> +

Otherwise, looks good to me.

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

