Return-Path: <jean-philippe@linaro.org>
Date: Thu, 11 Nov 2021 11:09:25 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [virtio-dev] [PATCH v3] virtio-iommu: Rework the bypass feature
Message-ID: <YYz55bdE6y0gKc3x@myrica>
References: <20211022121219.1133867-1-jean-philippe@linaro.org>
 <20211111112636.2cd15966.pasic@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20211111112636.2cd15966.pasic@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Halil Pasic <pasic@linux.ibm.com>
Cc: virtio-dev@lists.oasis-open.org, eric.auger@redhat.com, kevin.tian@intel.com, sebastien.boeuf@intel.com, cohuck@redhat.com, mst@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Halil,

On Thu, Nov 11, 2021 at 11:26:36AM +0100, Halil Pasic wrote:
> On Fri, 22 Oct 2021 13:12:20 +0100
> Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:
> 
> > The VIRTIO_IOMMU_F_BYPASS feature is awkward to use and incomplete.
> > Although it is implemented by QEMU, it is not supported by any driver as
> > far as I know. Replace it with a new VIRTIO_IOMMU_F_BYPASS_CONFIG
> > feature.
> 
> Hi Jean-Philippe!
> 
> Is somebody working on the implementation of this? I would like to be
> Cc-ed with the implementation patches if possible.

Yes I posted the Linux support:
https://lore.kernel.org/linux-iommu/20211013121052.518113-1-jean-philippe@linaro.org/

And QEMU, which depends on the Linux header:
https://lore.kernel.org/qemu-devel/20210930185050.262759-1-jean-philippe@linaro.org/

I plan to resend after the merge window and will Cc you.

> The interaction of s390x and IOMMU is sometimes a little tricky. I would
> like to make sure nothing breaks for us. :)

Bypass should be constrained within the virtio-iommu device and driver,
and so shouldn't break s390 as far as I know. I haven't thought much about
supporting virtio-iommu for archs other than arm and x86 for the moment
(in general it should be as simple as adding it to ACPI tables or DT).
I believe power already has a PV IOMMU interface and doesn't need a
dedicated vIOMMU device, but I'm not sure where s390 stands

Thanks,
Jean

