Return-Path: virtio-dev-return-6440-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BDCB6985C13
	for <virtio-dev@lists.oasis-open.org>; Mon,  2 Dec 2019 16:58:58 +0000 (UTC)
Date: Mon, 2 Dec 2019 11:58:51 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20191202115816-mutt-send-email-mst@kernel.org>
References: <20191129083130.15353-1-kraxel@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191129083130.15353-1-kraxel@redhat.com>
Subject: Re: [virtio-dev] [PATCH] virtio-gpu: add 3d command overview
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Nov 29, 2019 at 09:31:30AM +0100, Gerd Hoffmann wrote:
> Add 3d commands to the command enumeration.
> Add a section with a very short overview.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Pls don't forget to create github issues and request
voting when you are ready.

> ---
>  virtio-gpu.tex | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>=20
> diff --git a/virtio-gpu.tex b/virtio-gpu.tex
> index eced3095a494..631aaf24ea18 100644
> --- a/virtio-gpu.tex
> +++ b/virtio-gpu.tex
> @@ -213,6 +213,16 @@ \subsubsection{Device Operation: Request header}\lab=
el{sec:Device Types / GPU De
>          VIRTIO_GPU_CMD_GET_EDID,
>          VIRTIO_GPU_CMD_RESOURCE_CREATE_2D_SHARED,
> =20
> +        /* 3d commands (OpenGL) */
> +        VIRTIO_GPU_CMD_CTX_CREATE =3D 0x0200,
> +        VIRTIO_GPU_CMD_CTX_DESTROY,
> +        VIRTIO_GPU_CMD_CTX_ATTACH_RESOURCE,
> +        VIRTIO_GPU_CMD_CTX_DETACH_RESOURCE,
> +        VIRTIO_GPU_CMD_RESOURCE_CREATE_3D,
> +        VIRTIO_GPU_CMD_TRANSFER_TO_HOST_3D,
> +        VIRTIO_GPU_CMD_TRANSFER_FROM_HOST_3D,
> +        VIRTIO_GPU_CMD_SUBMIT_3D,
> +
>          /* cursor commands */
>          VIRTIO_GPU_CMD_UPDATE_CURSOR =3D 0x0300,
>          VIRTIO_GPU_CMD_MOVE_CURSOR,
> @@ -488,6 +498,31 @@ \subsubsection{Device Operation: controlq}\label{sec=
:Device Types / GPU Device /
> =20
>  \end{description}
> =20
> +\subsubsection{Device Operation: controlq (3d)}\label{sec:Device Types /=
 GPU Device / Device Operation / Device Operation: controlq (3d)}
> +
> +These commands are supported by the device if the VIRTIO_GPU_F_VIRGL
> +feature flag is set.
> +
> +\begin{description}
> +
> +\item[VIRTIO_GPU_CMD_CTX_CREATE]
> +\item[VIRTIO_GPU_CMD_CTX_DESTROY]
> +\item[VIRTIO_GPU_CMD_CTX_ATTACH_RESOURCE]
> +\item[VIRTIO_GPU_CMD_CTX_DETACH_RESOURCE]
> +  Manage OpenGL contexts.
> +
> +\item[VIRTIO_GPU_CMD_RESOURCE_CREATE_3D]
> +  Create OpenGL resources.
> +
> +\item[VIRTIO_GPU_CMD_TRANSFER_TO_HOST_3D]
> +\item[VIRTIO_GPU_CMD_TRANSFER_FROM_HOST_3D]
> +  Transfer data from and to OpenGL resources.
> +
> +\item[VIRTIO_GPU_CMD_SUBMIT_3D]
> +  Submit rendering commands (mesa gallium command stream).
> +
> +\end{description}
> +
>  \subsubsection{Device Operation: cursorq}\label{sec:Device Types / GPU D=
evice / Device Operation / Device Operation: cursorq}
> =20
>  Both cursorq commands use the same command struct.
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

