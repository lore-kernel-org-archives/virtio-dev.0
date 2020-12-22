Return-Path: virtio-comment-return-1583-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Tue, 22 Dec 2020 12:29:09 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20201222122909.3168620a.cohuck@redhat.com>
In-Reply-To: <20b91229-e938-66fb-464b-c85c1dbcde96@intel.com>
References: <1ea117ebe46d105eda21544acf85a5c7dbe2d8ec.1606283457.git.jie.deng@intel.com>
	<20201216155218.GA720702@stefanha-x1.localdomain>
	<b59c78ee-1f25-e32b-fc22-697b92084ae0@intel.com>
	<20201217030015-mutt-send-email-mst@kernel.org>
	<20201217102640.GG4338@stefanha-x1.localdomain>
	<1ccc5889-4e28-deac-8168-c6f0665231c1@intel.com>
	<20201218155526-mutt-send-email-mst@kernel.org>
	<20b91229-e938-66fb-464b-c85c1dbcde96@intel.com>
MIME-Version: 1.0
Subject: Re: [virtio-comment] [PATCH v5] virtio-i2c: add the device
 specification
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Jie Deng <jie.deng@intel.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, kraxel@redhat.com, wsa+renesas@sang-engineering.com, andriy.shevchenko@linux.intel.com, conghui.chen@intel.com, yu1.wang@intel.com, shuo.a.liu@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, 22 Dec 2020 14:11:24 +0800
Jie Deng <jie.deng@intel.com> wrote:

> On 2020/12/20 3:05, Michael S. Tsirkin wrote:
> > On Fri, Dec 18, 2020 at 10:06:45AM +0800, Jie Deng wrote: =20
> >> On 2020/12/17 18:26, Stefan Hajnoczi wrote: =20
> >>> On Thu, Dec 17, 2020 at 03:00:55AM -0500, Michael S. Tsirkin wrote: =
=20
> >>>> On Thu, Dec 17, 2020 at 03:08:07PM +0800, Jie Deng wrote: =20
> >>>>>           +The \field{flags} of the request is currently reserved a=
s zero for future
> >>>>>           +feature extensibility.
> >>>>>           +
> >>>>>           +The \field{written} of the request is the number of data=
 bytes in the \field{write_buf}
> >>>>>           +being written to the I2C slave address.
> >>>>>
> >>>>>       This field seems redundant since the device can determine the=
 size of
> >>>>>       write_buf implicitly from the total out buffer size. virtio-b=
lk takes
> >>>>>       this approach.
> >>>>>
> >>>>> The read/write are the actual number of data bytes being read from =
or written
> >>>>> to the device
> >>>>> which is not determined by the device. So I don't think it is redun=
dant. =20
> >>>> I am still not sure I understand the difference.
> >>>> This point is unclear to multiple people. =20
> >>> I think I get it now. This is made clear by splitting the struct:
> >>>
> >>>     /* Driver->device fields */
> >>>     struct virtio_i2c_out_hdr
> >>>     {
> >>>         le16 addr;
> >>>         le16 padding;
> >>>         le32 flags;
> >>>     };
> >>>
> >>>     /* Device->driver fields */
> >>>     struct virtio_i2c_in_hdr
> >>>     {
> >>>         le16 written;
> >>>         le16 read;
> >>>         u8 status;
> >>>     }; =20
> >> written/read are not device->driver fields. They are driver->device fi=
elds.
> >> They are not determined by the device but the driver(user).
> >>
> >> However, Michael said that the two fields may duplicate buf size avail=
able
> >> in the descriptor. He intended to remove them.
> >>
> >> "
> >> I note that read and written actually duplicate buf size
> >> available in the descriptor.
> >> Given we no longer mirror i2c_msg 1:1 do we still want to do this?
> >> It will be trivial for the host device to populate these fields
> >> correctly for linux.
> >> Duplication of information iten leads to errors ...
> >> "
> >>
> >> But there is a corner case I'm not sure if you have noticed.
> >>
> >> read and written can be 0. I think we may not put a buf with size 0 in=
to the
> >> virtqueue. =20
> > You always have the header and the status, right?
> > E.g. with the below, the total buffer size is virtio_i2c_out_hdr size +
> > write size for writes and read size + virtio_i2c_in_hdr size for reads.
> > Neither result is ever 0. =20
>=20
> Then how to distinguish the request type the buffer contains.

I have read through the thread and I remain confused.

>=20
> Each type will have both virtio_i2c_out_hdr and virtio_i2c_in_hdr.
> the backend can know the type by checking the read/written.
>=20
> If the read=3D0 and the written>0, the request is a write request
> The buffer may contains 3 scatterlist:
>=20
> virtio_i2c_out_hdr // scatterlist[0]

So, what does virtio_i2c_{out,in}_hdr contain here? If it is the one from
above, ...

>=20
>  =C2=A0=C2=A0=C2=A0 buf[/* this is write data, since read =3D 0 */] // sc=
atterlist[1]
>=20
>  =C2=A0=C2=A0=C2=A0 virtio_i2c_in_hdr // scatterlist[2]

...we do not know whether there's read data, write data, or what their
length is, until we've actually consumed the whole buffer, and then we
have to go backwards.

>=20
> If the read>0 and the written=3D0, the request is a read request.
> The buffer may contains 3 scatterlist:
>=20
> virtio_i2c_out_hdr // scatterlist[0]
>=20
>  =C2=A0=C2=A0=C2=A0 buf[/* This is read data, since written =3D 0 */] // =
scatterlist[1]
>=20
>  =C2=A0=C2=A0=C2=A0 virtio_i2c_in_hdr // scatterlist[2]
>=20
> If the read>0 and the written>0, the request is a write-read request.
> The buffer may contains 4 scatterlist:
>=20
> virtio_i2c_out_hdr=C2=A0=C2=A0 // scatterlist[0]
>=20
>  =C2=A0=C2=A0=C2=A0 buf[/*write data*/]=C2=A0 // scatterlist[1]
>=20
>  =C2=A0=C2=A0=C2=A0 buf[/*read data*/] // scatterlist[2]
>=20
>  =C2=A0=C2=A0=C2=A0 virtio_i2c_in_hdr // scatterlist[3]

Is there any reason why we need to infer the type of the request by
checking some lengths? Can't we just specify explicit flags for read
and write? What am I missing?

>=20
> >> @Stefan @Paolo
> >>
> >> So what's your opinion about these two fields ?
> >> =20
> >>>     /*
> >>>      * Virtqueue element layout looks like this:
> >>>      *
> >>>      * struct virtio_i2c_out_hdr out_hdr; /* OUT */
> >>>      * u8 write_buf[]; /* OUT */
> >>>      * u8 read_buf[]; /* IN */
> >>>      * struct virtio_i2c_in_hdr in_hdr; /* IN */
> >>>      */
> >>>
> >>> This makes sense to me: a bi-directional request has both write_buf[]
> >>> and read_buf[] so the vring used.len field is not enough to report ba=
ck
> >>> how many bytes were written and read. The virtio_i2c_in_hdr fields ar=
e
> >>> really needed.
> >>>
> >>> Please split the struct in the spec so it's clear how this works. =20


This publicly archived list offers a means to provide input to the=0D
OASIS Virtual I/O Device (VIRTIO) TC.=0D
=0D
In order to verify user consent to the Feedback License terms and=0D
to minimize spam in the list archive, subscription is required=0D
before posting.=0D
=0D
Subscribe: virtio-comment-subscribe@lists.oasis-open.org=0D
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org=0D
List help: virtio-comment-help@lists.oasis-open.org=0D
List archive: https://lists.oasis-open.org/archives/virtio-comment/=0D
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf=
=0D
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lis=
ts=0D
Committee: https://www.oasis-open.org/committees/virtio/=0D
Join OASIS: https://www.oasis-open.org/join/

