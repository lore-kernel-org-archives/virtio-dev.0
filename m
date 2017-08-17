Return-Path: virtio-dev-return-2472-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 035625818FFB
	for <virtio-dev@lists.oasis-open.org>; Thu, 17 Aug 2017 03:10:00 -0700 (PDT)
References: <20170804181927.12148-1-jean-philippe.brucker@arm.com>
 <20170816040853.GA10652@shay3t003839711.china.huawei.com>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <a2e573f3-bdfb-b5e5-7835-a7597abd48f5@arm.com>
Date: Thu, 17 Aug 2017 11:12:24 +0100
MIME-Version: 1.0
In-Reply-To: <20170816040853.GA10652@shay3t003839711.china.huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-dev] [RFC] virtio-iommu version 0.4
To: Adam Tao <taozhe1@huawei.com>
Cc: iommu@lists.linux-foundation.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, will.deacon@arm.com, robin.murphy@arm.com, lorenzo.pieralisi@arm.com, mst@redhat.com, jasowang@redhat.com, marc.zyngier@arm.com, eric.auger@redhat.com, eric.auger.pro@gmail.com, bharat.bhushan@nxp.com, peterx@redhat.com, kevin.tian@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Adam,

On 16/08/17 05:08, Adam Tao wrote:
>> * There is a working Qemu prototype [3], thanks to Eric Auger and Bharat
>>   Bhushan.
> Hi, Brucker
> I read the related spec for virtio IOMMU,
> I am wondering if we support both the virtual and physical devices in
> the guest to use the virtio IOMMU, how can we config the related address
> translation for the different type of devices.
> e.g.
> 1. for Virtio devs(e.g. virtio-net), we can change the memmap table used
> by the vhost device.
> 2. for physical devices we can directly config the IOMMU/SMMU on the
> host.
> 
> So do you know are there any RFCs for the back-end implementation for the virtio-IOMMU
> thanks
> Adam

Eric's series [3] adds support for virtual devices (I'v only had time to
test virtio-net so far, but as vhost-iotlb seems to be supported by Qemu,
it should work with vhost-net as well). Bharat is working on the VFIO
backend for physical devices. As far as I'm aware, his latest version is:

[7] https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg04094.html

Thanks,
Jean


>> [1] http://www.spinics.net/lists/kvm/msg147990.html
>> [2] git://linux-arm.org/virtio-iommu.git branch viommu/v0.4
>>     http://www.linux-arm.org/git?p=virtio-iommu.git;a=blob;f=dist/v0.4/virtio-iommu-v0.4.pdf
>>     I reiterate the disclaimers: don't use this document as a reference,
>>     it's a draft. It's also not an OASIS document yet. It may be riddled
>>     with mistakes. As this is a working draft, it is unstable and I do not
>>     guarantee backward compatibility of future versions.
>> [3] https://lists.gnu.org/archive/html/qemu-arm/2017-08/msg00004.html
>> [4] git://linux-arm.org/linux-jpb.git virtio-iommu/v0.4
>>     Warning: UAPI headers have changed! They didn't follow the spec,
>>     please update. (Use branch v0.1, that has the old headers, for the
>>     Qemu prototype [3])
>> [5] git://linux-arm.org/kvmtool-jpb.git virtio-iommu/v0.4
>>     Warning: command-line has changed! Use --viommu vfio[,opts] and
>>     --viommu virtio[,opts] to instantiate a device.
>> [6] http://www.linux-arm.org/git?p=virtio-iommu.git;a=tree;f=dist/diffs

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

