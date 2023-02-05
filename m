Return-Path: <virtio-comment-return-3961-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Sun, 5 Feb 2023 07:18:35 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20230205071657-mutt-send-email-mst@kernel.org>
References: <20230205120801.1419067-1-alvaro.karsz@solid-run.com>
MIME-Version: 1.0
In-Reply-To: <20230205120801.1419067-1-alvaro.karsz@solid-run.com>
Subject: [virtio-comment] Re: [virtio-dev] [PATCH] virtio-net: Mention that
 VIRTIO_NET_F_HASH_REPORT requires VIRTIO_NET_F_CTRL_VQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, jasowang@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Sun, Feb 05, 2023 at 02:08:01PM +0200, Alvaro Karsz wrote:
> If the VIRTIO_NET_F_HASH_REPORT feature is negotiated, the driver may
> send VIRTIO_NET_CTRL_MQ_HASH_CONFIG commands, thus, the control VQ
> feature must be negotiated.
> 
> Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>

Unfortunately we did not make this a dependency in 1.2.

So we can make it a SHOULD but not a MUST.


> ---
>  device-types/net/description.tex | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/device-types/net/description.tex b/device-types/net/description.tex
> index 700a1cb..83cfe94 100644
> --- a/device-types/net/description.tex
> +++ b/device-types/net/description.tex
> @@ -139,6 +139,7 @@ \subsubsection{Feature bit requirements}\label{sec:Device Types / Network Device
>  \item[VIRTIO_NET_F_NOTF_COAL] Requires VIRTIO_NET_F_CTRL_VQ.
>  \item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_F_HOST_TSO4 or VIRTIO_NET_F_HOST_TSO6.
>  \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
> +\item[VIRTIO_NET_F_HASH_REPORT] Requires VIRTIO_NET_F_CTRL_VQ.
>  \end{description}
>  
>  \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types / Network Device / Feature bits / Legacy Interface: Feature bits}
> -- 
> 2.34.1
> 
> 
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org


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

