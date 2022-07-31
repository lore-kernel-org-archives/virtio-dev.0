Return-Path: <mst@redhat.com>
Date: Sun, 31 Jul 2022 17:00:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v6 3/5] Introduce virtio admin virtqueue
Message-ID: <20220731170009-mutt-send-email-mst@kernel.org>
References: <20220731154354.15698-1-mgurtovoy@nvidia.com>
 <20220731154354.15698-4-mgurtovoy@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20220731154354.15698-4-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: jasowang@redhat.com, virtio-comment@lists.oasis-open.org, cohuck@redhat.com, virtio-dev@lists.oasis-open.org, oren@nvidia.com, parav@nvidia.com, shahafs@nvidia.com, aadam@redhat.com, virtio@lists.oasis-open.org, eperezma@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Sun, Jul 31, 2022 at 06:43:52PM +0300, Max Gurtovoy wrote:
> In one of the many use cases a user wants to manipulate features and
> configuration of the virtio devices regardless of the device type
> (net/block/console). For that the admin command set introduced. The
> admin virtqueue will be the first management interface to issue admin
> commands.
> 
> Currently virtio specification defines control virtqueue to manipulate
> features and configuration of the device it operates on. However,
> control virtqueue commands are device type specific, which makes it very
> difficult to extend for device agnostic commands.
> 
> To support this requirement in elegant way, this patch introduces a new
> admin virtqueue interface.
> 
> Manipulate features via admin virtqueue is asynchronous, scalable, easy
> to extend and doesn't require additional and expensive on-die resources
> to be allocated for every new feature that will be added in the future.
> 
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>  admin.tex   | 12 ++++++++++++
>  content.tex |  6 ++++--
>  2 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/admin.tex b/admin.tex
> index d14f8f7..26ac60e 100644
> --- a/admin.tex
> +++ b/admin.tex
> @@ -80,3 +80,15 @@ \section{Administration command set}\label{sec:Basic Facilities of a Virtio Devi
>  8000h - FFFFh   & Reserved    \\
>  \hline
>  \end{tabular}
> +
> +\section{Admin Virtqueues}\label{sec:Basic Facilities of a Virtio Device / Admin Virtqueues}
> +
> +An admin virtqueue is a management interface of a device that can be used to send administrative
> +commands (see \ref{sec:Basic Facilities of a Virtio Device / Administration command set}) to manipulate
> +various features of the device and/or to manipulate various features, if possible, of another device.
> +
> +An admin virtqueue exists for a certain device if VIRTIO_F_ADMIN_VQ feature is
> +negotiated. The index of the admin virtqueue is exposed by the device in a
> +transport specific manner.
> +
> +If VIRTIO_F_ADMIN_VQ has been negotiated, the driver will use the admin virtqueue to send all admin commands.
> diff --git a/content.tex b/content.tex
> index caab298..c15423e 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -99,10 +99,10 @@ \section{Feature Bits}\label{sec:Basic Facilities of a Virtio Device / Feature B
>  \begin{description}
>  \item[0 to 23, and 50 to 127] Feature bits for the specific device type
>  
> -\item[24 to 40] Feature bits reserved for extensions to the queue and
> +\item[24 to 41] Feature bits reserved for extensions to the queue and
>    feature negotiation mechanisms
>  
> -\item[41 to 49, and 128 and above] Feature bits reserved for future extensions.
> +\item[42 to 49, and 128 and above] Feature bits reserved for future extensions.
>  \end{description}
>  
>  \begin{note}
> @@ -6841,6 +6841,8 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
>    that the driver can reset a queue individually.
>    See \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}.
>  
> +  \item[VIRTIO_F_ADMIN_VQ (41)] This feature indicates that an administration virtqueue is supported.

mention here that index is in transport specific manner too?

> +
>  \end{description}
>  
>  \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
> -- 
> 2.21.0

