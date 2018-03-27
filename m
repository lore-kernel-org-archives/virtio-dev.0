Return-Path: virtio-dev-return-3653-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 6C4DE5818041
	for <virtio-dev@lists.oasis-open.org>; Tue, 27 Mar 2018 06:35:09 -0700 (PDT)
Date: Tue, 27 Mar 2018 21:33:30 +0800
From: Tiwei Bie <tiwei.bie@intel.com>
Message-ID: <20180327133330.lmzpdmznpm6moms3@debian>
References: <20180319071537.28649-1-tiwei.bie@intel.com>
 <20180319071537.28649-6-tiwei.bie@intel.com>
 <20180322171450-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180322171450-mutt-send-email-mst@kernel.org>
Subject: Re: [virtio-dev] Re: [PATCH v2 5/6] vfio: remove DPRINTF()
 definition from vfio-common.h
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, alex.williamson@redhat.com, jasowang@redhat.com, pbonzini@redhat.com, stefanha@redhat.com, cunming.liang@intel.com, dan.daly@intel.com, jianfeng.tan@intel.com, zhihong.wang@intel.com, xiao.w.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Mar 22, 2018 at 05:15:30PM +0200, Michael S. Tsirkin wrote:
> On Mon, Mar 19, 2018 at 03:15:36PM +0800, Tiwei Bie wrote:
> > This macro isn't used by any VFIO code. And its name is
> > too generic. The vfio-common.h (in include/hw/vfio) can
> > be included by other modules in QEMU. It can introduce
> > conflicts.
> > 
> > Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> 
> This one can go ahead immediately.
> Try posting as a separate patch.

Got it. Thanks!

Best regards,
Tiwei Bie

> 
> > ---
> >  include/hw/vfio/vfio-common.h | 9 ---------
> >  1 file changed, 9 deletions(-)
> > 
> > diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> > index b820f7984c..f6aa4ae959 100644
> > --- a/include/hw/vfio/vfio-common.h
> > +++ b/include/hw/vfio/vfio-common.h
> > @@ -34,15 +34,6 @@
> >  #define ERR_PREFIX "vfio error: %s: "
> >  #define WARN_PREFIX "vfio warning: %s: "
> >  
> > -/*#define DEBUG_VFIO*/
> > -#ifdef DEBUG_VFIO
> > -#define DPRINTF(fmt, ...) \
> > -    do { fprintf(stderr, "vfio: " fmt, ## __VA_ARGS__); } while (0)
> > -#else
> > -#define DPRINTF(fmt, ...) \
> > -    do { } while (0)
> > -#endif
> > -
> >  enum {
> >      VFIO_DEVICE_TYPE_PCI = 0,
> >      VFIO_DEVICE_TYPE_PLATFORM = 1,
> > -- 
> > 2.11.0
> 
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> 

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

