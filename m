Return-Path: <virtio-dev-return-10676-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D02919866DD
	for <virtio-dev@lists.oasis-open.org>; Mon, 30 Jan 2023 11:27:01 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20230126003139.1185666-1-parav@nvidia.com>
References: <20230126003139.1185666-1-parav@nvidia.com>
Date: Mon, 30 Jan 2023 12:26:55 +0100
Message-ID: <87r0vcw9ds.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH] virtio-net: Avoid confusing device configuration text
Content-Type: text/plain
To: Parav Pandit <parav@nvidia.com>, mst@redhat.com, virtio-dev@lists.oasis-open.org
Cc: virtio-comment@lists.oasis-open.org, shahafs@nvidia.com, Parav Pandit <parav@nvidia.com>, Halil Pasic <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Jan 26 2023, Parav Pandit <parav@nvidia.com> wrote:

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

I think I can apply this on top of [3] as an editorial change when
applying that, but can I please get some kind of ack/r-b on this change?


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

