Return-Path: <virtio-dev-return-10494-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Message-ID: <12badff9-0ce2-29c0-f693-b4aa8d650af8@oracle.com>
Date: Mon, 9 Jan 2023 13:04:18 -0800
References: <20230109163301.463208-1-parav@nvidia.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
In-Reply-To: <20230109163301.463208-1-parav@nvidia.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH v8] virtio-network: Clarify VLAN filter table
 configuration
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Parav Pandit <parav@nvidia.com>, mst@redhat.com, virtio-dev@lists.oasis-open.org
Cc: virtio-comment@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>



On 1/9/2023 8:33 AM, Parav Pandit wrote:
> The filtering behavior of the VLAN filter commands is not very clear as
> discussed in thread [1].
>
> Hence, add the command description and device requirements for it.
>
> [1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg912392.html
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/147
> Suggested-by: Si-Wei Liu <si-wei.liu@oracle.com>
> Signed-off-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>

-Siwei
> ---
> changelog:
> v7->v8:
> - Fixed grammar
> v6->v7:
> - Moved VLAN filter table description from requirements to device
>    descrption section
> - Added MUST and SHOULD to device requirements
> v5->v6:
> - removed unwanted article
> v4->v5:
> - reworded 'vlan filtering table' to 'vlan filter table' to match
>    to the existing description about vlan filtering
> - remove confusing text around VLAN_DEL command description
> - added missing article
> - reword device match configuration to device configuration
> - changed 'found' to 'present' and 'not found' to 'absent' to
>    consider vlan filter table as config table rather
>    than search table
> v3->v4:
> - added description for accepting vlan tagged packets when vlan
>    filter is not negotiated
> v2->v3:
> - corrected grammar
> - simplified description for untagged packets
> v1->v2:
> - adapt to new file path
> v0->v1:
> - added missing conformance section link
> ---
>   .../virtio-network/device-conformance.tex     |  1 +
>   device-types/virtio-network/device.tex        | 22 ++++++++++++++++++-
>   2 files changed, 22 insertions(+), 1 deletion(-)
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
> index e0637c5..7c89f30 100644
> --- a/device-types/virtio-network/device.tex
> +++ b/device-types/virtio-network/device.tex
> @@ -1194,7 +1194,11 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>   \paragraph{VLAN Filtering}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / VLAN Filtering}
>   
>   If the driver negotiates the VIRTIO_NET_F_CTRL_VLAN feature, it
> -can control a VLAN filter table in the device.
> +can control a VLAN filter table in the device. The VLAN filter
> +table applies only to VLAN tagged packets.
> +
> +When VIRTIO_NET_F_CTRL_VLAN is negotiated, the device starts with
> +an empty VLAN filter table.
>   
>   \begin{note}
>   Similar to the MAC address based filtering, the VLAN filtering
> @@ -1210,6 +1214,22 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>   Both the VIRTIO_NET_CTRL_VLAN_ADD and VIRTIO_NET_CTRL_VLAN_DEL
>   command take a little-endian 16-bit VLAN id as the command-specific-data.
>   
> +VIRTIO_NET_CTRL_VLAN_ADD command adds the specified VLAN to the
> +VLAN filter table.
> +
> +VIRTIO_NET_CTRL_VLAN_DEL command removes the specified VLAN from
> +the VLAN filter table.
> +
> +\devicenormative{\subparagraph}{VLAN Filtering}{Device Types / Network Device / Device Operation / Control Virtqueue / VLAN Filtering}
> +
> +When VIRTIO_NET_F_CTRL_VLAN is not negotiated, the device MUST
> +accept all VLAN tagged packets as per the device configuration.
> +
> +When VIRTIO_NET_F_CTRL_VLAN is negotiated, the device MUST
> +accept all VLAN tagged packets whose VLAN tag is present in
> +the VLAN filter table and SHOULD drop all VLAN tagged packets
> +whose VLAN tag is absent in the VLAN filter table.
> +
>   \subparagraph{Legacy Interface: VLAN Filtering}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / VLAN Filtering / Legacy Interface: VLAN Filtering}
>   When using the legacy interface, transitional devices and drivers
>   MUST format the VLAN id


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

