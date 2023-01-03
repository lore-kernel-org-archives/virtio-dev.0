Return-Path: <virtio-comment-return-3654-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Tue, 3 Jan 2023 05:55:53 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20230103054736-mutt-send-email-mst@kernel.org>
References: <20221225003727.103495-1-parav@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20221225003727.103495-1-parav@nvidia.com>
Subject: [virtio-comment] Re: [PATCH v1] virtio-network: Clarify VLAN filter table
 configuration
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org, si-wei.liu@oracle.com
List-ID: <virtio-dev.lists.oasis-open.org>


On Sun, Dec 25, 2022 at 02:37:27AM +0200, Parav Pandit wrote:
> The filtering behavior of the VLAN filter commands is not very clear as
> discussed in thread [1].
> 
> Hence, add the command description and device requirements for it.
> 
> [1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg912392.html
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/147
> Suggested-by: Si-Wei Liu <si-wei.liu@oracle.com>
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> ---
> changelog:
> v0->v1:
> - added missing conformance section link
> ---
>  conformance.tex    |  1 +
>  virtio-network.tex | 23 +++++++++++++++++++++++
>  2 files changed, 24 insertions(+)
> 
> diff --git a/conformance.tex b/conformance.tex
> index c3c1d3e..478fb80 100644
> --- a/conformance.tex
> +++ b/conformance.tex
> @@ -412,6 +412,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
>  \item \ref{devicenormative:Device Types / Network Device / Device Operation / Processing of Incoming Packets}
>  \item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / Packet Receive Filtering}
>  \item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / Setting MAC Address Filtering}
> +\item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / VLAN Filtering}
>  \item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / Gratuitous Packet Sending}
>  \item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / Automatic receive steering in multiqueue mode}
>  \item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / Receive-side scaling (RSS) / RSS processing}
> diff --git a/virtio-network.tex b/virtio-network.tex
> index e7cdd6f..1b8fde9 100644
> --- a/virtio-network.tex
> +++ b/virtio-network.tex
> @@ -1210,6 +1210,29 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>  Both the VIRTIO_NET_CTRL_VLAN_ADD and VIRTIO_NET_CTRL_VLAN_DEL
>  command take a little-endian 16-bit VLAN id as the command-specific-data.
>  
> +VIRTIO_NET_CTRL_VLAN_ADD command adds the specified VLAN to the VLAN
> +filtering table.
> +
> +VIRTIO_NET_CTRL_VLAN_DEL command removes specified VLAN from the VLAN
> +filtering table which was previously added using
> +VIRTIO_NET_CTRL_VLAN_ADD command.
> +
> +\devicenormative{\subparagraph}{VLAN Filtering}{Device Types / Network Device / Device Operation / Control Virtqueue / VLAN Filtering}
> +
> +When VIRTIO_NET_F_CTRL_VLAN is not negotiated, the device accepts all
> +VLAN tagged packets which matches  device's filter configuration.

which match the device's

> +
> +When VIRTIO_NET_F_CTRL_VLAN is negotiated, the device starts with empty

an empty

> +VLAN filtering table.
> +
> +When VIRTIO_NET_F_CTRL_VLAN is negotiated, the device accepts all the

all the -> all

> +VLAN tagged packets whose VLAN tag is found in the VLAN filtering table;
> +device should drop all VLAN tagged packets whose VLAN tag is not found

the device

> +in the VLAN filtering table.
> +
> +When VIRTIO_NET_F_CTRL_VLAN is negotiated, the device accepts all
> +untagged packets which matches device's


which match the device's ...

> filter configuration.

This confusing, took me several reads to understand.
E.g. with promisc we accept all packets, it is not
necessary about a match.
I suggest "
Filtering of untagged packets is not affected by
whether VIRTIO_NET_F_CTRL_VLAN is or is not negotiated.
"

> +
>  \subparagraph{Legacy Interface: VLAN Filtering}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / VLAN Filtering / Legacy Interface: VLAN Filtering}
>  When using the legacy interface, transitional devices and drivers
>  MUST format the VLAN id
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

