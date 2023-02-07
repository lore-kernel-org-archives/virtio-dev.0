Return-Path: <virtio-comment-return-3984-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20230203144349.34471-1-parav@nvidia.com>
References: <20230203144349.34471-1-parav@nvidia.com>
Date: Tue, 07 Feb 2023 14:49:08 +0100
Message-ID: <87a61ptwkr.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-comment] Re: [PATCH] virtio-net: Define configuration field layout before
 its description
Content-Type: text/plain
To: Parav Pandit <parav@nvidia.com>, mst@redhat.com, virtio-dev@lists.oasis-open.org
Cc: virtio-comment@lists.oasis-open.org, shahafs@nvidia.com, Parav Pandit <parav@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Feb 03 2023, Parav Pandit <parav@nvidia.com> wrote:

> Currently some fields of the virtio_net_config structure are defined
> before introducing the structure and some are defined after
> introducing virtio_net_config.
> Better to define the configuration layout first followed by
> description of all the fields.

I see that some other devices (e.g. block) list the config layout
_after_ all of the descriptions, although I think listing first and then
describing is the better approach. However, in-between is the worst
order, and just cleaning up this one right now makes sense.

>
> Device configuration fields are described in the section. Change wording
> from 'listed' to 'described' as suggested in patch [1].
>
> [1] https://lists.oasis-open.org/archives/virtio-dev/202302/msg00004.html
>
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> ---
>  device-types/net/description.tex | 39 +++++++++++++++++---------------
>  1 file changed, 21 insertions(+), 18 deletions(-)
>
> diff --git a/device-types/net/description.tex b/device-types/net/description.tex
> index dedd6b1..d4f598b 100644
> --- a/device-types/net/description.tex
> +++ b/device-types/net/description.tex
> @@ -154,11 +154,27 @@ \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types / Network
>  \subsection{Device configuration layout}\label{sec:Device Types / Network Device / Device configuration layout}
>  \label{sec:Device Types / Block Device / Feature bits / Device configuration layout}
>  
> -Device configuration fields are listed below, they are read-only for a driver. The \field{mac} address field
> -always exists (though is only valid if VIRTIO_NET_F_MAC is set), and
> -\field{status} only exists if VIRTIO_NET_F_STATUS is set. Two
> -read-only bits (for the driver) are currently defined for the status field:
> -VIRTIO_NET_S_LINK_UP and VIRTIO_NET_S_ANNOUNCE.
> +Device configuration fields are described below, they are read-only for a driver.

Maybe replace that with:

"The network device uses the following device configuration layout. The
fields are read-only for the driver."

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
> +The \field{mac} address field always exists (though is only valid
> +if VIRTIO_NET_F_MAC is set), and \field{status} only exists if
> +VIRTIO_NET_F_STATUS is set. Two read-only bits (for the driver)
> +are currently defined for the status field: VIRTIO_NET_S_LINK_UP
> +and VIRTIO_NET_S_ANNOUNCE.

As you are touching this anyway, maybe break it up?

"The \field{mac} address field always exists (although it is only valid
if VIRTIO_NET_F_MAC is set).

\field{status} only exists if VIRTIO_NET_F_STATUS is set. Two read-only
bits (for the driver) are currently defined for the status field:
VIRTIO_NET_S_LINK_UP and VIRTIO_NET_S_ANNOUNCE."

>  
>  \begin{lstlisting}
>  #define VIRTIO_NET_S_LINK_UP     1
> @@ -188,19 +204,6 @@ \subsection{Device configuration layout}\label{sec:Device Types / Network Device
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

