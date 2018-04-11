Return-Path: virtio-dev-return-3804-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id A7E4E581806F
	for <virtio-dev@lists.oasis-open.org>; Tue, 10 Apr 2018 18:38:34 -0700 (PDT)
From: "Tian, Kevin" <kevin.tian@intel.com>
Date: Wed, 11 Apr 2018 01:38:29 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D1910E3505@SHSMSX101.ccr.corp.intel.com>
References: <20180402152330.4158-1-tiwei.bie@intel.com>
	<622f4bd7-1249-5545-dc5a-5a92b64f5c26@redhat.com>
	<20180410045723.rftsb7l4l3ip2ioi@debian>
	<7ee31a12-a370-fc43-82a6-2235f598e970@redhat.com>
	<D0158A423229094DA7ABF71CF2FA0DA34E9222F4@SHSMSX104.ccr.corp.intel.com>
	<20180410163105-mutt-send-email-mst@kernel.org>
 <D0158A423229094DA7ABF71CF2FA0DA34E9226AF@SHSMSX104.ccr.corp.intel.com>
In-Reply-To: <D0158A423229094DA7ABF71CF2FA0DA34E9226AF@SHSMSX104.ccr.corp.intel.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: RE: [virtio-dev] Re: [RFC] vhost: introduce mdev based hardware
	vhost backend
To: "Liang, Cunming" <cunming.liang@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Duyck, Alexander H" <alexander.h.duyck@intel.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "Wang, Xiao W" <xiao.w.wang@intel.com>, "ddutile@redhat.com" <ddutile@redhat.com>, "Tan,
 Jianfeng" <jianfeng.tan@intel.com>, "Wang, Zhihong" <zhihong.wang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

> From: Liang, Cunming
> Sent: Tuesday, April 10, 2018 10:24 PM
>=20
[...]
> >
> > As others said, we do not need to go overeboard. A couple of small
> vendor-
> > specific quirks in qemu isn't a big deal.
>=20
> It's quite challenge to identify it's small or not, there's no uniform me=
tric.
>=20
> It's only dependent on QEMU itself, that's the obvious benefit. Tradeoff =
is
> to build the entire device driver. We don't object to do that in QEMU, bu=
t
> wanna make sure to understand the boundary size clearly.
>=20

It might be helpful if you can post some sample code using proposed=20
framework - then people have a clear feeling about what size is talked=20
about here and whether it falls into the concept of 'small quirks'.

Thanks
Kevin

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

