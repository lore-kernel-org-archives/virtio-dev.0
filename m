Return-Path: <virtio-return-3874-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20221121012419.317406-8-mst@redhat.com>
References: <20221121012419.317406-1-mst@redhat.com>
 <20221121012419.317406-8-mst@redhat.com>
Date: Mon, 21 Nov 2022 16:53:22 +0100
Message-ID: <87r0xw5mod.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio] Re: [PATCH v8 7/9] ccw: document ADMIN_VQ as reserved
Content-Type: text/plain
To: "Michael S. Tsirkin" <mst@redhat.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, mst@redhat.com, sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com
Cc: virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Sun, Nov 20 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> Adding relevant registers needs more work and it's not
> clear what the use-case will be as currently only
> the PCI transport is supported. But let's keep the
> door open on this.
> We already say it's reserved in a central place, but it
> does not hurt to remind implementers to mask it.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  content.tex | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/content.tex b/content.tex
> index 9c74fa9..7111929 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -2971,6 +2971,18 @@ \subsubsection{Resetting Devices}\label{sec:Virtio Transport Options / Virtio ov
>  MAY also choose to verify reset completion by reading \field{device status} via
>  CCW_CMD_READ_STATUS and checking whether it is 0 afterwards.
>  
> +\subsection{Features reserved for future use}\label{sec:Virtio Transport Options / Virtio Over MMIO / Features reserved for future use}

s/MMIO/Channel I/O/

> +
> +At this time, devices and drivers utilizing Virtio over channel I/O
> +do not support the following features:
> +\begin{itemize}
> +
> +\item VIRTIO_F_ADMIN_VQ

There are already a few features not yet supported for ccw (queue reset,
shared memory, ...) -- would it make sense to add a separate patch
listing all of the features not yet supported prior to adding all of the
admin vq infrastructure? Otherwise, this section is a bit misleading.

(What is the situation for MMIO?)

> +
> +\end{itemize}
> +
> +These features are reserved for future use.
> +
>  \chapter{Device Types}\label{sec:Device Types}
>  
>  On top of the queues, config space and feature negotiation facilities


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

