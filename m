Return-Path: <viresh.kumar@linaro.org>
Date: Thu, 29 Jul 2021 11:58:36 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] virtio: i2c: Allow buffer less transactions
Message-ID: <20210729062836.yonnjojkccmnu4b7@vireshk-i7>
References: <cd02a45c16631d92d864fbf432bf0b2865b7de12.1627017387.git.viresh.kumar@linaro.org>
 <7c74b6aa-5d1d-8ab1-b4ca-e1f9df8b6605@intel.com>
 <20210729054712.aw76luyq7ajso35v@vireshk-i7>
 <6ea301e0-0420-f17a-c79f-8551fb840ecc@intel.com>
MIME-Version: 1.0
In-Reply-To: <6ea301e0-0420-f17a-c79f-8551fb840ecc@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
To: Jie Deng <jie.deng@intel.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Wolfram Sang <wsa@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jason Wang <jasowang@redhat.com>, Bill Mills <bill.mills@linaro.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, virtio-dev@lists.oasis-open.org, Gerd Hoffmann <kraxel@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 29-07-21, 14:18, Jie Deng wrote:
> The number of descriptors required for a request will not be fixed.

That is true today as well, as we allow 3 (write or read) or 4
(write-read) descriptors.

> If there is a descriptor sequence in the virtqueue, then you may need a
> state machine
>=20
> to parse the sequence. For example, when you have
>=20
>=20
> WR=A0=A0 =A0=A0 RR =A0 =A0=A0=A0=A0 ZR
>=20
> O O I=A0=A0 O I I=A0=A0=A0=A0 O I
>=20
> * WR:(write request), RR (read request), ZR (zero request), O: output
> descriptor, I: input descriptor
>=20
>=20
> When you encounter "O I" combination, you have to read the element after =
it
> to distinguish
>=20
> RR and ZR. Will this bring unnecessary difficulties for the backend codin=
g ?

I understand what you are saying, but at least all the backends that I
have worked with (Qemu and Rust), further categorizes these into
blocks and this is how it looks there (writing in qemu terminology):

VuVirtqElement *elem =3D vu_queue_pop();

elem->in_num and elem_out_num gives the number of out/in buffers
there.

And so there is no way one can get confused between two different
elements and you will always know if it is WR or RR or ZR.

Look at the implementation of vi2c_handle_ctrl() here in one of my
qemu implementations [1].

The same is true for Rust backend.

And so I thought it is evidently clear from virtio standard itself.
Otherwise even with the current specification, how will you know if it
is a WR or RR or WRR (write-read request).

Is my understanding correct ?

--=20
viresh

[1] https://lore.kernel.org/qemu-devel/e0adcd9552cee4de0ee844f6b3c87fb2b2f2=
357c.1617278395.git.viresh.kumar@linaro.org/

