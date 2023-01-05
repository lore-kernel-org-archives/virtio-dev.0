Return-Path: <virtio-dev-return-10434-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C3B88986634
	for <virtio-dev@lists.oasis-open.org>; Thu,  5 Jan 2023 04:37:24 +0000 (UTC)
MIME-Version: 1.0
References: <20230101181809.325570-1-parav@nvidia.com>
In-Reply-To: <20230101181809.325570-1-parav@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 5 Jan 2023 12:37:10 +0800
Message-ID: <CACGkMEv5K3d_GxKVWNMe+pkoha+M17sUzU0yQA59vqjEnLnJ_A@mail.gmail.com>
Subject: [virtio-dev] Re: [virtio-comment] [PATCH v2] virtio-network: Avoid confusion
 between a card and a device
Content-Type: text/plain; charset="UTF-8"
To: Parav Pandit <parav@nvidia.com>
Cc: mst@redhat.com, virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Jan 2, 2023 at 2:18 AM Parav Pandit <parav@nvidia.com> wrote:
>
> Ethernet card is a relatively vague term in context of virtio network
> device specification. A Ethernet card in the industry has one to
> multiple ports, one to multiple PCI functions.
>
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

Reviewed-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
> changelog:
> v1->v2:
> - adapt to new file path
> v0->v1:
> - removed device word twice
> - corrected grammar for changing from card to device
> ---
>  content.tex                            | 6 +++---
>  device-types/virtio-network/device.tex | 6 +++---
>  2 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/content.tex b/content.tex
> index e2efea4..9b34771 100644
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
> +For example, the network device with the Virtio Device ID 1
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
> diff --git a/device-types/virtio-network/device.tex b/device-types/virtio-network/device.tex
> index 28ed343..e7cdd6f 100644
> --- a/device-types/virtio-network/device.tex
> +++ b/device-types/virtio-network/device.tex
> @@ -1,6 +1,6 @@
>  \section{Network Device}\label{sec:Device Types / Network Device}
>
> -The virtio network device is a virtual ethernet card, and is the
> +The virtio network device is a virtual ethernet device, and is the
>  most complex of the devices supported so far by virtio. It has
>  enhanced rapidly and demonstrates clearly how support for new
>  features are added to an existing device. Empty buffers are
> @@ -33,7 +33,7 @@ \subsection{Feature bits}\label{sec:Device Types / Network Device / Feature bits
>
>  \begin{description}
>  \item[VIRTIO_NET_F_CSUM (0)] Device handles packets with partial checksum.   This
> -  ``checksum offload'' is a common feature on modern network cards.
> +  ``checksum offload'' is a common feature of a modern network device.
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
>
>  \item If the VIRTIO_NET_F_STATUS feature bit is negotiated, the link
> --
> 2.26.2
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
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

