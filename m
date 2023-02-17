Return-Path: <mst@redhat.com>
Date: Fri, 17 Feb 2023 04:29:26 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2] virtio-net: Define configuration field layout before
 its description
Message-ID: <20230217041616-mutt-send-email-mst@kernel.org>
References: <20230209045228.212309-1-parav@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230209045228.212309-1-parav@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: virtio-dev@lists.oasis-open.org, cohuck@redhat.com, virtio-comment@lists.oasis-open.org, shahafs@nvidia.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Feb 09, 2023 at 06:52:28AM +0200, Parav Pandit wrote:
> Currently some fields of the virtio_net_config structure are defined
> before introducing the structure and some are defined after
> introducing virtio_net_config.
> Better to define the configuration layout first followed by
> description of all the fields.
> 
> Device configuration fields are described in the section. Change wording
> from 'listed' to 'described' as suggested in patch [1].
> 
> While rewording the configuration layout, mention only one time that all
> the fields of the configuration layout are read-only. Remove read-only
> wording from individual fields.
> 
> [1] https://lists.oasis-open.org/archives/virtio-dev/202302/msg00004.html
> 
> Signed-off-by: Parav Pandit <parav@nvidia.com>


> ---
> changelog:
> v1->v2:
> - remove read-only wording from multiple places

I think it's ok that this combines text movement
and rewording. Splitting up would have made very small patches.
In fact something I think applies to other contributions too.
But please do reflect it in the subject.
Something like "config field layout reorg" would better describe
what is going on.

Also pls try to keep subject line length below 50 characters.
Abbreviation is ok there.

Thanks!

> v0->v1:
> - Change wording about device configuration field introduction
> - remove duplicate read-only wording for status field
> - reword sentence to read it better
> ---
>  device-types/net/description.tex | 48 +++++++++++++++++---------------
>  1 file changed, 26 insertions(+), 22 deletions(-)
> 
> diff --git a/device-types/net/description.tex b/device-types/net/description.tex
> index bdf4810..719ebd4 100644
> --- a/device-types/net/description.tex
> +++ b/device-types/net/description.tex
> @@ -156,26 +156,43 @@ \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types / Network
>  \subsection{Device configuration layout}\label{sec:Device Types / Network Device / Device configuration layout}
>  \label{sec:Device Types / Block Device / Feature bits / Device configuration layout}
>  
> -Device configuration fields are listed below, they are read-only for a driver. The \field{mac} address field
> -always exists (though is only valid if VIRTIO_NET_F_MAC is set), and
> -\field{status} only exists if VIRTIO_NET_F_STATUS is set. Two
> -read-only bits (for the driver) are currently defined for the status field:
> -VIRTIO_NET_S_LINK_UP and VIRTIO_NET_S_ANNOUNCE.
> +The network device has the following device configuration layout.
> +These device configuration fields are read-only for the driver.

First time we are mentioning fields, which "These"?
Really this sentence is part of field description so
I feel it should come after the structure.
And I feel read-only part needs more stress.
Maybe "All device configuration fields are read-only for the driver"?
Maybe add a driver conformance statement too?


> +
> +\begin{lstlisting}
> +struct virtio_net_config {
> +        u8 mac[6];
> +        le16 status;
> +        le16 max_virtqueue_pairs;
> +        le16 mtu;
> +        le32 speed;
> +        u8 duplex;
> +        u8 rss_max_key_size;
> +        le16 rss_max_indirection_table_length;
> +        le32 supported_hash_types;
> +};
> +\end{lstlisting}
> +
> +The \field{mac} address field always exists (although it is only
> +valid if VIRTIO_NET_F_MAC is set).
> +
> +The \field{status} only exists if VIRTIO_NET_F_STATUS is set.
> +Two bits are currently defined for the status field: VIRTIO_NET_S_LINK_UP
> +and VIRTIO_NET_S_ANNOUNCE.
>  
>  \begin{lstlisting}
>  #define VIRTIO_NET_S_LINK_UP     1
>  #define VIRTIO_NET_S_ANNOUNCE    2
>  \end{lstlisting}
>  
> -The following driver-read-only field, \field{max_virtqueue_pairs} only exists if
> +The following field, \field{max_virtqueue_pairs} only exists if
>  VIRTIO_NET_F_MQ or VIRTIO_NET_F_RSS is set. This field specifies the maximum number
>  of each of transmit and receive virtqueues (receiveq1\ldots receiveqN
>  and transmitq1\ldots transmitqN respectively) that can be configured once at least one of these features
>  is negotiated.
>  
> -The following driver-read-only field, \field{mtu} only exists if
> -VIRTIO_NET_F_MTU is set. This field specifies the maximum MTU for the driver to
> -use.
> +The following field, \field{mtu} only exists if VIRTIO_NET_F_MTU is set.
> +This field specifies the maximum MTU for the driver to use.
>  
>  The following two fields, \field{speed} and \field{duplex}, only
>  exist if VIRTIO_NET_F_SPEED_DUPLEX is set.
> @@ -190,19 +207,6 @@ \subsection{Device configuration layout}\label{sec:Device Types / Network Device
>  is expected to re-read these values after receiving a
>  configuration change notification.
>  
> -\begin{lstlisting}
> -struct virtio_net_config {
> -        u8 mac[6];
> -        le16 status;
> -        le16 max_virtqueue_pairs;
> -        le16 mtu;
> -        le32 speed;
> -        u8 duplex;
> -        u8 rss_max_key_size;
> -        le16 rss_max_indirection_table_length;
> -        le32 supported_hash_types;
> -};
> -\end{lstlisting}
>  The following field, \field{rss_max_key_size} only exists if VIRTIO_NET_F_RSS or VIRTIO_NET_F_HASH_REPORT is set.
>  It specifies the maximum supported length of RSS key in bytes.
>  
> -- 
> 2.26.2

