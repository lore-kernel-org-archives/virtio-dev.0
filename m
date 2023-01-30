Return-Path: <mst@redhat.com>
Date: Mon, 30 Jan 2023 06:27:50 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio-net: Avoid confusing device configuration text
Message-ID: <20230130062731-mutt-send-email-mst@kernel.org>
References: <20230126003139.1185666-1-parav@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230126003139.1185666-1-parav@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: virtio-dev@lists.oasis-open.org, cohuck@redhat.com, virtio-comment@lists.oasis-open.org, shahafs@nvidia.com, Halil Pasic <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Jan 26, 2023 at 02:31:39AM +0200, Parav Pandit wrote:
> The added text in commit of Fixes tag was redundant and
> confusing in context of VLAN filtering description.
> 
> Hence remove it as discussed in [1] and [2].
> 
> [1] https://lists.oasis-open.org/archives/virtio-dev/202301/msg00282.html
> [2] https://lists.oasis-open.org/archives/virtio-dev/202301/msg00286.html
> 
> Fixes: 296303444f6b ("virtio-net: Clarify VLAN filter table configuration")
> Suggested-by: Halil Pasic <pasic@linux.ibm.com>
> Signed-off-by: Parav Pandit <parav@nvidia.com>


Acked-by: Michael S. Tsirkin <mst@redhat.com>

I agree it's an editorial change.

> ---
> This change is on top of [3].
> 
> [3] https://lists.oasis-open.org/archives/virtio-dev/202301/msg00231.html
> ---
>  device-types/net/description.tex | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/device-types/net/description.tex b/device-types/net/description.tex
> index e32780b..bd81731 100644
> --- a/device-types/net/description.tex
> +++ b/device-types/net/description.tex
> @@ -1223,7 +1223,7 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>  \devicenormative{\subparagraph}{VLAN Filtering}{Device Types / Network Device / Device Operation / Control Virtqueue / VLAN Filtering}
>  
>  When VIRTIO_NET_F_CTRL_VLAN is not negotiated, the device MUST
> -accept all VLAN tagged packets as per the device configuration.
> +accept all VLAN tagged packets.
>  
>  When VIRTIO_NET_F_CTRL_VLAN is negotiated, the device MUST
>  accept all VLAN tagged packets whose VLAN tag is present in
> -- 
> 2.26.2

