Return-Path: virtio-dev-return-5912-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1A5B2985BC0
	for <virtio-dev@lists.oasis-open.org>; Thu,  1 Aug 2019 05:19:21 +0000 (UTC)
From: "Huang, Yang" <yang.huang@intel.com>
Date: Thu, 1 Aug 2019 05:19:13 +0000
Message-ID: <0B92A36466FABC4D99BAF0BDB1FA8BBC415732A3@shsmsx102.ccr.corp.intel.com>
References: <1564494374-16147-1-git-send-email-yang.huang@intel.com>
	<20190731141629.2cfd5bc7.cohuck@redhat.com>
	<0B92A36466FABC4D99BAF0BDB1FA8BBC41572FB3@shsmsx102.ccr.corp.intel.com>
 <20190731171938.11cc3047.cohuck@redhat.com>
In-Reply-To: <20190731171938.11cc3047.cohuck@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: RE: [virtio-dev] [PATCH v2] Add virtio rpmb device specification
To: Cornelia Huck <cohuck@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "mst@redhat.com" <mst@redhat.com>, "Zhu, Bing" <bing.zhu@intel.com>, "Winkler, Tomas" <tomas.winkler@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>


> >  */
> > struct rpmb_frame_jdec {
> >         __u8   stuff[196];
> >         __u8   key_mac[32];
> >         __u8   data[256];
> >         __u8   nonce[16];
> >         __be32 write_counter;
> >         __be16 addr;
> >         __be16 block_count;
> >         __be16 result;
> >         __be16 req_resp;
> > }
>=20
> Ok, this seems to properly define the structure including endianness.
> You should explicitly refer to it by name, then it should be fine (when t=
he
> document you refer to is added as a normative reference).
>=20
> >
> > A user should fill the rpmb frame per his request and send it to virtio=
 rpmb
> driver.
> > The driver then format it to virtqueue and send it to device.
>=20
> Is there any formatting on top of the frame?

No such requirement for driver. Just sending to device via virtqueue.=20

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

