Return-Path: virtio-dev-return-5500-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 56FD29860E5
	for <virtio-dev@lists.oasis-open.org>; Fri, 22 Feb 2019 09:55:26 +0000 (UTC)
Date: Fri, 22 Feb 2019 09:55:20 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190222095520.GC27304@stefanha-x1.localdomain>
References: <20190131023617.23007-1-stefanha@redhat.com>
 <20190131023617.23007-2-stefanha@redhat.com>
 <20190130231152-mutt-send-email-mst@kernel.org>
 <51483aeb-9409-3a90-8da6-369fa4d34488@siemens.com>
 <20190218140420.GG12256@stefanha-x1.localdomain>
 <20190222005312-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KDt/GgjP6HVcx58l"
Content-Disposition: inline
In-Reply-To: <20190222005312-mutt-send-email-mst@kernel.org>
Subject: Re: [virtio-dev] Re: [PATCH v2 1/4] virtio-blk: document data[] size
 constraints
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, virtio-dev@lists.oasis-open.org, Changpeng Liu <changpeng.liu@intel.com>, Stefano Garzarella <sgarzare@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--KDt/GgjP6HVcx58l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 22, 2019 at 12:53:42AM -0500, Michael S. Tsirkin wrote:
> On Mon, Feb 18, 2019 at 02:04:20PM +0000, Stefan Hajnoczi wrote:
> > On Mon, Feb 18, 2019 at 08:22:00AM +0100, Jan Kiszka wrote:
> > > On 31.01.19 05:14, Michael S. Tsirkin wrote:
> > > > On Thu, Jan 31, 2019 at 10:36:14AM +0800, Stefan Hajnoczi wrote:
> > > > > The struct virtio_blk_req->data[] field is a multiple of 512 byte=
s long
> > > > > for read and write requests.  Flush requests don't use data[] at =
all.
> > > > >=20
> > > > > The new discard and write zeroes requests being introduced in VIR=
TIO 1.1
> > > > > put struct virtio_blk_discard_write_zeroes elements into data[], =
so it
> > > > > must be a multiple of the struct size.
> > > > >=20
> > > > > The uint8_t data[][512] pseudo-code makes it look like discard an=
d write
> > > > > zeroes requests must pad to 512 bytes.  This wastes memory since =
struct
> > > > > virtio_blk_discard_write_data is only 16 bytes long.
> > > > >=20
> > > > > Furthermore, all known implementations wishing to take advantage =
of this
> > > > > upcoming VIRTIO 1.1 feature do not use 512-byte padding (Linux
> > > > > virtio_blk.ko, QEMU virtio-blk device emulation, the SPDK virtio-=
blk
> > > > > driver, and the SPDK vhost-user-blk device backend).
> > > > >=20
> > > > > This patch documents the data[] size constraints clearly in the d=
river
> > > > > normative section.  This is clearer than the current pseudo-code.
> > > > >=20
> > > > > Cc: Michael S. Tsirkin <mst@redhat.com>
> > > > > Cc: Changpeng Liu <changpeng.liu@intel.com>
> > > > > Cc: Stefano Garzarella <sgarzare@redhat.com>
> > > > > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > > > ---
> > > > >   content.tex | 14 +++++++++++++-
> > > > >   1 file changed, 13 insertions(+), 1 deletion(-)
> > > > >=20
> > > > > diff --git a/content.tex b/content.tex
> > > > > index 836ee52..b185bb0 100644
> > > > > --- a/content.tex
> > > > > +++ b/content.tex
> > > > > @@ -3941,7 +3941,7 @@ struct virtio_blk_req {
> > > > >           le32 type;
> > > > >           le32 reserved;
> > > > >           le64 sector;
> > > > > -        u8 data[][512];
> > > > > +        u8 data[];
> > > > >           u8 status;
> > > > >   };
> > > > > @@ -3971,6 +3971,11 @@ The \field{sector} number indicates the of=
fset (multiplied by 512) where
> > > > >   the read or write is to occur. This field is unused and set to =
0 for
> > > > >   commands other than read or write.
> > > > > +VIRTIO_BLK_T_IN requests populate \field{data} with the contents=
 of sectors
> > > > > +read from the block device (in multiples of 512 bytes).  VIRTIO_=
BLK_T_OUT
> > > > > +requests write the contents of \field{data} to the block device =
(in multiples
> > > > > +of 512 bytes).
> > > > > +
> > > > >   The \field{data} used for discard or write zeroes command is de=
scribed
> > > > >   by one or more virtio_blk_discard_write_zeroes structs. \field{=
sector}
> > > > >   indicates the starting offset (in 512-byte units) of the segmen=
t, while
> > > > > @@ -3997,6 +4002,13 @@ A driver SHOULD accept the VIRTIO_BLK_F_RO=
 feature if offered.
> > > > >   A driver MUST set \field{sector} to 0 for a VIRTIO_BLK_T_FLUSH =
request.
> > > > >   A driver SHOULD NOT include any data in a VIRTIO_BLK_T_FLUSH re=
quest.
> > > > > +The length of \field{data} MUST be a multiple of 512 bytes for V=
IRTIO_BLK_T_IN
> > > > > +and VIRTIO_BLK_T_OUT requests.
> > > > > +
> > > > > +The length of \field{data} MUST be a multiple of the size of str=
uct
> > > > > +virtio_blk_discard_write_zeroes for VIRTIO_BLK_T_DISCARD and
> > > > > +VIRTIO_BLK_T_WRITE_ZEROES requests.
> > > > > +
> > > >=20
> >=20
> > I'm not the original spec author.  Feel free to correct me if this is
> > wrong:
> >=20
> > > > So a single request can discard/write multiple ranges?
> > > > It might be a good idea to make this explicit.
> > > > Also is this capability useful/used?
> >=20
> > The multiple segments feature was included because the underlying
> > storage might support it.  Currently we don't expect much use but future
> > hardware may rely on it more heavily (e.g. for performance).
> >=20
> > > > And what's the value of status
> > > > in case some of the requests fail?
> >=20
> > A failure for any segment causes the entire request to fail with no
> > information about which segments completed or failed.
> >=20
> > > What happened with this comment? I don't see a follow-up nor a resolu=
tion
> > > elsewhere, just the opening of issue #32 for voting. Please clarify.
> >=20
> > With #32 applied the spec says:
> >=20
> > "max_discard_seg can be read to determine the [...] maximum number of d=
iscard segments for the block driver to use"
> >=20
> > and
> >=20
> > "The length of \field{data} MUST be a multiple of the size of struct
> > virtio_blk_discard_write_zeroes for VIRTIO_BLK_T_DISCARD and
> > VIRTIO_BLK_T_WRITE_ZEROES requests."
> >=20
> > This is not very explicit but it means multiple struct
> > virtio_blk_discard_write_zeroes can be included in a request, up to
> > max_discard_seg.
> >=20
> > I think two things are appropriate:
> > 1. A driver normative statement saying up to
> >    max_discard_seg/max_write_zeroes_seg structs may be included in a
> >    request
> > 2. A general description that says DISCARD/WRITE_ZEROES requests may
> >    have more than 1 "segment" (struct virtio_blk_discard_write_zeroes)
> >=20
> > Does that sound good?
> >=20
> > Stefan
>=20
> Jan could you confirm please? Let's create an issue and close this.

I have sent a new revision of the patches with the clarifications we've
discussed here.

Stefan

--KDt/GgjP6HVcx58l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcb8cIAAoJEJykq7OBq3PIZZIIAKiNrhKtGIwSRbOOXFBKtuO+
oMBMJB3LAE1QZJFj71nBDTNf8nJnKHRRtp5wNkJJGcGB1bey0oAcIR7Kgy6NfNgC
B/qK3ARTBVGFWJtUBjwWqMEpY15eh957n+uXT83rVlbIDZsWdJxNwPJ30yyIjk4d
fiwc7k1yivcGQDCUnegrqeTCdmDgwUFnQuY5soZHCamskRB1gIs56sApMH64nYXP
8PsG5nROl+Dy162DXTesWBpzFhEPVdz2fK3N/xlS6atqwruxj3Dct23/WM0aEecd
j3WXc9+itbYcfiSlUrC/JoqH5Cb5GoB+3u0P8Vh4DwT7BZGGCwUd3Bu/YUgkg5A=
=YBVk
-----END PGP SIGNATURE-----

--KDt/GgjP6HVcx58l--
