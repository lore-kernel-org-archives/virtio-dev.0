Return-Path: <virtio-comment-return-3701-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Sun, 8 Jan 2023 10:38:36 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20230108103653-mutt-send-email-mst@kernel.org>
References: <20230108144659.438750-1-parav@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230108144659.438750-1-parav@nvidia.com>
Subject: [virtio-comment] Re: [PATCH v6] virtio-network: Clarify VLAN filter table
 configuration
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org, si-wei.liu@oracle.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Sun, Jan 08, 2023 at 04:46:59PM +0200, Parav Pandit wrote:
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
> v5->v6:
> - removed unwanted article
> v4->v5:
> - reworded 'vlan filtering table' to 'vlan filter table' to match
>   to the existing description about vlan filtering
> - remove confusing text around VLAN_DEL command description
> - added missing article
> - reword device match configuration to device configuration
> - changed 'found' to 'present' and 'not found' to 'absent' to
>   consider vlan filter table as config table rather
>   than search table
> v3->v4:
> - added description for accepting vlan tagged packets when vlan
>   filter is not negotiated
> v2->v3:
> - corrected grammar
> - simplified description for untagged packets
> v1->v2:
> - adapt to new file path
> v0->v1:
> - added missing conformance section link
> ---

Almost there. A minor nit:

>  .../virtio-network/device-conformance.tex     |  1 +
>  device-types/virtio-network/device.tex        | 20 +++++++++++++++++++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/device-types/virtio-network/device-conformance.tex b/device-types/virtio-network/device-conformance.tex
> index c686377..54f6783 100644
> --- a/device-types/virtio-network/device-conformance.tex
> +++ b/device-types/virtio-network/device-conformance.tex
> @@ -9,6 +9,7 @@
>  \item \ref{devicenormative:Device Types / Network Device / Device Operation / Processing of Incoming Packets}
>  \item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / Packet Receive Filtering}
>  \item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / Setting MAC Address Filtering}
> +\item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / VLAN Filtering}
>  \item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / Gratuitous Packet Sending}
>  \item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / Automatic receive steering in multiqueue mode}
>  \item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / Receive-side scaling (RSS) / RSS processing}
> diff --git a/device-types/virtio-network/device.tex b/device-types/virtio-network/device.tex
> index e7cdd6f..8a7c6ac 100644
> --- a/device-types/virtio-network/device.tex
> +++ b/device-types/virtio-network/device.tex
> @@ -1210,6 +1210,26 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>  Both the VIRTIO_NET_CTRL_VLAN_ADD and VIRTIO_NET_CTRL_VLAN_DEL
>  command take a little-endian 16-bit VLAN id as the command-specific-data.
>  
> +VIRTIO_NET_CTRL_VLAN_ADD command adds the specified VLAN to the
> +VLAN filter table.
> +
> +VIRTIO_NET_CTRL_VLAN_DEL command removes the specified VLAN from
> +the VLAN filter table.
> +
> +\devicenormative{\subparagraph}{VLAN Filtering}{Device Types / Network Device / Device Operation / Control Virtqueue / VLAN Filtering}
> +
> +When VIRTIO_NET_F_CTRL_VLAN is not negotiated, the device accepts
> +all VLAN tagged packets as per the device configuration.
> +
> +When VIRTIO_NET_F_CTRL_VLAN is negotiated, the device starts with
> +an empty VLAN filter table.
> +
> +When VIRTIO_NET_F_CTRL_VLAN is negotiated, the device accepts all
> +VLAN tagged packets whose VLAN tag is present in the VLAN
> +filter table; the device should drop all VLAN tagged packets
> +whose VLAN tag is absent in the VLAN filter table. The
> +VLAN filter table applies only to VLAN tagged packets.
> +

We need to make them normative statements. As written they are not.
Either MUST or SHOULD in this case. I am guessing MUST since this
was always the intent we just never spelled it out?

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

