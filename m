Return-Path: virtio-dev-return-4810-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3FD00985EA8
	for <virtio-dev@lists.oasis-open.org>; Tue, 28 Aug 2018 12:54:59 +0000 (UTC)
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Tue, 28 Aug 2018 12:54:43 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DB0B50DC@dggeml511-mbx.china.huawei.com>
References: <1535071416-212072-1-git-send-email-longpeng2@huawei.com>
 <5B7F5688.5080007@huawei.com>
 <20180824142118-mutt-send-email-mst@kernel.org>
 <33183CC9F5247A488A2544077AF19020DB0A1B5B@dggeml531-mbs.china.huawei.com>
 <20180824155408-mutt-send-email-mst@kernel.org>
 <33183CC9F5247A488A2544077AF19020DB0B44A6@dggeml511-mbx.china.huawei.com>
 <20180828080646-mutt-send-email-mst@kernel.org>
In-Reply-To: <20180828080646-mutt-send-email-mst@kernel.org>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: RE: [virtio-dev] Re: [PATCH v25 0/2] virtio-crypto: virtio crypto
 device specification
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: longpeng <longpeng2@huawei.com>, "xin.zeng@intel.com" <xin.zeng@intel.com>, "pasic@linux.vnet.ibm.com" <pasic@linux.vnet.ibm.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "denglingli@chinamobile.com" <denglingli@chinamobile.com>, Jani Kokkonen <Jani.Kokkonen@huawei.com>, "Ola.Liljedahl@arm.com" <Ola.Liljedahl@arm.com>, "brian.a.keating@intel.com" <brian.a.keating@intel.com>, "liang.j.ma@intel.com" <liang.j.ma@intel.com>, "john.griffin@intel.com" <john.griffin@intel.com>, "agraf@suse.de" <agraf@suse.de>, "jasowang@redhat.com" <jasowang@redhat.com>, "vincent.jardin@6wind.com" <vincent.jardin@6wind.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, "Zhoujian (jay)" <jianjay.zhou@huawei.com>
List-ID: <virtio-dev.lists.oasis-open.org>

>=20
> On Tue, Aug 28, 2018 at 03:31:02AM +0000, Gonglei (Arei) wrote:
> >
> > > -----Original Message-----
> > > From: Michael S. Tsirkin [mailto:mst@redhat.com]
> > > Sent: Friday, August 24, 2018 8:54 PM
> > >
> > > On Fri, Aug 24, 2018 at 12:07:44PM +0000, Gonglei (Arei) wrote:
> > > > Hi Michael,
> > > >
> > > > > -----Original Message-----
> > > > > From: virtio-dev@lists.oasis-open.org
> > > [mailto:virtio-dev@lists.oasis-open.org]
> > > > > On Behalf Of Michael S. Tsirkin
> > > > > Sent: Friday, August 24, 2018 7:23 PM
> > > > > To: longpeng <longpeng2@huawei.com>
> > > > > Cc: xin.zeng@intel.com; Gonglei (Arei) <arei.gonglei@huawei.com>;
> > > > > pasic@linux.vnet.ibm.com; qemu-devel@nongnu.org;
> > > > > virtio-dev@lists.oasis-open.org; cohuck@redhat.com;
> > > stefanha@redhat.com;
> > > > > denglingli@chinamobile.com; Jani Kokkonen
> > > <Jani.Kokkonen@huawei.com>;
> > > > > Ola.Liljedahl@arm.com; Varun.Sethi@freescale.com;
> > > > > brian.a.keating@intel.com; liang.j.ma@intel.com;
> john.griffin@intel.com;
> > > > > agraf@suse.de; jasowang@redhat.com; vincent.jardin@6wind.com;
> > > > > Huangweidong (C) <weidong.huang@huawei.com>; wangxin (U)
> > > > > <wangxinxin.wang@huawei.com>; Zhoujian (jay)
> > > <jianjay.zhou@huawei.com>
> > > > > Subject: [virtio-dev] Re: [PATCH v25 0/2] virtio-crypto: virtio c=
rypto
> device
> > > > > specification
> > > > >
> > > > > Is there a github issue? If not pls create one.
> > > > >
> > > >
> > > > I just created one issue:
> > > >
> > > > https://github.com/oasis-tcs/virtio-spec/issues/19
> > >
> > > All set to start voting whenever you request it.
> > >
> >
> > Hi Michael,
> >
> > Since no comments currently, pls help to start a ballot for virtio cryp=
to spec if
> you can. :)
> >
> >
> > Thanks,
> > -Gonglei
>=20
> Done. In the future please add a link to mailing list archives.
>=20

Sure. Ballot created at URL: https://www.oasis-open.org/committees/ballot.p=
hp?id=3D3242


Thanks,
-Gonglei

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

