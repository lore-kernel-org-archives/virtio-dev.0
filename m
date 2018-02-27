Return-Path: virtio-dev-return-3301-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 28EAC5818FAD
	for <virtio-dev@lists.oasis-open.org>; Tue, 27 Feb 2018 06:47:42 -0800 (PST)
Date: Tue, 27 Feb 2018 16:47:22 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180227164510-mutt-send-email-mst@kernel.org>
References: <20180214145340.1223-2-jean-philippe.brucker@arm.com>
 <201802220455.lMEb6LLi%fengguang.wu@intel.com>
 <e5ffc52f-4510-f757-aa83-2a99af3ae06b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5ffc52f-4510-f757-aa83-2a99af3ae06b@arm.com>
Subject: [virtio-dev] Re: [PATCH 1/4] iommu: Add virtio-iommu driver
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: kbuild test robot <lkp@intel.com>, "kbuild-all@01.org" <kbuild-all@01.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>, "joro@8bytes.org" <joro@8bytes.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, Marc Zyngier <Marc.Zyngier@arm.com>, Robin Murphy <Robin.Murphy@arm.com>, Will Deacon <Will.Deacon@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>, "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>, "peterx@redhat.com" <peterx@redhat.com>, "bharat.bhushan@nxp.com" <bharat.bhushan@nxp.com>, "tnowicki@caviumnetworks.com" <tnowicki@caviumnetworks.com>, "jayachandran.nair@cavium.com" <jayachandran.nair@cavium.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>, "jintack@cs.columbia.edu" <jintack@cs.columbia.edu>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Feb 22, 2018 at 11:04:30AM +0000, Jean-Philippe Brucker wrote:
> On 21/02/18 20:12, kbuild test robot wrote:
> [...]
> > config: arm64-allmodconfig (attached as .config)
> [...]
> >    aarch64-linux-gnu-ld: arch/arm64/kernel/head.o: relocation R_AARCH64_ABS32 against `_kernel_offset_le_lo32' can not be used when making a shared object
> >    arch/arm64/kernel/head.o: In function `kimage_vaddr':
> >    (.idmap.text+0x0): dangerous relocation: unsupported relocation
> 
> Is this related?
> 
> >    arch/arm64/kernel/head.o: In function `__primary_switch':
> >    (.idmap.text+0x340): dangerous relocation: unsupported relocation
> >    (.idmap.text+0x348): dangerous relocation: unsupported relocation
> >    drivers/iommu/virtio-iommu.o: In function `viommu_probe':
> >    virtio-iommu.c:(.text+0xbdc): undefined reference to `virtio_check_driver_offered_feature'
> >    virtio-iommu.c:(.text+0xcfc): undefined reference to `virtio_check_driver_offered_feature'
> >    virtio-iommu.c:(.text+0xe10): undefined reference to `virtio_check_driver_offered_feature'
> >    drivers/iommu/virtio-iommu.o: In function `viommu_send_reqs_sync':
> >    virtio-iommu.c:(.text+0x130c): undefined reference to `virtqueue_add_sgs'
> >    virtio-iommu.c:(.text+0x1398): undefined reference to `virtqueue_kick'
> >    virtio-iommu.c:(.text+0x14d4): undefined reference to `virtqueue_get_buf'
> >    drivers/iommu/virtio-iommu.o: In function `virtio_iommu_drv_init':
> >    virtio-iommu.c:(.init.text+0x1c): undefined reference to `register_virtio_driver'
> >    drivers/iommu/virtio-iommu.o: In function `virtio_iommu_drv_exit':
> >>> virtio-iommu.c:(.exit.text+0x14): undefined reference to `unregister_virtio_driver'
> 
> Right. At the moment CONFIG_VIRTIO_IOMMU is a bool instead of tristate,
> because the IOMMU subsystem isn't entirely ready to have IOMMU drivers
> built as modules. In addition to exporting symbols it would also needs to
> hold off probing endpoints behind the IOMMU until the IOMMU driver is
> loaded. At the moment (I think) it gives up once userspace is reached (see
> of_iommu_driver_present).
> 
> The above report is due to VIRTIO=m and VIRTIO_IOMMU=y. To solve it we could:
> 
> a) Allow VIRTIO_IOMMU to be built as module by exporting a dozen IOMMU
> symbols. It would be a lie. The driver wouldn't be usable because of the
> probe issue discussed above, but it would build.
> 
> b) Actually make any IOMMU driver work as module. Whilst it would
> certainly be a nice feature, it's a bigger problem and I don't think it
> has its place in this series.
> 
> c) Make VIRTIO_IOMMU depend on VIRTIO_MMIO=y instead of VIRTIO_MMIO, which
> I think is the sanest for now (and does work), even though distro kernels
> probably all have VIRTIO=m.
> 
> I prefer doing c) now and experiment with b) once I got some time.
> 
> Thanks,
> Jean

It kind of means it's a toy for now though. So fine as long
as it's out of tree.

-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

