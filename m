Return-Path: <virtio-dev-return-9285-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7DDC39863C4
	for <virtio-dev@lists.oasis-open.org>; Wed,  9 Feb 2022 06:17:02 +0000 (UTC)
Date: Wed, 9 Feb 2022 11:46:58 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
Message-ID: <20220209061658.qnhhfrfgcw3dpuhr@vireshk-i7>
References: <20220125122332.64473-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220125122332.64473-1-mst@redhat.com>
Subject: [virtio-dev] Re: [PATCH] virtio-gpio: offered -> negotiated
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, virtio@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 25-01-22, 07:24, Michael S. Tsirkin wrote:
> virtqueues are only discovered after FEATURES_OK.
> As such it makes no sense to talk about virtqueues being affected by
> features which are offered but not negotiated, and doing so will confuse
> the reader.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> 
> Viresh, others your thoughts on this? Looks like an obvious typo
> to me, and something that I think we can fix under the editorial
> changes rule.
> 
>  virtio-gpio.tex | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/virtio-gpio.tex b/virtio-gpio.tex
> index 55c553f..8e5c7f0 100644
> --- a/virtio-gpio.tex
> +++ b/virtio-gpio.tex
> @@ -15,7 +15,7 @@ \subsection{Virtqueues}\label{sec:Device Types / GPIO Device / Virtqueues}
>  \end{description}
>  
>  The \field{eventq} virtqueue is available only if the \field{VIRTIO_GPIO_F_IRQ}
> -feature is offered by the device.
> +feature has been negotiated.
>  
>  \subsection{Feature bits}\label{sec:Device Types / GPIO Device / Feature bits}

Sorry for the delay, was out of office.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

