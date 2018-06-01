Return-Path: virtio-dev-return-4230-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 207495818DDE
	for <virtio-dev@lists.oasis-open.org>; Thu, 31 May 2018 21:00:09 -0700 (PDT)
Date: Fri, 1 Jun 2018 12:00:07 +0800
From: Tiwei Bie <tiwei.bie@intel.com>
Message-ID: <20180601040007.GA32070@debian>
References: <20180601020921.30957-1-tiwei.bie@intel.com>
 <20180601063224-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180601063224-mutt-send-email-mst@kernel.org>
Subject: [virtio-dev] Re: [PATCH v2] virtio_pci: support enabling VFs
To: "Michael S. Tsirkin" <mst@redhat.com>, stefanha@redhat.com
Cc: bhelgaas@google.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtio-dev@lists.oasis-open.org, linux-pci@vger.kernel.org, dan.daly@intel.com, mark.d.rustad@intel.com, alexander.h.duyck@intel.com, cunming.liang@intel.com, zhihong.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Jun 01, 2018 at 06:47:01AM +0300, Michael S. Tsirkin wrote:
> On Fri, Jun 01, 2018 at 10:09:21AM +0800, Tiwei Bie wrote:
> > There is a new feature bit allocated in virtio spec to
> > support SR-IOV (Single Root I/O Virtualization):
> > 
> > https://github.com/oasis-tcs/virtio-spec/issues/11
> > 
> > This patch enables the support for this feature bit in
> > virtio driver.
> > 
> > Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> > Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> 
> Generally you aren't supposed to carry forward acks
> when you make major changes.

Got it! Thank you very much!

> 
> In this case I'm fine with the patch, so never mind.

Thank you so much! Anyway, it's my fault.
I'll send a new version dropping all acks.

> 
[...]
> >  
> > +static int virtio_pci_sriov_configure(struct pci_dev *pci_dev, int num_vfs)
> > +{
> > +	struct virtio_pci_device *vp_dev = pci_get_drvdata(pci_dev);
> > +	struct virtio_device *vdev = &vp_dev->vdev;
> > +	int ret;
> > +
> > +	if (!(vdev->config->get_status(vdev) & VIRTIO_CONFIG_S_DRIVER_OK))
> > +		return -EBUSY;
> > +
> > +	if (!__virtio_test_bit(vdev, VIRTIO_F_SR_IOV))
> > +		return -EINVAL;
> > +
> > +	if (pci_vfs_assigned(pci_dev))
> > +		return -EPERM;
> 
> Not a comment on this patch - existing code has the
> same race - but generally
> 
> 1. this seems racy since assigning vfs does not seem
>    to take device lock
> 2. does this work correctly for kvm at all?
>    pci_set_dev_assigned seems to be only called by xen.
> 
> Can you look at addressing this pls?

Sure! I'll do it!

Best regards,
Tiwei Bie

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

