Return-Path: virtio-dev-return-3066-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 4713C58180C6
	for <virtio-dev@lists.oasis-open.org>; Thu, 25 Jan 2018 08:11:02 -0800 (PST)
From: "Liang, Cunming" <cunming.liang@intel.com>
Date: Thu, 25 Jan 2018 16:10:56 +0000
Message-ID: <D0158A423229094DA7ABF71CF2FA0DA34E860786@SHSMSX104.ccr.corp.intel.com>
References: <20180125040328.22867-1-tiwei.bie@intel.com>
 <20180125142220.GD28396@stefanha-x1.localdomain>
In-Reply-To: <20180125142220.GD28396@stefanha-x1.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [virtio-dev] RE: [Qemu-devel] [PATCH v1 0/6] Extend vhost-user to support VFIO
 based accelerators
To: Stefan Hajnoczi <stefanha@gmail.com>, "Bie, Tiwei" <tiwei.bie@intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "mst@redhat.com" <mst@redhat.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "Tan, Jianfeng" <jianfeng.tan@intel.com>, "Wang, Xiao
 W" <xiao.w.wang@intel.com>, "Wang, Zhihong" <zhihong.wang@intel.com>, "Daly,
 Dan" <dan.daly@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>



> -----Original Message-----
> From: Stefan Hajnoczi [mailto:stefanha@gmail.com]
> Sent: Thursday, January 25, 2018 10:22 PM
> To: Bie, Tiwei <tiwei.bie@intel.com>
> Cc: qemu-devel@nongnu.org; virtio-dev@lists.oasis-open.org;=20
> mst@redhat.com; alex.williamson@redhat.com; jasowang@redhat.com;=20
> pbonzini@redhat.com; stefanha@redhat.com; Tan, Jianfeng=20
> <jianfeng.tan@intel.com>; Liang, Cunming <cunming.liang@intel.com>;=20
> Wang, Xiao W <xiao.w.wang@intel.com>; Wang, Zhihong=20
> <zhihong.wang@intel.com>; Daly, Dan <dan.daly@intel.com>
> Subject: Re: [Qemu-devel] [PATCH v1 0/6] Extend vhost-user to support=20
> VFIO based accelerators
>=20
> On Thu, Jan 25, 2018 at 12:03:22PM +0800, Tiwei Bie wrote:
> > Why extend vhost-user for vDPA
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> >
> > We have already implemented various virtual switches (e.g. OVS-DPDK)=20
> > based on vhost-user for VMs in the Cloud. They are purely software=20
> > running on CPU cores. When we have accelerators for such NFVi=20
> > applications, it's ideal if the applications could keep using the=20
> > original interface (i.e. vhost-user netdev) with QEMU, and=20
> > infrastructure is able to decide when and how to switch between CPU=20
> > and
> accelerators within the interface.
> > And the switching (i.e. switch between CPU and accelerators) can be=20
> > done flexibly and quickly inside the applications.
> >
> > More details about this can be found from the Cunming's discussions=20
> > on the RFC patch set.
> >
> > The previous links:
> > RFC:
> > http://lists.nongnu.org/archive/html/qemu-devel/2017-12/msg04844.htm
> > l
>=20
> Is vDPA also useful in the simpler use case where there is no NFVi applic=
ation?
There're separate patches to have non-DPDK vDPA(aka. vhost-vfio, a new vhos=
t backend proposed) support, which is the scope of stage-II as we mentioned=
 in community call.
Stay tuned for the RFC patch. Main idea is that the virtio compatible devic=
e driver register as a mdev to talk with qemu vhost-vfio.=20

>=20
> In other words, you have virtio-net inside the guest and vhost-net on the=
 host.
> You'd like to accelerate the virtio-net NIC using the hardware's vDPA sup=
port.
>=20
> DPDK requires dedicated logical cores and hugepages.  Those resources=20
> will not be used (wasted) if you just want to enable vDPA but have no=20
> DPDK packet processing application.
>=20
> How can this use case be supported without wasting resources?
>=20
> Stefan

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

