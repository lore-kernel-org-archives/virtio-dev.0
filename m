Return-Path: virtio-dev-return-2974-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 1F09A1CB8078
	for <virtio-dev@lists.oasis-open.org>; Tue, 16 Jan 2018 21:01:37 -0800 (PST)
Date: Wed, 17 Jan 2018 13:00:59 +0800
From: Tiwei Bie <tiwei.bie@intel.com>
Message-ID: <20180117050059.wj3ljl4ltwx3fbsv@debian-xvivbkq.sh.intel.com>
References: <20171222064151.29266-1-tiwei.bie@intel.com>
 <20171222064151.29266-4-tiwei.bie@intel.com>
 <20180116102339.7ad44e48@w520.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180116102339.7ad44e48@w520.home>
Subject: [virtio-dev] Re: [RFC 3/3] vhost-user: add VFIO based accelerators support
To: Alex Williamson <alex.williamson@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, mst@redhat.com, pbonzini@redhat.com, stefanha@redhat.com, cunming.liang@intel.com, dan.daly@intel.com, jianfeng.tan@intel.com, zhihong.wang@intel.com, xiao.w.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Jan 16, 2018 at 10:23:39AM -0700, Alex Williamson wrote:
> On Fri, 22 Dec 2017 14:41:51 +0800
> Tiwei Bie <tiwei.bie@intel.com> wrote:
> 
> > Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> > ---
> >  docs/interop/vhost-user.txt    |  57 ++++++
> >  hw/vfio/common.c               |   2 +-
> >  hw/virtio/vhost-user.c         | 381 ++++++++++++++++++++++++++++++++++++++++-
> >  hw/virtio/vhost.c              |   3 +-
> >  hw/virtio/virtio-pci.c         |   8 -
> >  hw/virtio/virtio-pci.h         |   8 +
> >  include/hw/vfio/vfio.h         |   2 +
> >  include/hw/virtio/vhost-user.h |  26 +++
> >  8 files changed, 476 insertions(+), 11 deletions(-)
> > 
> > diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> > index 7b2924c0ef..53d8700581 100644
> > --- a/hw/vfio/common.c
> > +++ b/hw/vfio/common.c
> > @@ -49,7 +49,7 @@ struct vfio_as_head vfio_address_spaces =
> >   * initialized, this file descriptor is only released on QEMU exit and
> >   * we'll re-use it should another vfio device be attached before then.
> >   */
> > -static int vfio_kvm_device_fd = -1;
> > +int vfio_kvm_device_fd = -1;
> >  #endif
> 
> It seems troublesome for vhost to maintain it's own list of groups and
> register them with the vfio-kvm device.  These should likely be made
> into services provided by vfio/common.c such that we can have a single
> group list and interfaces for adding and deleting them.  Thanks,

Thank you very much for the comments! I'll fix this.

Best regards,
Tiwei Bie

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

