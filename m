Return-Path: virtio-dev-return-2626-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 6645258191BD
	for <virtio-dev@lists.oasis-open.org>; Wed, 25 Oct 2017 00:35:10 -0700 (PDT)
From: "Avi Cohen (A)" <avi.cohen@huawei.com>
Date: Wed, 25 Oct 2017 07:34:53 +0000
Message-ID: <B84047ECBD981D4B93EAE5A6245AA361013EF47B@FRAEML521-MBX.china.huawei.com>
References: <B84047ECBD981D4B93EAE5A6245AA361013EF401@FRAEML521-MBX.china.huawei.com>
 <20171025012316-mutt-send-email-mst@kernel.org> <59EFDF4F.8050708@intel.com>
In-Reply-To: <59EFDF4F.8050708@intel.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: RE: [virtio-dev] vhost-user to interconnect vm's
To: Wei Wang <wei.w.wang@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Ofer Ben-Yacov <ofer.benyacov@toganetworks.com>, "zhiyong.yang@intel.com" <zhiyong.yang@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Thank you Michael and Wei
What is the estimated time for kernel-driver implementation ?
Best Regards
Avi

> -----Original Message-----
> From: Wei Wang [mailto:wei.w.wang@intel.com]
> Sent: Wednesday, 25 October, 2017 3:48 AM
> To: Michael S. Tsirkin; Avi Cohen (A)
> Cc: virtio-dev@lists.oasis-open.org; Ofer Ben-Yacov; zhiyong.yang@intel.c=
om
> Subject: Re: [virtio-dev] vhost-user to interconnect vm's
>=20
> On 10/25/2017 06:25 AM, Michael S. Tsirkin wrote:
> > On Tue, Oct 24, 2017 at 02:07:21PM +0000, Avi Cohen (A) wrote:
> >> Hello,
> >> I wonder if it is possible to directly connect 2  VM's (without host
> intervention) with  vhost-user interface , so one VM is slave and the 2nd=
  is the
> master.
> >> I can connect the VM's with OVS-DPDK (or VPP)  in the middle - but thi=
s
> requires an extra copy.
> >> Best Regards
> >> Avi
> >
> > This is the vhost-pci set of patches. They are not upstream yet - last
> > version - v2 - was posted back in May. Cc Wei Wang for an update on
> > the status. It would be great if you could try them out.
>=20
>=20
> We have started to implement the DPDK PMD of vhost-pci, since it is simpl=
er
> and has better performance than the kernel driver.
>=20
> We are also trying to make a simpler QEMU implementation than v2, for
> example, the vhost-pci device will be statically set up via qemu command =
line,
> instead of being hot-plugged on demand.
>=20
> We would be able to send out the new version in a month or two.
>=20
> Best,
> Wei

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

