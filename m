Return-Path: <pasic@linux.ibm.com>
Date: Thu, 11 Nov 2021 11:26:36 +0100
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [virtio-dev] [PATCH v3] virtio-iommu: Rework the bypass feature
Message-ID: <20211111112636.2cd15966.pasic@linux.ibm.com>
In-Reply-To: <20211022121219.1133867-1-jean-philippe@linaro.org>
References: <20211022121219.1133867-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: virtio-dev@lists.oasis-open.org, eric.auger@redhat.com, kevin.tian@intel.com, sebastien.boeuf@intel.com, cohuck@redhat.com, mst@redhat.com, Halil Pasic <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, 22 Oct 2021 13:12:20 +0100
Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:

> The VIRTIO_IOMMU_F_BYPASS feature is awkward to use and incomplete.
> Although it is implemented by QEMU, it is not supported by any driver as
> far as I know. Replace it with a new VIRTIO_IOMMU_F_BYPASS_CONFIG
> feature.

Hi Jean-Philippe!

Is somebody working on the implementation of this? I would like to be
Cc-ed with the implementation patches if possible. The interaction of
s390x and IOMMU is sometimes a little tricky. I would like to make sure
nothing breaks for us. :)

Regards,
Halil

