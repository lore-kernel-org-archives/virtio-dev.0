Return-Path: virtio-dev-return-2617-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id B4DF9581900C
	for <virtio-dev@lists.oasis-open.org>; Thu, 19 Oct 2017 05:33:33 -0700 (PDT)
Date: Thu, 19 Oct 2017 14:33:25 +0200
From: =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>
Message-ID: <20171019143325.12b6b8aa@fiorina>
In-Reply-To: <20171005155118.51a5bea3@fiorina>
References: <cover.1505998455.git.tgolembi@redhat.com>
	<20171005155118.51a5bea3@fiorina>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [PATCH v2 0/1] linux: Buffers/caches in VirtIO Balloon driver
 stats
To: linux-mm@kvack.org, virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org, kvm@vger.kernel.org, virtio-dev@lists.oasis-open.org
Cc: Wei Wang <wei.w.wang@intel.com>, Shaohua Li <shli@fb.com>, Huang Ying <ying.huang@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, 5 Oct 2017 15:51:18 +0200
Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com> wrote:

> On Thu, 21 Sep 2017 14:55:40 +0200
> Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com> wrote:
>=20
> > Linux driver part
> >=20
> > v2:
> > - fixed typos
> >=20
> > Tom=C3=A1=C5=A1 Golembiovsk=C3=BD (1):
> >   virtio_balloon: include buffers and cached memory statistics
> >=20
> >  drivers/virtio/virtio_balloon.c     | 11 +++++++++++
> >  include/uapi/linux/virtio_balloon.h |  4 +++-
> >  mm/swap_state.c                     |  1 +
> >  3 files changed, 15 insertions(+), 1 deletion(-)
> >=20
> > --=20
> > 2.14.1
> >=20
>=20
> ping

ping

--=20
Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

