Return-Path: virtio-dev-return-4082-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id C689C5818EFE
	for <virtio-dev@lists.oasis-open.org>; Tue, 15 May 2018 03:23:23 -0700 (PDT)
Date: Tue, 15 May 2018 18:23:47 +0800
From: Tiwei Bie <tiwei.bie@intel.com>
Message-ID: <20180515102347.GA10528@debian>
References: <20180510154126.4062-1-tiwei.bie@intel.com>
 <20180515094044.GG14755@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180515094044.GG14755@stefanha-x1.localdomain>
Subject: Re: [virtio-dev] [PATCH v3] VIRTIO_F_IO_BARRIER: use I/O barriers in
 driver
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: mst@redhat.com, pbonzini@redhat.com, jasowang@redhat.com, virtio-dev@lists.oasis-open.org, dan.daly@intel.com, cunming.liang@intel.com, zhihong.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, May 15, 2018 at 10:40:44AM +0100, Stefan Hajnoczi wrote:
> On Thu, May 10, 2018 at 11:41:26PM +0800, Tiwei Bie wrote:
> > There will be hardware virtio devices in the future, which
> > require drivers to use the barriers suitable for I/O devices,
> > compared with software virtio devices which just require
> > drivers to use the barriers suitable for CPU cores.
> > 
> > To fix the ordering issue for hardware virtio devices, add
> > a new feature: VIRTIO_F_IO_BARRIER. When negotiated, driver
> > will use the barriers suitable for I/O devices.
> > 
> > Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> > v2 -> v3:
> > - Update the feature bits allocation (Stefan);
> > 
> > v1 -> v2:
> > - Rebase to the latest spec (MST);
> > - Use a smaller textwidth (according to _vimrc);
> > 
> > RFC -> v1:
> > - Use plural (Stefan);
> > - Add more details (Stefan);
> > 
> >  content.tex | 20 ++++++++++++++++++--
> >  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> Thanks for your patience!
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

It's my pleasure. Thanks for your review! :)

Best regards,
Tiwei Bie

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

