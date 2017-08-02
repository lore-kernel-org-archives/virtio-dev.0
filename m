Return-Path: virtio-dev-return-2432-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id B092D58190CD
	for <virtio-dev@lists.oasis-open.org>; Wed,  2 Aug 2017 06:50:08 -0700 (PDT)
Date: Wed, 2 Aug 2017 16:50:03 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170802164931-mutt-send-email-mst@kernel.org>
References: <20170414051304-mutt-send-email-mst@kernel.org>
 <20170414054318-mutt-send-email-mst@kernel.org>
 <CAJR92jnV1VgBs567QNjO1fHKDgMX=1j1aJJ2gK-TqMB5E1=fvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAJR92jnV1VgBs567QNjO1fHKDgMX=1j1aJJ2gK-TqMB5E1=fvw@mail.gmail.com>
Subject: Re: [virtio-dev] repost: af_packet vs virtio (was packed ring layout
 proposal v2)
To: Steven Luong <sluong99@gmail.com>
Cc: john.fastabend@gmail.com, alexei.starovoitov@gmail.com, netdev@vger.kernel.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Aug 01, 2017 at 08:54:27PM -0700, Steven Luong wrote:
>     * Descriptor ring:
>=20
>     Guest adds descriptors with unique index values and DESC_HW set in fl=
ags.
>     Host overwrites used descriptors with correct len, index, and DESC_HW
>     clear.=A0 Flags are always set/cleared last.
>=20
>     #define DESC_HW 0x0080
>=20
>     struct desc {
>     =A0 =A0 =A0 =A0 __le64 addr;
>     =A0 =A0 =A0 =A0 __le32 len;
>     =A0 =A0 =A0 =A0 __le16 index;
>     =A0 =A0 =A0 =A0 __le16 flags;
>     };
>=20
>     When DESC_HW is set, descriptor belongs to device. When it is clear,
>     it belongs to the driver.
>=20
>     We can use 1 bit to set direction
>     /* This marks a buffer as write-only (otherwise read-only). */
>     #define VRING_DESC_F_WRITE=A0 =A0 =A0 2
>=20
>     * Scatter/gather support
>=20
>     We can use 1 bit to chain s/g entries in a request, same as virtio 1.=
0:
>=20
>     /* This marks a buffer as continuing via the next field. */
>=20
>=20
> This comment here is confusing to me. In 1.0, virtq_desc has the next fie=
ld.
> When the flag VRING_DESC_F_NEXT is set, the next entry to continue is spe=
cified
> in the next field.
>=20
> Here in 1.1, struct desc does not have the next field, only addr, len, in=
dex,
> and flags. So when VRING_DESC_F_NEXT is set in struct desc's flags field,=
 where
> is the next entry to continue the current descriptor, the entry immediate=
ly
> following the current entry? ie, if the current entry is at index 10 in t=
he
> descriptor table and its flags is set for VRING_DESC_F_NEXT, is the entry
> continuing the current entry in index 11?
>=20
> Steven

Exactly, you got it right.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

