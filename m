Return-Path: virtio-dev-return-7112-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1A7F8986077
	for <virtio-dev@lists.oasis-open.org>; Fri, 17 Apr 2020 09:41:36 +0000 (UTC)
Date: Fri, 17 Apr 2020 10:41:22 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20200417094122.GB9261@stefanha-x1.localdomain>
References: <CAD90VcYAXhRdBhLtuj9wETyTd0kT-o5s6DE31DxN6KENBuDKgQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAD90VcYAXhRdBhLtuj9wETyTd0kT-o5s6DE31DxN6KENBuDKgQ@mail.gmail.com>
Subject: Re: [virtio-dev] Preferred layout for request/response structs
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TRYliJ5NKNqkz5bu"
Content-Disposition: inline
To: Keiichi Watanabe <keiichiw@chromium.org>
Cc: virtio-dev@lists.oasis-open.org, Alexandre Courbot <acourbot@chromium.org>, Tomasz Figa <tfiga@chromium.org>, Pawel Osciak <posciak@chromium.org>, Alex Lau <alexlau@chromium.org>, David Stevens <stevensd@chromium.org>, Enrico Granata <egranata@google.com>, Dmitry Sepp <dmitry.sepp@opensynergy.com>, Gerd Hoffmann <kraxel@redhat.com>, Chirantan Ekbote <chirantan@chromium.org>, Matti =?iso-8859-1?Q?M=F6ll?= <matti.moell@opensynergy.com>, Samiullah Khawaja <samiullah.khawaja@opensynergy.com>, Kiran Pawar <kiran.pawar@opensynergy.com>, Lingfeng Yang <lfy@google.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--TRYliJ5NKNqkz5bu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16, 2020 at 08:58:46PM +0900, Keiichi Watanabe wrote:
> Hi, I'm designing virtio-video protocol [1] and thinking about its
> structs' layouts.
> The virtio-video protocol adopts the request-response model like
> virtio-gpu and virtio-fs. While I looked at these two protocols, I
> found they used different designs of having request headers.
> So, I=E2=80=99m wondering what=E2=80=99s the best way of having the reque=
st / response
> header for virtio-video.
>=20
> On the one hand, virtio-gpu's structs for each control and response
> contain the virtio_gpu_ctrl_hdr as one of fields:
> struct virtio_gpu_get_edid {
>   struct virtio_gpu_ctrl_hdr hdr;
>   ...
> };
> struct virtio_gpu_resp_edid {
>   struct virtio_gpu_ctrl_hdr hdr;
>   ...
> };
>=20
> On the other hand, virtio-fs separates its header struct and request
> body like the FUSE protocol:
> struct fuse_in_header in;
> union {
>   struct fuse_read_in readin;
>   ...
> };
>=20
> When we define a new protocol, which layout is preferred? I'd
> especially like to know why virtio-gpu decided to use this design and
> if the design is nice.

Here are my personal thoughts about request/response struct design:

Make the request/response is a single entity if possible because it's
simpler.  This works for devices where the driver places a
request/response onto the virtqueue as a single element and the device
completes it.

Devices that have rx/tx virtqueue designs work differently, and the
response will need to have fields that can be used to correlate the
response with the request that it is related to.

If the software processing of the request/response is inherently
separate (e.g. the device is a transport for an existing protocol that
has separate request/response messages), then it also makes sense to
include extra header fields in the response - even if the driver places
a single element into the virtqueue and you don't have an rx/tx
virtqueue design.

Regarding whether to specify a single C struct with a union for all
request types, or whether to specify separate top-level C structs like
virtio-gpu, it depends.  If there would be a lot of duplication then I
think the single struct with a union approach is good.  If there is a
lot of variation then defining separate top-level structs is cleaner
because there's not much to share.

> In the latest proposal of the virtio-video [1], we chose the same
> design as virtio-gpu like:
> struct virtio_video_resource_queue {
>   struct virtio_video_cmd_hdr hdr;
>   ...
> };
> struct virtio_video_resource_queue_resp {
>   struct virtio_video_cmd_hdr hdr;

Are these hdr fields actually used by the driver when the request is
completed?

If your request/response is a single virtqueue element then there is no
need to duplicate hdr into the response because the driver already has
the request.

Response headers are usually only necessary in rx/tx virtqueue designs
where the driver needs to correlate a response on the rx queue with a
request that was sent on the tx queue.

>   ...
> };
> However, I thought it's a bit inconvenient that we cannot know the
> actual size of a struct before its header. Actually, our device
> implementation reads the header first to know the size and then reads
> the whole struct including the header.

In the device implementation I would read a struct virtio_video_cmd_hdr
from the out iov list first.  Then either read the request-specific
struct (defined separately) or use (uint8_t *)req + offsetof(struct
virtio_video_resource_queue, field_after_hdr) to read the remainder but
it's ugly.

> If it doesn=E2=80=99t make any sense to follow the virtio-gpu=E2=80=99s h=
eader design,
> I=E2=80=99d like to separate the header and the command bodies and make t=
he
> driver send two structs per command:
> struct virtio_video_cmd_hdr hdr; // contains what command follows
> struct virtio_video_resource_queue {
>     ...
> };
> struct virtio_video_resource_queue_resp {
>   ...
> };

Yes, this is cleaner for the device emulation code.  The driver doesn't
need this separation.

Remember that the struct definitions in the VIRTIO specification are
pseudo-C and not necessarily the exact struct definitions that drivers
and device implementations have to use.  As long as you follow the data
layout correctly as per the spec you can arrange your structs any way
you want.

Stefan

--TRYliJ5NKNqkz5bu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6ZecIACgkQnKSrs4Gr
c8jPIwgAuTN31VgGh9/S13lqrKqiuAqvM/tlfSavnAhJCnoDhn2jnKptw7Itxitc
QkGolIBsgghiN6zQN2w5AtdiJL496I8hXOKdNd4O/CJSNjchtIwDb5FnIlYfEsis
KHYupmUTeinp59hT0c4ARguCG74sujCEaA65mgyukmCOCvMt/6xCaF97oXL+qwVU
40jUmKIP6/d+wmNCl3Weox6uh4gttZ7d13MNXZLLfgGNUBB6+zG5tqQ93fIb0X+1
EH3PHkNHqQ2K8XTxmTCIDpTqvceXtmmeaeikQ/JPns632tFHK5CsuxX0n47qen3c
8zL7E58omgOdU2MuxgX0UCWIKACw+g==
=GnJl
-----END PGP SIGNATURE-----

--TRYliJ5NKNqkz5bu--

