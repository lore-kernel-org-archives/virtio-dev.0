Return-Path: virtio-dev-return-6683-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 07EBB985F8C
	for <virtio-dev@lists.oasis-open.org>; Wed, 22 Jan 2020 08:29:36 +0000 (UTC)
Date: Wed, 22 Jan 2020 03:29:28 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20200122032433-mutt-send-email-mst@kernel.org>
References: <CAD=HUj7N8dpEvf0Be8fg-qpFFTQOqzZX_kVoFB=BWp8S4uEFvg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAD=HUj7N8dpEvf0Be8fg-qpFFTQOqzZX_kVoFB=BWp8S4uEFvg@mail.gmail.com>
Subject: Re: [virtio-dev][RFC PATCH v1 2/2] virtio-gpu: add the ability to
 export resources
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: David Stevens <stevensd@chromium.org>
Cc: virtio-dev@lists.oasis-open.org, Gerd Hoffmann <kraxel@redhat.com>, Dylan Reid <dgreid@chromium.org>, Tomasz Figa <tfiga@chromium.org>, Zach Reizner <zachr@chromium.org>, Keiichi Watanabe <keiichiw@chromium.org>, Alexandre Courbot <acourbot@chromium.org>, Alex Lau <alexlau@chromium.org>, =?iso-8859-1?Q?St=E9phane?= Marchesin <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, Gurchetan Singh <gurchetansingh@chromium.org>, Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>, Linux Media Mailing List <linux-media@vger.kernel.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jan 22, 2020 at 04:16:35PM +0900, David Stevens wrote:
> Signed-off-by: David Stevens <stevensd@chromium.org>
> ---
>  virtio-gpu.tex | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>=20
> diff --git a/virtio-gpu.tex b/virtio-gpu.tex
> index af4ca61..a1f0210 100644
> --- a/virtio-gpu.tex
> +++ b/virtio-gpu.tex
> @@ -186,12 +186,16 @@ \subsubsection{Device Operation: Request
> header}\label{sec:Device Types / GPU De
>          VIRTIO_GPU_CMD_UPDATE_CURSOR =3D 0x0300,
>          VIRTIO_GPU_CMD_MOVE_CURSOR,
>=20
> +        /* misc commands */
> +        VIRTIO_GPU_CMD_RESOURCE_ASSIGN_UUID =3D 0x0400,
> +
>          /* success responses */
>          VIRTIO_GPU_RESP_OK_NODATA =3D 0x1100,
>          VIRTIO_GPU_RESP_OK_DISPLAY_INFO,
>          VIRTIO_GPU_RESP_OK_CAPSET_INFO,
>          VIRTIO_GPU_RESP_OK_CAPSET,
>          VIRTIO_GPU_RESP_OK_EDID,
> +        VIRTIO_GPU_RESP_OK_RESOURCE_ASSIGN_UUID,
>=20
>          /* error responses */
>          VIRTIO_GPU_RESP_ERR_UNSPEC =3D 0x1200,
> @@ -454,6 +458,32 @@ \subsubsection{Device Operation:
> controlq}\label{sec:Device Types / GPU Device /
>  This detaches any backing pages from a resource, to be used in case of
>  guest swapping or object destruction.
>=20
> +\item[VIRTIO_GPU_CMD_RESOURCE_ASSIGN_UUID] Creates an exported object fr=
om
> +  a resource. Request data is \field{struct
> +    virtio_gpu_resource_assign_uuid}.  Response type is
> +  VIRTIO_GPU_RESP_OK_RESOURCE_ASSIGN_UUID, response data is \field{struc=
t
> +    virtio_gpu_resp_resource_assign_uuid}.
> +
> +\begin{lstlisting}
> +struct virtio_gpu_resource_assign_uuid {
> +        struct virtio_gpu_ctrl_hdr hdr;
> +        le32 resource_id;
> +        le32 padding;
> +};
> +
> +struct virtio_gpu_resp_resource_assign_uuid {
> +        struct virtio_gpu_ctrl_hdr hdr;
> +        le64 uuid_low;
> +        le64 uuid_high;
> +};
> +\end{lstlisting}
> +

ok but how is this then used? will there be more commands to pass
this uuid to another device?

> +The response contains a uuid which identifies the exported object create=
d from
> +the host private resource.

Are the uuids as specified in rfc-4122? I guess we need to link to that spe=
c then
..

> Note that if the resource has an attached backing,
> +modifications made to the host private resource through the exported obj=
ect by
> +other devices are not visible in the attached backing until they are
> transferred
> +into the backing.
> +

s/host/device/?

>  \end{description}
>=20
>  \subsubsection{Device Operation: cursorq}\label{sec:Device Types /
> GPU Device / Device Operation / Device Operation: cursorq}
> --=20
> 2.25.0.341.g760bfbb309-goog
>=20
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

