Return-Path: virtio-dev-return-5451-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4F948985B56
	for <virtio-dev@lists.oasis-open.org>; Mon, 18 Feb 2019 14:04:26 +0000 (UTC)
Date: Mon, 18 Feb 2019 14:04:20 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190218140420.GG12256@stefanha-x1.localdomain>
References: <20190131023617.23007-1-stefanha@redhat.com>
 <20190131023617.23007-2-stefanha@redhat.com>
 <20190130231152-mutt-send-email-mst@kernel.org>
 <51483aeb-9409-3a90-8da6-369fa4d34488@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eMnpOGXCMazMAbfp"
Content-Disposition: inline
In-Reply-To: <51483aeb-9409-3a90-8da6-369fa4d34488@siemens.com>
Subject: Re: [virtio-dev] Re: [PATCH v2 1/4] virtio-blk: document data[] size
 constraints
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtio-dev@lists.oasis-open.org, Changpeng Liu <changpeng.liu@intel.com>, Stefano Garzarella <sgarzare@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--eMnpOGXCMazMAbfp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 18, 2019 at 08:22:00AM +0100, Jan Kiszka wrote:
> On 31.01.19 05:14, Michael S. Tsirkin wrote:
> > On Thu, Jan 31, 2019 at 10:36:14AM +0800, Stefan Hajnoczi wrote:
> > > The struct virtio_blk_req->data[] field is a multiple of 512 bytes lo=
ng
> > > for read and write requests.  Flush requests don't use data[] at all.
> > >=20
> > > The new discard and write zeroes requests being introduced in VIRTIO =
1.1
> > > put struct virtio_blk_discard_write_zeroes elements into data[], so it
> > > must be a multiple of the struct size.
> > >=20
> > > The uint8_t data[][512] pseudo-code makes it look like discard and wr=
ite
> > > zeroes requests must pad to 512 bytes.  This wastes memory since stru=
ct
> > > virtio_blk_discard_write_data is only 16 bytes long.
> > >=20
> > > Furthermore, all known implementations wishing to take advantage of t=
his
> > > upcoming VIRTIO 1.1 feature do not use 512-byte padding (Linux
> > > virtio_blk.ko, QEMU virtio-blk device emulation, the SPDK virtio-blk
> > > driver, and the SPDK vhost-user-blk device backend).
> > >=20
> > > This patch documents the data[] size constraints clearly in the driver
> > > normative section.  This is clearer than the current pseudo-code.
> > >=20
> > > Cc: Michael S. Tsirkin <mst@redhat.com>
> > > Cc: Changpeng Liu <changpeng.liu@intel.com>
> > > Cc: Stefano Garzarella <sgarzare@redhat.com>
> > > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > ---
> > >   content.tex | 14 +++++++++++++-
> > >   1 file changed, 13 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/content.tex b/content.tex
> > > index 836ee52..b185bb0 100644
> > > --- a/content.tex
> > > +++ b/content.tex
> > > @@ -3941,7 +3941,7 @@ struct virtio_blk_req {
> > >           le32 type;
> > >           le32 reserved;
> > >           le64 sector;
> > > -        u8 data[][512];
> > > +        u8 data[];
> > >           u8 status;
> > >   };
> > > @@ -3971,6 +3971,11 @@ The \field{sector} number indicates the offset=
 (multiplied by 512) where
> > >   the read or write is to occur. This field is unused and set to 0 for
> > >   commands other than read or write.
> > > +VIRTIO_BLK_T_IN requests populate \field{data} with the contents of =
sectors
> > > +read from the block device (in multiples of 512 bytes).  VIRTIO_BLK_=
T_OUT
> > > +requests write the contents of \field{data} to the block device (in =
multiples
> > > +of 512 bytes).
> > > +
> > >   The \field{data} used for discard or write zeroes command is descri=
bed
> > >   by one or more virtio_blk_discard_write_zeroes structs. \field{sect=
or}
> > >   indicates the starting offset (in 512-byte units) of the segment, w=
hile
> > > @@ -3997,6 +4002,13 @@ A driver SHOULD accept the VIRTIO_BLK_F_RO fea=
ture if offered.
> > >   A driver MUST set \field{sector} to 0 for a VIRTIO_BLK_T_FLUSH requ=
est.
> > >   A driver SHOULD NOT include any data in a VIRTIO_BLK_T_FLUSH reques=
t.
> > > +The length of \field{data} MUST be a multiple of 512 bytes for VIRTI=
O_BLK_T_IN
> > > +and VIRTIO_BLK_T_OUT requests.
> > > +
> > > +The length of \field{data} MUST be a multiple of the size of struct
> > > +virtio_blk_discard_write_zeroes for VIRTIO_BLK_T_DISCARD and
> > > +VIRTIO_BLK_T_WRITE_ZEROES requests.
> > > +
> >=20

I'm not the original spec author.  Feel free to correct me if this is
wrong:

> > So a single request can discard/write multiple ranges?
> > It might be a good idea to make this explicit.
> > Also is this capability useful/used?

The multiple segments feature was included because the underlying
storage might support it.  Currently we don't expect much use but future
hardware may rely on it more heavily (e.g. for performance).

> > And what's the value of status
> > in case some of the requests fail?

A failure for any segment causes the entire request to fail with no
information about which segments completed or failed.

> What happened with this comment? I don't see a follow-up nor a resolution
> elsewhere, just the opening of issue #32 for voting. Please clarify.

With #32 applied the spec says:

"max_discard_seg can be read to determine the [...] maximum number of disca=
rd segments for the block driver to use"

and

"The length of \field{data} MUST be a multiple of the size of struct
virtio_blk_discard_write_zeroes for VIRTIO_BLK_T_DISCARD and
VIRTIO_BLK_T_WRITE_ZEROES requests."

This is not very explicit but it means multiple struct
virtio_blk_discard_write_zeroes can be included in a request, up to
max_discard_seg.

I think two things are appropriate:
1. A driver normative statement saying up to
   max_discard_seg/max_write_zeroes_seg structs may be included in a
   request
2. A general description that says DISCARD/WRITE_ZEROES requests may
   have more than 1 "segment" (struct virtio_blk_discard_write_zeroes)

Does that sound good?

Stefan

--eMnpOGXCMazMAbfp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcartkAAoJEJykq7OBq3PIkCUH/3emdZk32/107BQl+jizMeOB
vg/YiSoqZ9NpF6zFQYePVlVX5fuUS9T7dKB4lSnMI1VLqSnPA3LYeUEyIY3yZURV
dP2wAJs7rXFl92kUuxdHk1HMsyWvJF+4amqJ3b5+NxRw4X0rCoTFqKlOONZX8xM0
fyzAl4Cdci9Q5rqbGATsQY2a3B8kOxTHTJxQfznxWcSGg84PUuHV6izgjvuWUeFX
LfzibsMJn2H8r/Z6Fl/RBBGAC9hIu/mNW0WiDsIMcgS+Q3SVXUsC6M3/UvsfaArp
GndudaQZOR3BEj6EGfsDTnWpgcaG1jFSfg1Sv/iQsTSuePQE1vxa9CbI7yN1GpQ=
=ntkc
-----END PGP SIGNATURE-----

--eMnpOGXCMazMAbfp--
