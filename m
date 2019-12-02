Return-Path: virtio-dev-return-6433-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D517E985A86
	for <virtio-dev@lists.oasis-open.org>; Mon,  2 Dec 2019 10:14:35 +0000 (UTC)
References: <20191202100216.133556-1-stefanha@redhat.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <584b811b-db65-32f2-1cd3-09b432477f43@siemens.com>
Date: Mon, 2 Dec 2019 11:14:33 +0100
MIME-Version: 1.0
In-Reply-To: <20191202100216.133556-1-stefanha@redhat.com>
Content-Language: en-US
Subject: Re: [virtio-dev] [PATCH] virtio-blk: document VIRTIO_BLK_T_GET_ID
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Stefan Hajnoczi <stefanha@redhat.com>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 02.12.19 11:02, Stefan Hajnoczi wrote:
> The VIRTIO_BLK_T_GET_ID request type was implemented in Linux and QEMU
> in 2010.  It does not have a feature bit but devices respond with
> VIRTIO_BLK_S_UNSUPP if a request type is unimplemented.
>=20
> This patch documents the VIRTIO_BLK_T_GET_ID request type as currently
> implemented in Linux and QEMU.
>=20
> Suggested-by: Jan Kiszka <jan.kiszka@siemens.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   content.tex | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/content.tex b/content.tex
> index d68cfaf..b8baaad 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -4094,12 +4094,14 @@ \subsection{Device Operation}\label{sec:Device Ty=
pes / Block Device / Device Ope
>  =20
>   The type of the request is either a read (VIRTIO_BLK_T_IN), a write
>   (VIRTIO_BLK_T_OUT), a discard (VIRTIO_BLK_T_DISCARD), a write zeroes
> -(VIRTIO_BLK_T_WRITE_ZEROES) or a flush (VIRTIO_BLK_T_FLUSH).
> +(VIRTIO_BLK_T_WRITE_ZEROES), a flush (VIRTIO_BLK_T_FLUSH), or a get devi=
ce ID
> +string command (VIRTIO_BLK_T_GET_ID).
>  =20
>   \begin{lstlisting}
>   #define VIRTIO_BLK_T_IN           0
>   #define VIRTIO_BLK_T_OUT          1
>   #define VIRTIO_BLK_T_FLUSH        4
> +#define VIRTIO_BLK_T_GET_ID       8
>   #define VIRTIO_BLK_T_DISCARD      11
>   #define VIRTIO_BLK_T_WRITE_ZEROES 13
>   \end{lstlisting}
> @@ -4135,6 +4137,10 @@ \subsection{Device Operation}\label{sec:Device Typ=
es / Block Device / Device Ope
>   the device to discard the specified range, provided that following read=
s return
>   zeroes.
>  =20
> +VIRTIO_BLK_T_GET_ID requests fetch the device ID string from the device =
into
> +\field{data}.  The device ID string is a NUL-padded ASCII string up to 2=
0 bytes
> +long.  If the string is 20 bytes long then there is no NUL terminator.
> +
>   The final \field{status} byte is written by the device: either
>   VIRTIO_BLK_S_OK for success, VIRTIO_BLK_S_IOERR for device or driver
>   error or VIRTIO_BLK_S_UNSUPP for a request unsupported by device:
> @@ -4166,6 +4172,8 @@ \subsection{Device Operation}\label{sec:Device Type=
s / Block Device / Device Ope
>   virtio_blk_discard_write_zeroes for VIRTIO_BLK_T_DISCARD and
>   VIRTIO_BLK_T_WRITE_ZEROES requests.
>  =20
> +The length of \field{data} MUST be 20 bytes for VIRTIO_BLK_T_GET_ID requ=
ests.
> +
>   VIRTIO_BLK_T_DISCARD requests MUST NOT contain more than
>   \field{max_discard_seg} struct virtio_blk_discard_write_zeroes segments=
 in
>   \field{data}.
>=20

Reviewed-by: Jan Kiszka <jan.kiszka@siemens.com>

Thanks,
Jan

--=20
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

