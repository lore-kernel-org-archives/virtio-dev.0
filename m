Return-Path: virtio-return-3407-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Mon, 25 Nov 2019 11:34:40 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20191125113440.2831608a.cohuck@redhat.com>
In-Reply-To: <20191124121157.259534-1-mst@redhat.com>
References: <20191124121157.259534-1-mst@redhat.com>
MIME-Version: 1.0
Subject: Re: [virtio] [PATCH v3] content: document speed, duplex
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Sun, 24 Nov 2019 07:14:20 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> Document as used by Linux.
> 
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/59
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> 
> changes from v2
> - address comments by Cornelia
> - fix more typos
> - consistent upper/lower case for hex values
> - explicitly ask that devices use 0xffffffff for unknown speed
>   (this is what Linux uses)
> 
> 
>  content.tex | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/content.tex b/content.tex
> index bff80d0..678afbe 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -2892,6 +2892,7 @@ \subsection{Feature bits}\label{sec:Device Types / Network Device / Feature bits
>  
>  \item[VIRTIO_NET_F_STANDBY(62)] Device may act as a standby for a primary
>      device with the same MAC address.
> +\item[VIRTIO_NET_F_SPEED_DUPLEX(63)] Device reports speed and duplex.
>  \end{description}
>  
>  \subsubsection{Feature bit requirements}\label{sec:Device Types / Network Device / Feature bits / Feature bit requirements}
> @@ -2951,12 +2952,27 @@ \subsection{Device configuration layout}\label{sec:Device Types / Network Device
>  VIRTIO_NET_F_MTU is set. This field specifies the maximum MTU for the driver to
>  use.
>  
> +The following two fields, \field{speed} and \field{duplex}, only
> +exist if VIRTIO_NET_F_SPEED_DUPLEX is set.
> +
> +\field{speed} contains the device speed, in units of 1 MByte, 0
> +to 0x7ffffffff, or 0xfffffffff for unknown speed.
> +
> +\field{duplex} has the values of 0x00 for full duplex, 0x01 for
> +half duplex and 0xff for unknown duplex state.
> +
> +Neither \field{speed} not \field{duplex} changes as long as

s/not/nor/

> +VIRTIO_NET_S_LINK_UP is set.
> +
>  \begin{lstlisting}
>  struct virtio_net_config {
>          u8 mac[6];
>          le16 status;
>          le16 max_virtqueue_pairs;
>          le16 mtu;
> +        le32 speed;
> +        u8 duplex;
> +
>  };
>  \end{lstlisting}
>  
> @@ -2985,6 +3001,18 @@ \subsection{Device configuration layout}\label{sec:Device Types / Network Device
>  If the driver negotiates the VIRTIO_NET_F_STANDBY feature, the device MAY act
>  as a standby device for a primary device with the same MAC address.
>  
> +If VIRTIO_NET_F_SPEED_DUPLEX has been negotiated, \field{speed}
> +MUST contain the device speed, in units of 1 MByte, 0 to
> +0x7ffffffff, or 0xfffffffff for unknown.
> +
> +If VIRTIO_NET_F_SPEED_DUPLEX has been negotiated, \field{duplex}
> +MUST have the values of 0x00 for full duplex, 0x01 for half
> +duplex and 0xff for unknown.

s/ and/, or/

> +
> +If VIRTIO_NET_F_SPEED_DUPLEX has been negotiated, the device MUST
> +NOT change the \field{speed} and \field{duplex} fields as long as
> +VIRTIO_NET_S_LINK_UP is set in the \field{status}.
> +
>  \drivernormative{\subsubsection}{Device configuration layout}{Device Types / Network Device / Device configuration layout}
>  
>  A driver SHOULD negotiate VIRTIO_NET_F_MAC if the device offers it.
> @@ -3009,6 +3037,11 @@ \subsection{Device configuration layout}\label{sec:Device Types / Network Device
>  
>  A driver SHOULD negotiate the VIRTIO_NET_F_STANDBY feature if the device offers it.
>  
> +If VIRTIO_NET_F_SPEED_DUPLEX has been negotiated,
> +the driver MUST treat any value of \field{speed} above
> +0x7fffffff as well as any value of \field{duplex} not
> +matching 0x00 or 0x01 as an unknown value.
> +
>  \subsubsection{Legacy Interface: Device configuration layout}\label{sec:Device Types / Network Device / Device configuration layout / Legacy Interface: Device configuration layout}
>  \label{sec:Device Types / Block Device / Feature bits / Device configuration layout / Legacy Interface: Device configuration layout}
>  When using the legacy interface, transitional devices and drivers

Other than the nits above

Reviewed-by: Cornelia Huck <cohuck@redhat.com>


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

