Return-Path: virtio-dev-return-4336-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id DDB5358191C8
	for <virtio-dev@lists.oasis-open.org>; Mon, 11 Jun 2018 06:44:45 -0700 (PDT)
Date: Mon, 11 Jun 2018 16:44:34 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180611164417-mutt-send-email-mst@kernel.org>
References: <20180611075640.19751-1-tiwei.bie@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180611075640.19751-1-tiwei.bie@intel.com>
Subject: [virtio-dev] Re: [PATCH v3] content: enhance device requirements for feature bits
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: cohuck@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, virtio-dev@lists.oasis-open.org, dan.daly@intel.com, cunming.liang@intel.com, zhihong.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Jun 11, 2018 at 03:56:40PM +0800, Tiwei Bie wrote:
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/14

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> v2:
> - Refine the wording (Cornelia);
> 
> v3:
> - Refine the wording (MST);
> 
>  content.tex | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/content.tex b/content.tex
> index f996fad..3c7d67d 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -125,6 +125,13 @@ which was not offered.  The device SHOULD accept any valid subset
>  of features the driver accepts, otherwise it MUST fail to set the
>  FEATURES_OK \field{device status} bit when the driver writes it.
>  
> +If a device has successfully negotiated a set of features
> +at least once (by accepting the FEATURES_OK \field{device
> +status} bit during device initialization), then it SHOULD
> +NOT fail re-negotiation of the same set of features after
> +a device or system reset.  Failure to do so would interfere
> +with resuming from suspend and error recovery.
> +
>  \subsection{Legacy Interface: A Note on Feature
>  Bits}\label{sec:Basic Facilities of a Virtio Device / Feature
>  Bits / Legacy Interface: A Note on Feature Bits}
> -- 
> 2.17.0

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

