Return-Path: virtio-dev-return-5867-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 58E34985EE3
	for <virtio-dev@lists.oasis-open.org>; Fri, 19 Jul 2019 10:01:06 +0000 (UTC)
Date: Fri, 19 Jul 2019 12:00:57 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190719120057.6e3ebc0b.cohuck@redhat.com>
In-Reply-To: <20190719041151.31320-1-tiwei.bie@intel.com>
References: <20190719041151.31320-1-tiwei.bie@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH] content: explicitly document the VLAN filtering as
 best-effort
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: virtio-dev@lists.oasis-open.org, mst@redhat.com, stefanha@redhat.com, jasowang@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, 19 Jul 2019 12:11:51 +0800
Tiwei Bie <tiwei.bie@intel.com> wrote:

> Similar to the MAC address based filtering, the VLAN filtering
> is also best-effort in implementations, but it's not quite clear
> in the spec. So document this behaviour explicitly to reflect
> the way implementations behave.
> 
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/47
> Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> v1:
> - Add "Fixes:" tag;
> 
> RFC link:
> https://lists.oasis-open.org/archives/virtio-dev/201907/msg00035.html
> 
>  content.tex | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/content.tex b/content.tex
> index 8f0498e..783322b 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -3530,6 +3530,11 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>  If the driver negotiates the VIRTION_NET_F_CTRL_VLAN feature, it
>  can control a VLAN filter table in the device.
>  
> +\begin{note}
> +Similar to the MAC address based filtering, the VLAN filtering
> +is also best-effort: unwanted packets could still arrive.
> +\end{note}
> +
>  \begin{lstlisting}
>  #define VIRTIO_NET_CTRL_VLAN       2
>   #define VIRTIO_NET_CTRL_VLAN_ADD             0

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

