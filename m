Return-Path: <virtio-dev-return-10421-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Message-ID: <111b68d2-5478-4bb5-4e23-c2950d09edf3@oracle.com>
Date: Tue, 3 Jan 2023 17:48:51 -0800
References: <20230103220709.357541-1-parav@nvidia.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
In-Reply-To: <20230103220709.357541-1-parav@nvidia.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH v3] virtio-network: Clarify VLAN filter table
 configuration
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Parav Pandit <parav@nvidia.com>, mst@redhat.com, virtio-dev@lists.oasis-open.org
Cc: virtio-comment@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Parav,

Great write-up! Just a couple minor suggestions, please see below in line.

On 1/3/2023 2:07 PM, Parav Pandit wrote:
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
> v2->v3:
> - corrected grammar
> - simplified description for untagged packets
> v1->v2:
> - adapt to new file path
> v0->v1:
> - added missing conformance section link
> ---
>   .../virtio-network/device-conformance.tex      |  1 +
>   device-types/virtio-network/device.tex         | 18 ++++++++++++++++++
>   2 files changed, 19 insertions(+)
>
> diff --git a/device-types/virtio-network/device-conformance.tex b/device-types/virtio-network/device-conformance.tex
> index c686377..54f6783 100644
> --- a/device-types/virtio-network/device-conformance.tex
> +++ b/device-types/virtio-network/device-conformance.tex
> @@ -9,6 +9,7 @@
>   \item \ref{devicenormative:Device Types / Network Device / Device Operation / Processing of Incoming Packets}
>   \item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / Packet Receive Filtering}
>   \item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / Setting MAC Address Filtering}
> +\item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / VLAN Filtering}
>   \item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / Gratuitous Packet Sending}
>   \item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / Automatic receive steering in multiqueue mode}
>   \item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / Receive-side scaling (RSS) / RSS processing}
> diff --git a/device-types/virtio-network/device.tex b/device-types/virtio-network/device.tex
> index e7cdd6f..ea4b524 100644
> --- a/device-types/virtio-network/device.tex
> +++ b/device-types/virtio-network/device.tex
> @@ -1210,6 +1210,24 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>   Both the VIRTIO_NET_CTRL_VLAN_ADD and VIRTIO_NET_CTRL_VLAN_DEL
>   command take a little-endian 16-bit VLAN id as the command-specific-data.
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
> +When VIRTIO_NET_F_CTRL_VLAN is negotiated, the device starts with
> +an empty VLAN filtering table.
Should we mention this VLAN filtering table gets emptied on device reset?

> +
> +When VIRTIO_NET_F_CTRL_VLAN is negotiated, the device accepts all
> +VLAN tagged packets whose VLAN tag is found in the VLAN filtering
> +table; the device should drop all VLAN tagged packets whose VLAN tag
> +is not found in the VLAN filtering table. The VLAN filtering table
> +applies only to the VLAN tagged packets.
I know what you want to convey with simplified wording. Since VLAN 
filter table works differently with MAC address table 
(VIRTIO_NET_F_CTRL_MAC_ADDR), should we explicitly state that the 
assumed action without VLAN filter table is to pass VLAN tagged packet 
when the specific feature is not negotiated? Like:

...; if VIRTIO_NET_F_CTRL_VLAN is not negotiated, device does not have a 
VLAN filter table thus MUST NOT specifically drop VLAN tagged packets.


Regards,
-Siwei

> +
>   \subparagraph{Legacy Interface: VLAN Filtering}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / VLAN Filtering / Legacy Interface: VLAN Filtering}
>   When using the legacy interface, transitional devices and drivers
>   MUST format the VLAN id


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

