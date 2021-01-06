Return-Path: virtio-comment-return-1622-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Wed, 6 Jan 2021 18:11:58 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20210106181158.GC133350@stefanha-x1.localdomain>
References: <ff3ec9f5cb7f480a52913790f698ad45c66edcc2.1608796685.git.jie.deng@intel.com>
MIME-Version: 1.0
In-Reply-To: <ff3ec9f5cb7f480a52913790f698ad45c66edcc2.1608796685.git.jie.deng@intel.com>
Subject: Re: [virtio-comment] [PATCH v6] virtio-i2c: add the device
 specification
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+nBD6E3TurpgldQp"
Content-Disposition: inline
To: Jie Deng <jie.deng@intel.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, kraxel@redhat.com, wsa+renesas@sang-engineering.com, andriy.shevchenko@linux.intel.com, conghui.chen@intel.com, yu1.wang@intel.com, shuo.a.liu@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

--+nBD6E3TurpgldQp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 24, 2020 at 04:10:43PM +0800, Jie Deng wrote:
> +\begin{lstlisting}
> +struct virtio_i2c_out_hdr {
> +        le16 addr;
> +        le16 padding;
> +        le32 flags;
> +};
> +\end{lstlisting}
> +
> +\begin{lstlisting}
> +struct virtio_i2c_in_hdr {
> +        u8 status;
> +};
> +\end{lstlisting}
> +
> +\begin{lstlisting}
> +struct virtio_i2c_req {
> +        struct virtio_i2c_out_hdr out_hdr;
> +        u8 write_buf[];
> +        u8 read_buf[];
> +        struct virtio_i2c_in_hdr in_hdr;
> +};
> +\end{lstlisting}

I didn't notice that the written and read fields were removed. Does this
mean that struct virtio_i2c_req can either be read or write, but not
read+write?

This makes sense if virtqueue buffers can be grouped together so
bi-directional transfers can be described using multiple buffers. Just
wanted to check if I understand this correctly.

Thanks,
Stefan

--+nBD6E3TurpgldQp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl/1/W4ACgkQnKSrs4Gr
c8hKwwf6A0R3xYO1WeVb7t7sPqoUPEFU2Hy5R1ItuiJ+aMLuVBR47oHccWbv1Hll
72G8C+CqYD0rIE0MFvQbxCe1OUfVkHQCB4Ujf33vw1XV9QzZYJpkiHzGXNoVfNHL
6o8KcBvJg59+oiEf9Gk+EfkEA9BFSl/W+UxYFGxqIw+aQDBBoEX37pecqFvO3iUo
AGbQ1il651zMDW1hjdixUugEVyWpmvtOfKVV8DMSbfgHZDTuebXyKW9EWmZajrxY
+0hFmMv4s1wP+Ho/Z8wIhBeqQ0xgMPiXTZ0pa78RNTaf+pzml08ROUos1P6+bgYP
QkMH4KfKu1G85eydL35Zfs5Uzm5fHw==
=cHb+
-----END PGP SIGNATURE-----

--+nBD6E3TurpgldQp--

