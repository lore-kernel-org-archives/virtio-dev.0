Return-Path: virtio-dev-return-3887-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 2C45B58191A0
	for <virtio-dev@lists.oasis-open.org>; Thu, 19 Apr 2018 09:49:16 -0700 (PDT)
Date: Thu, 19 Apr 2018 19:48:55 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180419194500-mutt-send-email-mst@kernel.org>
References: <20180412151232.17506-1-tiwei.bie@intel.com>
 <20180412151232.17506-7-tiwei.bie@intel.com>
 <20180418192154-mutt-send-email-mst@kernel.org>
 <20180419111439.i6gfhnept6wy7uzp@debian>
 <D0158A423229094DA7ABF71CF2FA0DA34E94E895@SHSMSX104.ccr.corp.intel.com>
 <c41439d6-69b7-474a-530f-07ffb5f1b9e6@redhat.com>
 <20180419180912-mutt-send-email-mst@kernel.org>
 <174b5e48-dfde-cb5f-e664-39d43a20a629@redhat.com>
 <20180419185630-mutt-send-email-mst@kernel.org>
 <380b6838-7249-fec1-8ebb-1b899830a9a0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <380b6838-7249-fec1-8ebb-1b899830a9a0@redhat.com>
Subject: Re: [virtio-dev] RE: [PATCH v3 6/6] vhost-user: support registering
 external host notifiers
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Liang, Cunming" <cunming.liang@intel.com>, "Bie, Tiwei" <tiwei.bie@intel.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Daly, Dan" <dan.daly@intel.com>, "Tan, Jianfeng" <jianfeng.tan@intel.com>, "Wang, Zhihong" <zhihong.wang@intel.com>, "Wang, Xiao W" <xiao.w.wang@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Apr 19, 2018 at 06:07:07PM +0200, Paolo Bonzini wrote:
> On 19/04/2018 17:59, Michael S. Tsirkin wrote:
> > On Thu, Apr 19, 2018 at 05:51:51PM +0200, Paolo Bonzini wrote:
> >> On 19/04/2018 17:19, Michael S. Tsirkin wrote:
> >>>> - if we make it 1 when weak barriers are needed, the device also needs
> >>>> to nack feature negotiation (not allow setting the FEATURES_OK) if the
> >>>> bit is not set by the driver.
> >>>>  However, that is not enough.  Live
> >>>> migration assumes that it is okay to migrate a virtual machine from a
> >>>> source that doesn't support a feature to a destination that supports it.
> >>>>  In this case, it would assume that it is okay to migrate from software
> >>>> virtio to hardware virtio.  This is wrong because the destination would
> >>>> use weak barriers
> >>>
> >>> You can't migrate between systems with different sets of device features
> >>> right now.
> >>
> >> Yes, you can, exactly because some features are defined not by the
> >> machine type but rather by the host kernel.  See virtio_net_get_features
> >> in QEMU's hw/virtio/virtio-net.c, and virtio_set_features_nocheck in
> >> QEMU's hw/virtio/virtio.c.
> > 
> > Oh you are right. Well we can just special-case that one :)
> 
> Anything wrong with bumping the PCI revision?
> 
> Paolo

Nothing except in virtio 1 bumping the revision does not prevent
loading the old driver.

-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

