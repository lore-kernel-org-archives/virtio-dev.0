Return-Path: <virtio-dev-return-8789-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3C219986495
	for <virtio-dev@lists.oasis-open.org>; Wed,  6 Oct 2021 07:09:40 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20211006062157.21768-1-pankaj.gupta.linux@gmail.com>
References: <20211006062157.21768-1-pankaj.gupta.linux@gmail.com>
Date: Wed, 06 Oct 2021 09:09:34 +0200
Message-ID: <874k9u1vf5.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH v5] virtio-pmem: PMEM device spec
Content-Type: text/plain
To: Pankaj Gupta <pankaj.gupta.linux@gmail.com>, virtio-dev@lists.oasis-open.org
Cc: stefanha@redhat.com, dan.j.williams@intel.com, david@redhat.com, mst@redhat.com, tstark@linux.microsoft.com, pankaj.gupta@ionos.com, Pankaj Gupta <pankaj.gupta.linux@gmail.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Oct 06 2021, Pankaj Gupta <pankaj.gupta.linux@gmail.com> wrote:

> Posting virtio specification for virtio pmem device. Virtio pmem is a
> paravirtualized device which allows the guest to bypass page cache.
> Virtio pmem kernel driver is merged in Upstream Kernel 5.3. Also, Qemu
> device is merged in Qemu 4.1.
>
> Signed-off-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> ---
>
> Incorporated all the suggestions during the review. Request for
> merging the spec. 
>
> v3 -> v4
>   Text format changes in security implication section - Stefan
>   Minor text/while space change - Cornelia
>
>  conformance.tex |  16 +++++-
>  content.tex     |   1 +
>  virtio-pmem.tex | 128 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 143 insertions(+), 2 deletions(-)
>  create mode 100644 virtio-pmem.tex
>

(...)

> +\subsection{Possible security implications}\label{sec:Device Types / PMEM Device / Possible Security Implications}
> +
> +There could be potential security implications depending on how
> +memory mapped backing device is used. By default device emulation
> +is done with SHARED memory mapping. There is a contract between driver
> +and device to access shared memory region for read or write operations.
> +
> +If a malicious driver or device maps the same memory region, the attacker
> +can make use of known side channel attacks to predict the current state of data.
> +If both attacker and victim somehow execute same shared code after a flush
> +or evict operation, with difference in execution timing attacker could infer
> +another device's data.
> +
> +\subsection{Countermeasures}\label{sec:Device Types / PMEM Device / Possible Security Implications / Countermeasures}
> +
> +\subsubsection{ With SHARED mapping}\label{sec:Device Types / PMEM Device / Possible Security Implications / Countermeasures / SHARED}

Nit: drop the space after the opening bracket (also below.)

> +
> +If a device's backing region is shared between multiple devices, this may act
> +as a metric for side channel attacks. As a counter measure every device
> +should have its own (not shared with another driver) SHARED backing memory.
> +
> +\subsubsection{ With PRIVATE mapping}\label{sec:Device Types / PMEM Device / Possible Security Implications / Countermeasures / PRIVATE}
> +There maybe be chances of side channels attack with PRIVATE
> +memory mapping similar to SHARED with read-only shared mappings.
> +PRIVATE is not used for virtio pmem making this usecase
> +irrelevant.
> +
> +\subsubsection{ Workload specific mapping}\label{sec:Device Types / PMEM Device / Possible Security Implications / Countermeasures / Workload}
> +For SHARED mappings, for the workload is a single application inside
> +the driver and there is no risk in sharing data. Device sharing

Sorry for noticing this only now, but I have trouble parsing this
sentence. Does it mean that you can use SHARED mapping if the workload
is a single application?

> +same backing region with SHARED mapping can be used as a valid configuration.
> +
> +\subsubsection{ Prevent cache eviction}\label{sec:Device Types / PMEM Device / Possible Security Implications / Countermeasures / Cache eviction}
> +Don't allow device shared region eviction from driver filesystem trim or discard
> +like commands with virtio pmem. This rules out any possibility of evict-reload
> +cache side channel attacks if backing region is shared (SHARED)
> +between mutliple devices. Though if we use per device backing file with
> +shared mapping this countermeasure is not required.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

