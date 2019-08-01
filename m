Return-Path: virtio-dev-return-5911-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 36157985D26
	for <virtio-dev@lists.oasis-open.org>; Thu,  1 Aug 2019 01:14:18 +0000 (UTC)
From: "Huang, Yang" <yang.huang@intel.com>
Date: Thu, 1 Aug 2019 01:14:11 +0000
Message-ID: <0B92A36466FABC4D99BAF0BDB1FA8BBC415730B4@shsmsx102.ccr.corp.intel.com>
References: <1564494374-16147-1-git-send-email-yang.huang@intel.com>
 <20190731145723.GA7363@stefanha-x1.localdomain>
In-Reply-To: <20190731145723.GA7363@stefanha-x1.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: RE: [virtio-dev] [PATCH v2] Add virtio rpmb device specification
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "mst@redhat.com" <mst@redhat.com>, "Zhu, Bing" <bing.zhu@intel.com>, "Winkler, Tomas" <tomas.winkler@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>



> -----Original Message-----
> From: virtio-dev@lists.oasis-open.org [mailto:virtio-dev@lists.oasis-open=
.org]
> On Behalf Of Stefan Hajnoczi
> Sent: Wednesday, July 31, 2019 22:57
> To: Huang, Yang <yang.huang@intel.com>
> Cc: virtio-dev@lists.oasis-open.org; mst@redhat.com; Zhu, Bing
> <bing.zhu@intel.com>; Winkler, Tomas <tomas.winkler@intel.com>
> Subject: Re: [virtio-dev] [PATCH v2] Add virtio rpmb device specification
>=20
> On Tue, Jul 30, 2019 at 09:46:14PM +0800, Huang Yang wrote:
> > It is a virtio based RPMB (Replay Protected Memory Block) device.
>=20
> Please include the request structs.  There is not enough information in t=
his spec
> to implement the device.

OK.

> > +\devicenormative{\subsubsection}{Device Operation}{Device Types /
> > +RPMB Device / Device Operation}
> > +
> > +The device provides a simulated RPMB backed by ordinary file or
> > +  other medium in host. It SHOULD keep consistent behaviors with
>=20
> Or it could be a real hardware?  The specification shouldn't discuss thes=
e
> implementation details except to say that virtio-rpmb could be backed in =
a
> number of ways.

This is a good catch.=20

But how to implement a physical RPMB backed solution is out of scope.

If there are multiple guests who want to use RPMB. And their devices are ba=
cked by a same physical RPMB.
1. Who owns key, who owns RPMB. They should share a same key. If Guest1 pro=
grammed a Key1, the Guest2 MUST use the same Key1.
2. Device SHOULD  isolate the RPMB space to protect from overwritten betwee=
n guests.
    But address remapping cannot work. Because address remapping by virtio =
device will cause to a wrong MAC, it will result to write failure.
3. RPMB capacity is limited up to 16MB. It cannot support the sharing among=
 a large number of guests.

If users want to implement it backed by hardware RPMB, they should have a w=
hole picture design, which is out of scope of the spec.
Of course, physical backed RPMB still adapts to the rules of the spec.
I will change it to "could be backed in a number of ways."

Both simulated and physical RPMB backed solution are implemented on Project=
 ACRN.
If you are interested, "Secure Storage Virtualization" in this slide shows =
a high level design of physical RPMB backed solution:=20
https://events.linuxfoundation.org/wp-content/uploads/2017/12/Implement-And=
roid-Tamper-Resistant-Secure-Storage-Bing-Zhu_and-Secure-it-in-Virtualizati=
on-Bing-Zhu-Intel-Corporation.pdf




---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

