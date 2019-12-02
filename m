Return-Path: virtio-dev-return-6441-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 64374985C13
	for <virtio-dev@lists.oasis-open.org>; Mon,  2 Dec 2019 17:00:25 +0000 (UTC)
Date: Mon, 2 Dec 2019 12:00:17 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20191202115913-mutt-send-email-mst@kernel.org>
References: <20191128114243.23511-1-kraxel@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191128114243.23511-1-kraxel@redhat.com>
Subject: Re: [virtio-dev] [PATCH] virtio-gpu: some edid clarifications
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Nov 28, 2019 at 12:42:43PM +0100, Gerd Hoffmann wrote:
> Add some notes about fetching the EDID information.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

As a minor nit, it is preferable to send spec patches on virtio-comment.

virtio-dev is for code patches (implementation development).


> ---
>  virtio-gpu.tex | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>=20
> diff --git a/virtio-gpu.tex b/virtio-gpu.tex
> index af4ca610d235..15dbf9f2ec82 100644
> --- a/virtio-gpu.tex
> +++ b/virtio-gpu.tex
> @@ -70,16 +70,21 @@ \subsubsection{Events}
>  \begin{description}
>  \item[VIRTIO_GPU_EVENT_DISPLAY] Display configuration has changed.
>    The driver SHOULD use the VIRTIO_GPU_CMD_GET_DISPLAY_INFO command to
> -  fetch the information from the device.
> +  fetch the information from the device.  In case EDID support is
> +  negotiated (VIRTIO_GPU_F_EDID feature flag) the device SHOULD also
> +  fetch the updated EDID blobs using the VIRTIO_GPU_CMD_GET_EDID
> +  command.
>  \end{description}
> =20
>  \devicenormative{\subsection}{Device Initialization}{Device Types / GPU =
Device / Device Initialization}
> =20
>  The driver SHOULD query the display information from the device using
>  the VIRTIO_GPU_CMD_GET_DISPLAY_INFO command and use that information
> -for the initial scanout setup.  In case no information is available or
> -all displays are disabled the driver MAY choose to use a fallback,
> -such as 1024x768 at display 0.
> +for the initial scanout setup.  In case EDID support is negotiated
> +(VIRTIO_GPU_F_EDID feature flag) the device SHOULD also fetch the EDID
> +information using the VIRTIO_GPU_CMD_GET_EDID command.  If no
> +information is available or all displays are disabled the driver MAY
> +choose to use a fallback, such as 1024x768 at display 0.
> =20
>  \subsection{Device Operation}\label{sec:Device Types / GPU Device / Devi=
ce Operation}
> =20
> --=20
> 2.18.1
>=20
>=20
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

