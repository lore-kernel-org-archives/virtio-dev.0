Return-Path: virtio-comment-return-1559-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Thu, 17 Dec 2020 08:56:39 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20201217085639.53c281a9.cohuck@redhat.com>
In-Reply-To: <efe4a6a1-87f1-9712-fc87-6ee17edff6ae@intel.com>
References: <1ea117ebe46d105eda21544acf85a5c7dbe2d8ec.1606283457.git.jie.deng@intel.com>
	<20201216183859.1e7b206a.cohuck@redhat.com>
	<efe4a6a1-87f1-9712-fc87-6ee17edff6ae@intel.com>
MIME-Version: 1.0
Subject: Re: [virtio-comment] [PATCH v5] virtio-i2c: add the device
 specification
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Jie Deng <jie.deng@intel.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, pbonzini@redhat.com, kraxel@redhat.com, wsa+renesas@sang-engineering.com, andriy.shevchenko@linux.intel.com, conghui.chen@intel.com, yu1.wang@intel.com, shuo.a.liu@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, 17 Dec 2020 15:29:57 +0800
Jie Deng <jie.deng@intel.com> wrote:

> Thank you. I will fix them.
>=20
> On 2020/12/17 1:38, Cornelia Huck wrote:
> > On Wed, 25 Nov 2020 13:55:18 +0800
> > Jie Deng <jie.deng@intel.com> wrote:
> >
> > <some mostly editorial comments; sorry about bringing this up now>
> > =20
> >> +
> >> +A driver MUST place one segment of an I2C transaction into \field{wri=
te_buf} if the
> >>
> >> s/if the/if/
> >>
> >> +
> >> +A device MUST place one segment of an I2C transaction into \field{rea=
d_buf} if the =20
> > s/if/if the/ =20
>=20
> Do you mean=C2=A0 "s/if the/if/" here ?

Yes.

>=20
> >
> > irst failed one to be VIRTIO_I2C_MSG_ERR. =20
>=20


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

