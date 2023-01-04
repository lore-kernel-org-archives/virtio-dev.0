Return-Path: <virtio-comment-return-3673-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Wed, 4 Jan 2023 01:41:17 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20230104013612-mutt-send-email-mst@kernel.org>
References: <20230104040205.360753-1-parav@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230104040205.360753-1-parav@nvidia.com>
Subject: [virtio-comment] Re: [PATCH v4] virtio-network: Clarify VLAN filter table
 configuration
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org, si-wei.liu@oracle.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jan 04, 2023 at 06:02:05AM +0200, Parav Pandit wrote:
> The filtering behavior of the VLAN filter commands is not very clear as
> discussed in thread [1].
> 
> Hence, add the command description and device requirements for it.
> 
> [1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg912392.html
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/147
> Suggested-by: Si-Wei Liu <si-wei.liu@oracle.com>
> Signed-off-by: Parav Pandit <parav@nvidia.com>

Looks like we are going back to issues that we had in v1.
what happened here?

> ---
> changelog:
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
>  .../virtio-network/device-conformance.tex     |  1 +
>  device-types/virtio-network/device.tex        | 22 +++++++++++++++++++
>  2 files changed, 23 insertions(+)
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
> index e7cdd6f..0e6d872 100644
> --- a/device-types/virtio-network/device.tex
> +++ b/device-types/virtio-network/device.tex
> @@ -1210,6 +1210,28 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>  Both the VIRTIO_NET_CTRL_VLAN_ADD and VIRTIO_NET_CTRL_VLAN_DEL
>  command take a little-endian 16-bit VLAN id as the command-specific-data.
>  
> +VIRTIO_NET_CTRL_VLAN_ADD command adds the specified VLAN to the VLAN
> +filtering table.
> +
> +VIRTIO_NET_CTRL_VLAN_DEL command removes specified VLAN from the VLAN

the specified

> +filtering table which was previously added using
> +VIRTIO_NET_CTRL_VLAN_ADD command.

bad ordering so it's unclear what was added. it's vlan not the
table. So:
	removes the specified VLAN - which was previously added using
	VIRTIO_NET_CTRL_VLAN_ADD command - from the VLAN filtering table.

> +
> +\devicenormative{\subparagraph}{VLAN Filtering}{Device Types / Network Device / Device Operation / Control Virtqueue / VLAN Filtering}
> +
> +When VIRTIO_NET_F_CTRL_VLAN is not negotiated, the device accepts
> +all VLAN tagged packets that matches the device's filter
> +configuration.

bad grammar here and it's not a match.


> +
> +When VIRTIO_NET_F_CTRL_VLAN is negotiated, the device starts with
> +an empty VLAN filtering table.
> +
> +When VIRTIO_NET_F_CTRL_VLAN is negotiated, the device accepts all
> +VLAN tagged packets whose VLAN tag is found in the VLAN filtering
> +table; the device should drop all VLAN tagged packets whose VLAN tag
> +is not found in the VLAN filtering table. The VLAN filtering table
> +applies only to the VLAN tagged packets.
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

