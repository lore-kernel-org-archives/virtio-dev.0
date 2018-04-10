Return-Path: virtio-dev-return-3782-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id DD3ED58191FF
	for <virtio-dev@lists.oasis-open.org>; Tue, 10 Apr 2018 07:24:06 -0700 (PDT)
From: "Liang, Cunming" <cunming.liang@intel.com>
Date: Tue, 10 Apr 2018 14:23:52 +0000
Message-ID: <D0158A423229094DA7ABF71CF2FA0DA34E9226AF@SHSMSX104.ccr.corp.intel.com>
References: <20180402152330.4158-1-tiwei.bie@intel.com>
 <622f4bd7-1249-5545-dc5a-5a92b64f5c26@redhat.com>
 <20180410045723.rftsb7l4l3ip2ioi@debian>
 <7ee31a12-a370-fc43-82a6-2235f598e970@redhat.com>
 <D0158A423229094DA7ABF71CF2FA0DA34E9222F4@SHSMSX104.ccr.corp.intel.com>
 <20180410163105-mutt-send-email-mst@kernel.org>
In-Reply-To: <20180410163105-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: RE: [virtio-dev] Re: [RFC] vhost: introduce mdev based hardware
 vhost backend
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Bie, Tiwei" <tiwei.bie@intel.com>, Jason Wang <jasowang@redhat.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "ddutile@redhat.com" <ddutile@redhat.com>, "Duyck, Alexander H" <alexander.h.duyck@intel.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Daly, Dan" <dan.daly@intel.com>, "Wang, Zhihong" <zhihong.wang@intel.com>, "Tan, Jianfeng" <jianfeng.tan@intel.com>, "Wang,
 Xiao W" <xiao.w.wang@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>



> -----Original Message-----
> From: Michael S. Tsirkin [mailto:mst@redhat.com]
> Sent: Tuesday, April 10, 2018 9:36 PM
> To: Liang, Cunming <cunming.liang@intel.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>; Bie, Tiwei <tiwei.bie@intel.com>=
;
> Jason Wang <jasowang@redhat.com>; alex.williamson@redhat.com;
> ddutile@redhat.com; Duyck, Alexander H <alexander.h.duyck@intel.com>;
> virtio-dev@lists.oasis-open.org; linux-kernel@vger.kernel.org;
> kvm@vger.kernel.org; virtualization@lists.linux-foundation.org;
> netdev@vger.kernel.org; Daly, Dan <dan.daly@intel.com>; Wang, Zhihong
> <zhihong.wang@intel.com>; Tan, Jianfeng <jianfeng.tan@intel.com>; Wang, X=
iao
> W <xiao.w.wang@intel.com>
> Subject: Re: [virtio-dev] Re: [RFC] vhost: introduce mdev based hardware =
vhost
> backend
>=20
> On Tue, Apr 10, 2018 at 09:23:53AM +0000, Liang, Cunming wrote:
> >
> >
> > > -----Original Message-----
> > > From: Paolo Bonzini [mailto:pbonzini@redhat.com]
> > > Sent: Tuesday, April 10, 2018 3:52 PM
> > > To: Bie, Tiwei <tiwei.bie@intel.com>; Jason Wang
> > > <jasowang@redhat.com>
> > > Cc: mst@redhat.com; alex.williamson@redhat.com; ddutile@redhat.com;
> > > Duyck, Alexander H <alexander.h.duyck@intel.com>;
> > > virtio-dev@lists.oasis- open.org; linux-kernel@vger.kernel.org;
> > > kvm@vger.kernel.org; virtualization@lists.linux-foundation.org;
> > > netdev@vger.kernel.org; Daly, Dan <dan.daly@intel.com>; Liang,
> > > Cunming <cunming.liang@intel.com>; Wang, Zhihong
> > > <zhihong.wang@intel.com>; Tan, Jianfeng <jianfeng.tan@intel.com>;
> > > Wang, Xiao W <xiao.w.wang@intel.com>
> > > Subject: Re: [virtio-dev] Re: [RFC] vhost: introduce mdev based
> > > hardware vhost backend
> > >
> > > On 10/04/2018 06:57, Tiwei Bie wrote:
> > > >> So you just move the abstraction layer from qemu to kernel, and
> > > >> you still need different drivers in kernel for different device
> > > >> interfaces of accelerators. This looks even more complex than
> > > >> leaving it in qemu. As you said, another idea is to implement
> > > >> userspace vhost backend for accelerators which seems easier and
> > > >> could co-work with other parts of qemu without inventing new type =
of
> messages.
> > > >
> > > > I'm not quite sure. Do you think it's acceptable to add various
> > > > vendor specific hardware drivers in QEMU?
> > >
> > > I think so.  We have vendor-specific quirks, and at some point there
> > > was an idea of using quirks to implement (vendor-specific) live
> > > migration support for assigned devices.
> >
> > Vendor-specific quirks of accessing VGA is a small portion. Other major=
 portions
> are still handled by guest driver.
> >
> > While in this case, when saying various vendor specific drivers in QEMU=
, it says
> QEMU takes over and provides the entire user space device drivers. Some p=
arts
> are even not relevant to vhost, they're basic device function enabling. M=
oreover,
> it could be different kinds of devices(network/block/...) under vhost. No=
 matter
> # of vendors or # of types, total LOC is not small.
> >
> > The idea is to avoid introducing these extra complexity out of QEMU, ke=
eping
> vhost adapter simple. As vhost protocol is de factor standard, it leverag=
es kernel
> device driver to provide the diversity. Changing once in QEMU, then it su=
pports
> multi-vendor devices whose drivers naturally providing kernel driver ther=
e.
> >
> > If QEMU is going to build a user space driver framework there, we're op=
en mind
> on that, even leveraging DPDK as the underlay library. Looking forward to=
 more
> others' comments from community.
> >
> > Steve
>=20
> Dependency on a kernel driver is fine IMHO. It's the dependency on a DPDK
> backend that makes people unhappy, since the functionality in question is=
 setup-
> time only.

Agreed, we don't see dependency on kernel driver is a problem.

mdev based vhost backend (this patch set) is independent with vhost-user ex=
tension patch set. In fact, there're a few vhost-user providers, DPDK librt=
e_vhost is one of them. FD.IO/VPP and snabbswitch have their own vhost-user=
 providers. So I can't agree on vhost-user extension patch depends on DPDK =
backend. But anyway, that's the topic of another mail thread.

>=20
> As others said, we do not need to go overeboard. A couple of small vendor=
-
> specific quirks in qemu isn't a big deal.

It's quite challenge to identify it's small or not, there's no uniform metr=
ic.

It's only dependent on QEMU itself, that's the obvious benefit. Tradeoff is=
 to build the entire device driver. We don't object to do that in QEMU, but=
 wanna make sure to understand the boundary size clearly.

>=20
> > >
> > > Paolo

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

