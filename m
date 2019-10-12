Return-Path: virtio-dev-return-6231-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 87EBC985E3C
	for <virtio-dev@lists.oasis-open.org>; Sat, 12 Oct 2019 16:56:52 +0000 (UTC)
Date: Sat, 12 Oct 2019 12:56:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20191012125617-mutt-send-email-mst@kernel.org>
References: <1170e604-7d65-1c97-33f7-741054ecf5e0@siemens.com>
MIME-Version: 1.0
In-Reply-To: <1170e604-7d65-1c97-33f7-741054ecf5e0@siemens.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: Re: [virtio-dev] [PATCH] Fix ^= in example code
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Oct 11, 2019 at 01:43:41PM +0200, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
>=20
> Trying to escaping ^ here only leaves the backslash in the output.
>=20
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

Thanks! I think this kind of typo can be merged with no need for votes,
we have a standing rule for typos.

> ---
>  packed-ring.tex | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/packed-ring.tex b/packed-ring.tex
> index caf47a5..ea92543 100644
> --- a/packed-ring.tex
> +++ b/packed-ring.tex
> @@ -634,7 +634,7 @@ \subsubsection{Implementation Example}\label{sec:Basi=
c Facilities of a Virtio De
> =20
>          if (vq->next_avail >=3D vq->size) {
>                  vq->next_avail =3D 0;
> -                vq->avail_wrap_count \^=3D 1;
> +                vq->avail_wrap_count ^=3D 1;
>          }
>  }
>  vq->sgs[id] =3D sgs;
> @@ -727,7 +727,7 @@ \subsection{Receiving Used Buffers From The Device}\l=
abel{sec:Basic Facilities o
>          vq->next_used +=3D sgs;
>          if (vq->next_used >=3D vq->size) {
>                  vq->next_used -=3D vq->size;
> -                vq->used_wrap_count \^=3D 1;
> +                vq->used_wrap_count ^=3D 1;
>          }
> =20
>          free_id(vq, id);
> --=20
> 2.16.4
>=20
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

