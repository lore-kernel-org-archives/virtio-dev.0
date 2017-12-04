Return-Path: virtio-dev-return-2737-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id A12CE5818F4E
	for <virtio-dev@lists.oasis-open.org>; Mon,  4 Dec 2017 15:59:00 -0800 (PST)
From: "Wang, Wei W" <wei.w.wang@intel.com>
Date: Mon, 4 Dec 2017 23:58:55 +0000
Message-ID: <286AC319A985734F985F78AFA26841F7393791A6@shsmsx102.ccr.corp.intel.com>
References: <B84047ECBD981D4B93EAE5A6245AA361013EF401@FRAEML521-MBX.china.huawei.com>
 <20171025012316-mutt-send-email-mst@kernel.org> <59EFDF4F.8050708@intel.com>
 <B84047ECBD981D4B93EAE5A6245AA361013EF47B@FRAEML521-MBX.china.huawei.com>
 <59F079E5.5000705@intel.com>
 <B84047ECBD981D4B93EAE5A6245AA36101592F70@FRAEML521-MBX.china.huawei.com>
In-Reply-To: <B84047ECBD981D4B93EAE5A6245AA36101592F70@FRAEML521-MBX.china.huawei.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: RE: [virtio-dev] vhost-user to interconnect vm's
To: "Avi Cohen (A)" <avi.cohen@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Ofer Ben-Yacov <ofer.benyacov@toganetworks.com>, "Yang, Zhiyong" <zhiyong.yang@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Monday, December 4, 2017 9:38 PM, Avi Cohen (A) wrote:
>=20
> Hi Wei,
> Regarding the kernel (not dpdk) mode:
> V1:
> I understand that these (v1) patches should be installed in the guest ker=
nel.
> I don't understand what is the status of the qemu patch for v1 ? where ca=
n I
> find it ?
>=20
> V2:
> Currently there is no QEMU support - correct ?
> Best Regards
> Avi
>=20
> > -----Original Message-----
> > From: Wei Wang [mailto:wei.w.wang@intel.com]
> > Sent: Wednesday, 25 October, 2017 2:48 PM
> > To: Avi Cohen (A); Michael S. Tsirkin
> > Cc: virtio-dev@lists.oasis-open.org; Ofer Ben-Yacov;
> > zhiyong.yang@intel.com
> > Subject: Re: [virtio-dev] vhost-user to interconnect vm's
> >
> > On 10/25/2017 03:34 PM, Avi Cohen (A) wrote:
> > > Thank you Michael and Wei
> > > What is the estimated time for kernel-driver implementation ?
> > > Best Regards
> > > Avi
> > >
> >
> > We have some initial draft kernel driver code for the old design:
> > driver: https://github.com/wei-w-wang/vhost-pci-driver
> > device: https://github.com/wei-w-wang/vhost-pci-device

Hi Avi,

The above links are actually v2 QEMU and the draft guest kernel driver.=20

Best,
Wei

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

