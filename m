Return-Path: virtio-dev-return-6317-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 676FB985DE9
	for <virtio-dev@lists.oasis-open.org>; Mon, 11 Nov 2019 17:27:01 +0000 (UTC)
References: <4fa78a91-751d-a7b5-fadf-b0ae8a5d5903@siemens.com>
 <CAJPjb1+Jnm-eHUQSFjhRBKAFNKqceHQMdRWtKEG+uncypGYKcA@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <2fed2342-d6fa-17ff-a812-ec01a14d8183@siemens.com>
Date: Mon, 11 Nov 2019 18:26:58 +0100
MIME-Version: 1.0
In-Reply-To: <CAJPjb1+Jnm-eHUQSFjhRBKAFNKqceHQMdRWtKEG+uncypGYKcA@mail.gmail.com>
Content-Language: en-US
Subject: Re: [virtio-dev] [PATCH] split-ring: Demand that a device must not
 change descriptor entries
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Rob Miller <rob.miller@broadcom.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On 11.11.19 18:17, Rob Miller wrote:
> what is trying to be solved=C2=A0here? There is a reason why this is allo=
wed=20
> as some vendors update the table when using RX_MERABLE_BUFFERs &=20
> F_IN_ORDER features

OK, good to know. Which fields are updated then? Under which conditions=20
(ie. in which states of the device)?

The background is in the link below. My goal was to find a simple way=20
declaring all fields read-only for the device to avoid problems with new=20
implementations. But it looks like it's more complicated...

Jan

>=20
> Rob Miller
> rob.miller@broadcom.com <mailto:rob.miller@broadcom.com>
> (919)721-3339
>=20
>=20
> On Mon, Nov 11, 2019 at 12:13 PM Jan Kiszka <jan.kiszka@siemens.com=20
> <mailto:jan.kiszka@siemens.com>> wrote:
>=20
>     From: Jan Kiszka <jan.kiszka@siemens.com
>     <mailto:jan.kiszka@siemens.com>>
>=20
>     So far the spec only indirectly says that a descriptor table entry is
>     not modified by a device when processing it. Make this explicit by
>     adding it as normative requirement. Existing drivers already depend o=
n
>     this.
>=20
>     See also
>     https://lists.oasis-open.org/archives/virtio-dev/201910/msg00057.html=
.
>=20
>     Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com
>     <mailto:jan.kiszka@siemens.com>>
>     ---
>      =C2=A0split-ring.tex | 2 +-
>      =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
>     diff --git a/split-ring.tex b/split-ring.tex
>     index 123ac9f..bfef62d 100644
>     --- a/split-ring.tex
>     +++ b/split-ring.tex
>     @@ -217,7 +217,7 @@ \subsection{The Virtqueue Descriptor
>     Table}\label{sec:Basic Facilities of a Virt
>      =C2=A0\devicenormative{\subsubsection}{The Virtqueue Descriptor
>     Table}{Basic Facilities of a Virtio Device / Virtqueues / The
>     Virtqueue Descriptor Table}
>      =C2=A0A device MUST NOT write to a device-readable buffer, and a dev=
ice
>     SHOULD NOT
>      =C2=A0read a device-writable buffer (it MAY do so for debugging or
>     diagnostic
>     -purposes).
>     +purposes). A device MUST NOT write to any descriptor table entry.
>=20
>      =C2=A0\drivernormative{\subsubsection}{The Virtqueue Descriptor
>     Table}{Basic Facilities of a Virtio Device / Virtqueues / The
>     Virtqueue Descriptor Table}
>      =C2=A0Drivers MUST NOT add a descriptor chain longer than $2^{32}$ b=
ytes
>     in total;
>     --=20
>     2.16.4
>=20
>     ---------------------------------------------------------------------
>     To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
>     <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
>     For additional commands, e-mail:
>     virtio-dev-help@lists.oasis-open.org
>     <mailto:virtio-dev-help@lists.oasis-open.org>
>=20

--=20
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

