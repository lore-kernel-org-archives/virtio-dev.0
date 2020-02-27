Return-Path: virtio-dev-return-6798-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EA8F6985E3D
	for <virtio-dev@lists.oasis-open.org>; Thu, 27 Feb 2020 10:05:58 +0000 (UTC)
Date: Thu, 27 Feb 2020 05:05:46 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20200227050257-mutt-send-email-mst@kernel.org>
References: <4fa78a91-751d-a7b5-fadf-b0ae8a5d5903@siemens.com>
 <CAJPjb1+Jnm-eHUQSFjhRBKAFNKqceHQMdRWtKEG+uncypGYKcA@mail.gmail.com>
 <2fed2342-d6fa-17ff-a812-ec01a14d8183@siemens.com>
MIME-Version: 1.0
In-Reply-To: <2fed2342-d6fa-17ff-a812-ec01a14d8183@siemens.com>
Subject: Re: [virtio-dev] [PATCH] split-ring: Demand that a device must not
 change descriptor entries
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Rob Miller <rob.miller@broadcom.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Nov 11, 2019 at 06:26:58PM +0100, Jan Kiszka wrote:
> On 11.11.19 18:17, Rob Miller wrote:
> > what is trying to be solved=A0here? There is a reason why this is allow=
ed
> > as some vendors update the table when using RX_MERABLE_BUFFERs &
> > F_IN_ORDER features
>=20
> OK, good to know. Which fields are updated then? Under which conditions (=
ie.
> in which states of the device)?
>=20
> The background is in the link below. My goal was to find a simple way
> declaring all fields read-only for the device to avoid problems with new
> implementations. But it looks like it's more complicated...
>=20
> Jan

No answer yet. Rob I see the following options:
- proceed with the ballot as is ignoring your comment. Maybe it's all a
  misunderstanding? It could be the comment was referring to the
  packed ring, where this patch refers to the split ring.
- make it weaker: MUST if PLATFORM_ACCESS is negotiated, and
  SHOULD if it isn't.

> >=20
> > Rob Miller
> > rob.miller@broadcom.com <mailto:rob.miller@broadcom.com>
> > (919)721-3339
> >=20
> >=20
> > On Mon, Nov 11, 2019 at 12:13 PM Jan Kiszka <jan.kiszka@siemens.com
> > <mailto:jan.kiszka@siemens.com>> wrote:
> >=20
> >     From: Jan Kiszka <jan.kiszka@siemens.com
> >     <mailto:jan.kiszka@siemens.com>>
> >=20
> >     So far the spec only indirectly says that a descriptor table entry =
is
> >     not modified by a device when processing it. Make this explicit by
> >     adding it as normative requirement. Existing drivers already depend=
 on
> >     this.
> >=20
> >     See also
> >     https://lists.oasis-open.org/archives/virtio-dev/201910/msg00057.ht=
ml.
> >=20
> >     Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com
> >     <mailto:jan.kiszka@siemens.com>>
> >     ---
> >      =A0split-ring.tex | 2 +-
> >      =A01 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> >     diff --git a/split-ring.tex b/split-ring.tex
> >     index 123ac9f..bfef62d 100644
> >     --- a/split-ring.tex
> >     +++ b/split-ring.tex
> >     @@ -217,7 +217,7 @@ \subsection{The Virtqueue Descriptor
> >     Table}\label{sec:Basic Facilities of a Virt
> >      =A0\devicenormative{\subsubsection}{The Virtqueue Descriptor
> >     Table}{Basic Facilities of a Virtio Device / Virtqueues / The
> >     Virtqueue Descriptor Table}
> >      =A0A device MUST NOT write to a device-readable buffer, and a devi=
ce
> >     SHOULD NOT
> >      =A0read a device-writable buffer (it MAY do so for debugging or
> >     diagnostic
> >     -purposes).
> >     +purposes). A device MUST NOT write to any descriptor table entry.
> >=20
> >      =A0\drivernormative{\subsubsection}{The Virtqueue Descriptor
> >     Table}{Basic Facilities of a Virtio Device / Virtqueues / The
> >     Virtqueue Descriptor Table}
> >      =A0Drivers MUST NOT add a descriptor chain longer than $2^{32}$ by=
tes
> >     in total;
> >     --     2.16.4
> >=20
> >     -------------------------------------------------------------------=
--
> >     To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> >     <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
> >     For additional commands, e-mail:
> >     virtio-dev-help@lists.oasis-open.org
> >     <mailto:virtio-dev-help@lists.oasis-open.org>
> >=20
>=20
> --=20
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux
>=20
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

