Return-Path: virtio-dev-return-3079-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 361A658191C9
	for <virtio-dev@lists.oasis-open.org>; Thu, 25 Jan 2018 22:28:44 -0800 (PST)
Date: Fri, 26 Jan 2018 14:28:06 +0800
From: Tiwei Bie <tiwei.bie@intel.com>
Message-ID: <20180126062806.dwu5qq4jnzsfg7a7@debian-xvivbkq.sh.intel.com>
References: <20180125040328.22867-1-tiwei.bie@intel.com>
 <20180125142220.GD28396@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180125142220.GD28396@stefanha-x1.localdomain>
Subject: [virtio-dev] Re: [Qemu-devel] [PATCH v1 0/6] Extend vhost-user to support VFIO
 based accelerators
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, alex.williamson@redhat.com, jasowang@redhat.com, pbonzini@redhat.com, stefanha@redhat.com, jianfeng.tan@intel.com, cunming.liang@intel.com, xiao.w.wang@intel.com, zhihong.wang@intel.com, dan.daly@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Jan 25, 2018 at 02:22:20PM +0000, Stefan Hajnoczi wrote:
> On Thu, Jan 25, 2018 at 12:03:22PM +0800, Tiwei Bie wrote:
> > Why extend vhost-user for vDPA
> > ==============================
> > 
> > We have already implemented various virtual switches (e.g. OVS-DPDK)
> > based on vhost-user for VMs in the Cloud. They are purely software
> > running on CPU cores. When we have accelerators for such NFVi applications,
> > it's ideal if the applications could keep using the original interface
> > (i.e. vhost-user netdev) with QEMU, and infrastructure is able to decide
> > when and how to switch between CPU and accelerators within the interface.
> > And the switching (i.e. switch between CPU and accelerators) can be done
> > flexibly and quickly inside the applications.
> > 
> > More details about this can be found from the Cunming's discussions on
> > the RFC patch set.
> > 
> > The previous links:
> > RFC: http://lists.nongnu.org/archive/html/qemu-devel/2017-12/msg04844.html
> 
> Is vDPA also useful in the simpler use case where there is no NFVi
> application?
> 
> In other words, you have virtio-net inside the guest and vhost-net on
> the host.  You'd like to accelerate the virtio-net NIC using the
> hardware's vDPA support.
> 
> DPDK requires dedicated logical cores and hugepages.  Those resources
> will not be used (wasted) if you just want to enable vDPA but have no
> DPDK packet processing application.
> 
> How can this use case be supported without wasting resources?

DPDK applications don't have to keep polling. In the case
you described, the DPDK process just need to listen on the
vhost socket, basically its CPU utilization is 0% if the
notify passthrough is setup correctly.

DPDK applications also don't have to allocate a lot of
memory. In the case you described, the DPDK process just
need to allocate some memory to initialize eal. The memory
table provided by QEMU will be used to program the IOMMU
for the accelerator device. If the accelerator device has
control vq, the DPDK process may need to allocate some
extra memory to talk with the device via control vq.

Best regards,
Tiwei Bie

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

