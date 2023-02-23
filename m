Return-Path: <stefanha@redhat.com>
Date: Thu, 23 Feb 2023 15:46:15 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [virtio-comment] [PATCH] virtio-blk: Define dev cfg layout
 before its fields
Message-ID: <Y/fQl7ImbYGHEtVY@fedora>
References: <20230223135205.175949-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HD8Lz4zHhH/ynRAt"
Content-Disposition: inline
In-Reply-To: <20230223135205.175949-1-parav@nvidia.com>
To: Parav Pandit <parav@nvidia.com>
Cc: mst@redhat.com, virtio-dev@lists.oasis-open.org, cohuck@redhat.com, virtio-comment@lists.oasis-open.org, shahafs@nvidia.com, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>


--HD8Lz4zHhH/ynRAt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 23, 2023 at 03:52:05PM +0200, Parav Pandit wrote:
> Define device configuration layout structure before describing its
> individual fields.
>=20
> This is an editorial change.
>=20
> Suggested-by: Cornelia Huck <cohuck@redhat.com>
> Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> ---
>  device-types/blk/description.tex | 95 ++++++++++++++++----------------
>  1 file changed, 48 insertions(+), 47 deletions(-)
>=20
> diff --git a/device-types/blk/description.tex b/device-types/blk/descript=
ion.tex
> index 20007e3..517b012 100644
> --- a/device-types/blk/description.tex
> +++ b/device-types/blk/description.tex
> @@ -83,6 +83,54 @@ \subsubsection{Legacy Interface: Feature bits}\label{s=
ec:Device Types / Block De
> =20
>  \subsection{Device configuration layout}\label{sec:Device Types / Block =
Device / Device configuration layout}
> =20
> +The block device has the following device configuration layout.
> +
> +\begin{lstlisting}
> +struct virtio_blk_config {
> +        le64 capacity;
> +        le32 size_max;
> +        le32 seg_max;
> +        struct virtio_blk_geometry {
> +                le16 cylinders;
> +                u8 heads;
> +                u8 sectors;
> +        } geometry;
> +        le32 blk_size;
> +        struct virtio_blk_topology {
> +                // # of logical blocks per physical block (log2)
> +                u8 physical_block_exp;
> +                // offset of first aligned logical block
> +                u8 alignment_offset;
> +                // suggested minimum I/O size in blocks
> +                le16 min_io_size;
> +                // optimal (suggested maximum) I/O size in blocks
> +                le32 opt_io_size;
> +        } topology;
> +        u8 writeback;
> +        u8 unused0;
> +        u16 num_queues;
> +        le32 max_discard_sectors;
> +        le32 max_discard_seg;
> +        le32 discard_sector_alignment;
> +        le32 max_write_zeroes_sectors;
> +        le32 max_write_zeroes_seg;
> +        u8 write_zeroes_may_unmap;
> +        u8 unused1[3];
> +        le32 max_secure_erase_sectors;
> +        le32 max_secure_erase_seg;
> +        le32 secure_erase_sector_alignment;
> +        struct virtio_blk_zoned_characteristics {
> +                le32 zone_sectors;
> +                le32 max_open_zones;
> +                le32 max_active_zones;
> +                le32 max_append_sectors;
> +                le32 write_granularity;
> +                u8 model;
> +                u8 unused2[3];
> +        } zoned;
> +};
> +\end{lstlisting}
> +
>  The \field{capacity} of the device (expressed in 512-byte sectors) is al=
ways
>  present. The availability of the others all depend on various feature
>  bits as indicated above.
> @@ -167,53 +215,6 @@ \subsection{Device configuration layout}\label{sec:D=
evice Types / Block Device /
>  terminated by the device with a "zone resources exceeded" error as defin=
ed for
>  specific commands later.
> =20
> -\begin{lstlisting}
> -struct virtio_blk_config {
> -        le64 capacity;
> -        le32 size_max;
> -        le32 seg_max;
> -        struct virtio_blk_geometry {
> -                le16 cylinders;
> -                u8 heads;
> -                u8 sectors;
> -        } geometry;
> -        le32 blk_size;
> -        struct virtio_blk_topology {
> -                // # of logical blocks per physical block (log2)
> -                u8 physical_block_exp;
> -                // offset of first aligned logical block
> -                u8 alignment_offset;
> -                // suggested minimum I/O size in blocks
> -                le16 min_io_size;
> -                // optimal (suggested maximum) I/O size in blocks
> -                le32 opt_io_size;
> -        } topology;
> -        u8 writeback;
> -        u8 unused0;
> -        u16 num_queues;
> -        le32 max_discard_sectors;
> -        le32 max_discard_seg;
> -        le32 discard_sector_alignment;
> -        le32 max_write_zeroes_sectors;
> -        le32 max_write_zeroes_seg;
> -        u8 write_zeroes_may_unmap;
> -        u8 unused1[3];
> -        le32 max_secure_erase_sectors;
> -        le32 max_secure_erase_seg;
> -        le32 secure_erase_sector_alignment;
> -        struct virtio_blk_zoned_characteristics {
> -                le32 zone_sectors;
> -                le32 max_open_zones;
> -                le32 max_active_zones;
> -                le32 max_append_sectors;
> -                le32 write_granularity;
> -                u8 model;
> -                u8 unused2[3];
> -        } zoned;
> -};
> -\end{lstlisting}
> -
> -
>  \subsubsection{Legacy Interface: Device configuration layout}\label{sec:=
Device Types / Block Device / Device configuration layout / Legacy Interfac=
e: Device configuration layout}
>  When using the legacy interface, transitional devices and drivers
>  MUST format the fields in struct virtio_blk_config
> --=20
> 2.26.2

Yes, please!

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--HD8Lz4zHhH/ynRAt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmP30JcACgkQnKSrs4Gr
c8g81Qf/ah2jVXQjH0BlnzzXN9DZRqizmB2NaU4XoBX/w9iiwtc64junE59amV5d
bPfVQ6GVZ6ZaX6qIRtzkZurn0hqVYsLUzg1wqPXQMzl8FGxpJOjzaqsQF998fDhB
sSn52f+BqC5qXBc9rh7q41Z0jGFNJlEbT12CFzDfvKl7HRkQyiAlvLQ+4cPKhFDH
E8gBAt590WXK7OIw+s6sXQAfy0wJ5EWhcqVJrOniwTLvDmSaWOvIGyI8NxdY7IXY
a6i1NihpRWq6mMX3SFMrZU92BMBUvYqor0BJdjB80hxgFKGfGyfWl5TxNTEziSJ9
1hs6mW6cM6pIZz6ufx+KXqsQ6q4+3g==
=4tMg
-----END PGP SIGNATURE-----

--HD8Lz4zHhH/ynRAt--

