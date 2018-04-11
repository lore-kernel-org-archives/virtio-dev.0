Return-Path: virtio-dev-return-3805-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id B5712581806F
	for <virtio-dev@lists.oasis-open.org>; Tue, 10 Apr 2018 19:02:06 -0700 (PDT)
Date: Wed, 11 Apr 2018 10:01:50 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180411020150.GE28698@stefanha-x1.localdomain>
References: <20180402152330.4158-1-tiwei.bie@intel.com>
 <622f4bd7-1249-5545-dc5a-5a92b64f5c26@redhat.com>
 <20180410045723.rftsb7l4l3ip2ioi@debian>
 <7ee31a12-a370-fc43-82a6-2235f598e970@redhat.com>
 <D0158A423229094DA7ABF71CF2FA0DA34E9222F4@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="so9zsI5B81VjUb/o"
Content-Disposition: inline
In-Reply-To: <D0158A423229094DA7ABF71CF2FA0DA34E9222F4@SHSMSX104.ccr.corp.intel.com>
Subject: Re: [virtio-dev] Re: [RFC] vhost: introduce mdev based hardware
 vhost backend
To: "Liang, Cunming" <cunming.liang@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Bie, Tiwei" <tiwei.bie@intel.com>, Jason Wang <jasowang@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "ddutile@redhat.com" <ddutile@redhat.com>, "Duyck, Alexander H" <alexander.h.duyck@intel.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Daly, Dan" <dan.daly@intel.com>, "Wang, Zhihong" <zhihong.wang@intel.com>, "Tan, Jianfeng" <jianfeng.tan@intel.com>, "Wang, Xiao W" <xiao.w.wang@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--so9zsI5B81VjUb/o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 10, 2018 at 09:23:53AM +0000, Liang, Cunming wrote:
> If QEMU is going to build a user space driver framework there, we're open mind on that, even leveraging DPDK as the underlay library. Looking forward to more others' comments from community.

There is already an NVMe VFIO driver in QEMU (see block/nvme.c).  So in
principle there's no reason against userspace drivers in QEMU.

Stefan

--so9zsI5B81VjUb/o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJazWyOAAoJEJykq7OBq3PIDxYH/3SjcypJKNjR0hMj21VW4REg
7F6RjwFFlXz5fjIdUTi3sW80T3eWF26MbWBttl1A6XwrWQPrx50iG9xhblCNwLtu
KY8vkQVK89LYwpM1vQn3LH7liEWexUIvq+dksxDts+7XE52qXxJ3hhzhb29ajTFf
aWh4HdJXZyh3243o8tyvUELsSQ/P5mxy6HHt2pggoPViO3ttfjYC/fnkd2Q11tZn
JxPIkqC4OkJW3EBva5V2/dCu0hWC8Gcj69Hda6eMrev4FzkHpFDROrb3CqtWKDEw
ngHk+06CpZF77C73b8OKf8/+yWUXwXc38OVjoX6B3FS/x7a+mW2DZNb/m8NRDXg=
=ueJP
-----END PGP SIGNATURE-----

--so9zsI5B81VjUb/o--
