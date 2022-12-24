Return-Path: <virtio-comment-return-3616-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Sat, 24 Dec 2022 16:28:44 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20221224160852-mutt-send-email-mst@kernel.org>
References: <20221224183010.74297-1-parav@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20221224183010.74297-1-parav@nvidia.com>
Subject: [virtio-comment] Re: [PATCH] virtio-network: Avoid confusion between a card and a
 device
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Sat, Dec 24, 2022 at 08:30:10PM +0200, Parav Pandit wrote:
> Ethernet card is a relatively vague term in context of virtio network
> device specification. A Ethernet card in the industry has one to
> multiple ports, one to multiple PCI functions.

Is this the terminology that IEEE uses?

> Historically virtio network device is documented as a Ethernet card.
> However it is usually just a single virtual Ethernet device.
>
> Hence, avoid this confusing term 'card' and align the specification
> to adhere to widely used specification term as 'device' used for all
> virtio device types.
> 
> This patch is on top of change [1].
> 
> [1] https://lists.oasis-open.org/archives/virtio-dev/202212/msg00042.html
> 
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/154
> Signed-off-by: Parav Pandit <parav@nvidia.com>


This results in a bit of confusion since device has very specific
meaning within virtio. I agree "card" sounds archaic.
Would "ethernet adapter" work maybe?

> ---
>  content.tex        | 6 +++---
>  virtio-network.tex | 6 +++---
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/content.tex b/content.tex
> index 5baef90..37e7943 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -619,7 +619,7 @@ \subsection{PCI Device Discovery}\label{sec:Virtio Transport Options / Virtio Ov
>  \hline
>  Transitional PCI Device ID  &  Virtio Device    \\
>  \hline \hline
> -0x1000      &   network card     \\
> +0x1000      &   network device     \\
>  \hline
>  0x1001     &   block device     \\
>  \hline
> @@ -635,7 +635,7 @@ \subsection{PCI Device Discovery}\label{sec:Virtio Transport Options / Virtio Ov
>  \hline
>  \end{tabular}
>  
> -For example, the network card device with the Virtio Device ID 1
> +For example, the network device device with the Virtio Device ID 1


device repeated twice here

>  has the PCI Device ID 0x1041 or the Transitional PCI Device ID 0x1000.
>  
>  The PCI Subsystem Vendor ID and the PCI Subsystem Device ID MAY reflect
> @@ -2912,7 +2912,7 @@ \chapter{Device Types}\label{sec:Device Types}
>  \hline \hline
>  0          & reserved (invalid) \\
>  \hline
> -1          &   network card     \\
> +1          &   network device     \\
>  \hline
>  2          &   block device     \\
>  \hline
> diff --git a/virtio-network.tex b/virtio-network.tex
> index 28ed343..b05ce61 100644
> --- a/virtio-network.tex
> +++ b/virtio-network.tex
> @@ -1,6 +1,6 @@
>  \section{Network Device}\label{sec:Device Types / Network Device}
>  
> -The virtio network device is a virtual ethernet card, and is the
> +The virtio network device is a virtual ethernet device, and is the

"virtio device is an ethernet device" sounds repetetive.


>  most complex of the devices supported so far by virtio. It has
>  enhanced rapidly and demonstrates clearly how support for new
>  features are added to an existing device. Empty buffers are
> @@ -33,7 +33,7 @@ \subsection{Feature bits}\label{sec:Device Types / Network Device / Feature bits
>  
>  \begin{description}
>  \item[VIRTIO_NET_F_CSUM (0)] Device handles packets with partial checksum.   This 
> -  ``checksum offload'' is a common feature on modern network cards.
> +  ``checksum offload'' is a common feature on modern network device.

ungrammatical

>  
>  \item[VIRTIO_NET_F_GUEST_CSUM (1)] Driver handles packets with partial checksum.
>  
> @@ -323,7 +323,7 @@ \subsection{Device Initialization}\label{sec:Device Types / Network Device / Dev
>  
>  \item If the VIRTIO_NET_F_MAC feature bit is set, the configuration
>    space \field{mac} entry indicates the ``physical'' address of the
> -  network card, otherwise the driver would typically generate a random
> +  network device, otherwise the driver would typically generate a random
>    local MAC address.

here it is unclear whether this refers to virtio device or ethernet
device

>  
>  \item If the VIRTIO_NET_F_STATUS feature bit is negotiated, the link
> -- 
> 2.26.2


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

