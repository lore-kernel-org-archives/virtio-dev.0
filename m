Return-Path: virtio-dev-return-3897-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 86F55581916B
	for <virtio-dev@lists.oasis-open.org>; Thu, 19 Apr 2018 16:05:56 -0700 (PDT)
From: "Liang, Cunming" <cunming.liang@intel.com>
Date: Thu, 19 Apr 2018 23:05:40 +0000
Message-ID: <D0158A423229094DA7ABF71CF2FA0DA34E950FD2@SHSMSX104.ccr.corp.intel.com>
References: <20180412151232.17506-1-tiwei.bie@intel.com>
 <20180412151232.17506-7-tiwei.bie@intel.com>
 <20180418192154-mutt-send-email-mst@kernel.org>
 <20180419111439.i6gfhnept6wy7uzp@debian>
 <D0158A423229094DA7ABF71CF2FA0DA34E94E895@SHSMSX104.ccr.corp.intel.com>
 <20180419182035-mutt-send-email-mst@kernel.org>
 <f123c3a5-f7a3-a0e3-ffc7-b57e19610a9b@redhat.com>
 <D0158A423229094DA7ABF71CF2FA0DA34E950C67@SHSMSX104.ccr.corp.intel.com>
 <20180419195651-mutt-send-email-mst@kernel.org>
In-Reply-To: <20180419195651-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [virtio-dev] RE: [PATCH v3 6/6] vhost-user: support registering external host
 notifiers
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Bie, Tiwei" <tiwei.bie@intel.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Daly,
 Dan" <dan.daly@intel.com>, "Tan, Jianfeng" <jianfeng.tan@intel.com>, "Wang,
 Zhihong" <zhihong.wang@intel.com>, "Wang, Xiao W" <xiao.w.wang@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>



> -----Original Message-----
> From: Michael S. Tsirkin [mailto:mst@redhat.com]
> Sent: Friday, April 20, 2018 1:01 AM
> To: Liang, Cunming <cunming.liang@intel.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>; Bie, Tiwei <tiwei.bie@intel.com>=
;
> jasowang@redhat.com; alex.williamson@redhat.com; stefanha@redhat.com;
> qemu-devel@nongnu.org; virtio-dev@lists.oasis-open.org; Daly, Dan
> <dan.daly@intel.com>; Tan, Jianfeng <jianfeng.tan@intel.com>; Wang, Zhiho=
ng
> <zhihong.wang@intel.com>; Wang, Xiao W <xiao.w.wang@intel.com>
> Subject: Re: [PATCH v3 6/6] vhost-user: support registering external host
> notifiers
>=20
> On Thu, Apr 19, 2018 at 04:52:20PM +0000, Liang, Cunming wrote:
> >
> >
> > > -----Original Message-----
> > > From: Paolo Bonzini [mailto:pbonzini@redhat.com]
> > > Sent: Thursday, April 19, 2018 11:52 PM
> > > To: Michael S. Tsirkin <mst@redhat.com>; Liang, Cunming
> > > <cunming.liang@intel.com>
> > > Cc: Bie, Tiwei <tiwei.bie@intel.com>; jasowang@redhat.com;
> > > alex.williamson@redhat.com; stefanha@redhat.com;
> > > qemu-devel@nongnu.org; virtio-dev@lists.oasis-open.org; Daly, Dan
> > > <dan.daly@intel.com>; Tan, Jianfeng <jianfeng.tan@intel.com>; Wang,
> > > Zhihong <zhihong.wang@intel.com>; Wang, Xiao W
> > > <xiao.w.wang@intel.com>
> > > Subject: Re: [PATCH v3 6/6] vhost-user: support registering external
> > > host notifiers
> > >
> > > On 19/04/2018 17:42, Michael S. Tsirkin wrote:
> > > >> A compiler barrier is enough on strongly-ordered memory platform.
> > > >> As it doesn't re-order store, PCI device won't see a stale index
> > > >> value. But a weakly-ordered memory needs sfence.
> > > >
> > > > Oh you are right.
> > > >
> > > > So it's only needed for non-intel platforms or when packets are in
> > > > WC memory then. And I don't know whether dpdk ever puts packets in
> > > > WC memory.
> > > >
> > > > I guess we'll cross this bridge when we get to it.
> > >
> > > Non-TSO architectures seem important...
> >
> > I'm not familiar with Non-TSO, trying to understand the difference
> > according to the feature set. Let's say non-TSO architectures do not
> > set 'weak_barriers'. Then mandatory barrier is used for software. HW
> > offload on that platform would choose different feature set against
> > software?
>=20
> Right. We'll need a flag for this feature for starters. It doesn't exist
> :) Paolo also points out that we should then add code to disallow migrati=
on
> between setups with and without the feature.
I see. Thanks.

>=20
> > If it's not, essentially we're worried about live migration from a TSO =
to a non-
> TSO architectures platform?
>=20
> Probably not.
>=20
> > >
> > > Paolo

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

