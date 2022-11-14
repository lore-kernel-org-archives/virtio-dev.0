Return-Path: <virtio-dev-return-10157-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2CE779863FE
	for <virtio-dev@lists.oasis-open.org>; Mon, 14 Nov 2022 14:25:37 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20221101120428.9500-3-xuanzhuo@linux.alibaba.com>
References: <20221101120428.9500-1-xuanzhuo@linux.alibaba.com>
 <20221101120428.9500-3-xuanzhuo@linux.alibaba.com>
Date: Mon, 14 Nov 2022 15:25:28 +0100
Message-ID: <87h6z1txyf.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH v1 2/2] virtio-ism: introduce new device virtio-ism
Content-Type: text/plain
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtio-dev@lists.oasis-open.org
Cc: hans@linux.alibaba.com, herongguang@linux.alibaba.com, zmlcc@linux.alibaba.com, dust.li@linux.alibaba.com, tonylu@linux.alibaba.com, zhenzao@linux.alibaba.com, helinguo@linux.alibaba.com, gerry@linux.alibaba.com, xuanzhuo@linux.alibaba.com, mst@redhat.com, jasowang@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Nov 01 2022, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:

> The virtio ism device provides and manages many memory ism regions in
> host. These ism regions can be alloc/attach/detach by driver. Every
> ism region can be shared by token with other VM after allocation.
> The driver obtains the memory region on the host through the memory on
> the device.
>
> |-------------------------------------------------------------------------------------------------------------|
> | |------------------------------------------------|       |------------------------------------------------| |
> | | Guest                                          |       | Guest                                          | |
> | |                                                |       |                                                | |
> | |   ----------------                             |       |   ----------------                             | |
> | |   |    driver    |     [M1]   [M2]   [M3]      |       |   |    driver    |             [M2]   [M3]     | |
> | |   ----------------       |      |      |       |       |   ----------------               |      |      | |
> | |    |cq|                  |map   |map   |map    |       |    |cq|                          |map   |map   | |
> | |    |  |                  |      |      |       |       |    |  |                          |      |      | |
> | |    |  |                -------------------     |       |    |  |                --------------------    | |
> | |----|--|----------------|  device memory  |-----|       |----|--|----------------|  device memory   |----| |
> | |    |  |                -------------------     |       |    |  |                --------------------    | |
> | |                                |               |       |                               |                | |
> | |                                |               |       |                               |                | |
> | | Qemu                           |               |       | Qemu                          |                | |
> | |--------------------------------+---------------|       |-------------------------------+----------------| |
> |                                  |                                                       |                  |
> |                                  |                                                       |                  |
> |                                  |------------------------------+------------------------|                  |
> |                                                                 |                                           |
> |                                                                 |                                           |
> |                                                   --------------------------                                |
> |                                                    | M1 |   | M2 |   | M3 |                                 |
> |                                                   --------------------------                                |
> |                                                                                                             |
> | HOST                                                                                                        |
> ---------------------------------------------------------------------------------------------------------------
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
> Signed-off-by: Dust Li <dust.li@linux.alibaba.com>
> Signed-off-by: Tony Lu <tonylu@linux.alibaba.com>
> Signed-off-by: Helin Guo <helinguo@linux.alibaba.com>
> Signed-off-by: Hans Zhang <hans@linux.alibaba.com>
> Signed-off-by: He Rongguang <herongguang@linux.alibaba.com>
> ---
>  content.tex    |   1 +
>  virtio-ism.tex | 350 +++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 351 insertions(+)
>  create mode 100644 virtio-ism.tex

<mostly formal things>

(...)

> +\devicenormative{\subsubsection}{Device configuration layout}{Device Types / ISM Device / Device configuration layout}
> +
> +The device MUST ensure that the gid generated each time on the same host is the
> +same and different from the gid on other host.

Maybe "The device MUST ensure that the gid is immutable and unique for
the (host/<better term>)." ?

Is there a way to avoid the term "host" (throughout this document)?
IIUC, you need the uniqueness within the scope of the entity that
launches the different instances that get shared access to the regions
(which could conceivably a unit of hardware?) TBF, I don't know what
requirements are actually needed for the gid's uniqueness... probably
not world-wide :)

> +
> +On the same host, the device MUST ensure that the devid generated each time is
> +unique and not 0.

"The device MUST ensure that the devid is unique per (host/<better
term>) and not 0." ?

> +
> +
> +\subsection{Event}\label{sec:Device Types / Network Device / Device Operation / Event}
> +
> +When VIRTIO_ISM_F_EVENT_VQ or VIRTIO_ISM_F_EVENT_IRQ is negotiated, the ism
> +device supports event notification of ism region update. After the device
> +receives the notification from the driver, it MUST notify other guests that

This "MUST" statement needs to go into a conformance section.

> +refer to this ism region.
> +
> +Such a structure will be received if VIRTIO_ISM_F_EVENT_VQ is negotiated.
> +
> +\begin{lstlisting}
> +struct virtio_ism_event {
> +	le64 num;
> +	le64 offset[];
> +};
> +\end{lstlisting}
> +
> +\begin{description}
> +\item[\field{num}] The number of ism regions with update events.
> +\item[\field{offset}] The offset of ism regions with update events.
> +\end{description}
> +
> +If VIRTIO_ISM_F_EVENT_IRQ is negotiated, when the driver receives an interrupt,
> +it means that the ism region associated with it has been updated.
> +
> +
> +\subsection{Permissions}\label{sec:Device Types / Network Device / Device Operation / Permission}
> +
> +The driver can set independent permissions for a certain ism region. Restrict
> +which devices can execute attach or read and write permissions after attach.
> +
> +By default, the ism region can be attached by any device, and the driver can set
> +it to not allow attachment or only allow the specified device to attach.
> +
> +The driver can set the read and write permissions after it is attached by
> +default, and can also set independent read and write permissions for some
> +devices.
> +
> +When a driver has the management permission of the ism region,
> +then it can modify the permissions of this ism region.
> +By default, only the device that created the ism region has this permission.
> +
> +
> +\subsection{Device Initialization}\label{sec:Device Types / ISM Device / Device Initialization}
> +
> +\devicenormative{\subsubsection}{Device Initialization}{Device Types / ISM Device / Device Initialization}
> +
> +The device MUST regenerate a \field{devid}. \field{devid} remains unchanged

Why does it need to "regenerate" it?

> +during reset. \field{devid} MUST NOT be 0;

s/;/./

> +
> +The device shares memory to the guest based on shared memory regions

Can we avoid the "guest" terminology as well?

> +\ref{sec:Basic Facilities of a Virtio Device / Shared Memory Regions}.
> +However, it does not need to allocate physical memory during initialization.

(...)

You also need to wire up the normative statements in conformance.tex.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

