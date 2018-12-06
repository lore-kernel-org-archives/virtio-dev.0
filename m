Return-Path: virtio-return-3203-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Thu, 6 Dec 2018 13:24:32 +0100
From: Jens Freimann <jfreimann@redhat.com>
Message-ID: <20181206122432.5op6qcqpp7grtyz6@jenstp.localdomain>
References: <20181127010219.10441-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181127010219.10441-1-mst@redhat.com>
Subject: [virtio] Re: [virtio-dev] [PATCH v3] ACCESS_PLATFORM/ORDER_PLATFORM
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Tiwei Bie <tiwei.bie@intel.com>, cohuck@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, jasowang@redhat.com, pasic@linux.vnet.ibm.com, dan.daly@intel.com, cunming.liang@intel.com, zhihong.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Nov 26, 2018 at 08:03:37PM -0500, Michael S. Tsirkin wrote:
>diff --git a/content.tex b/content.tex
>index c346183..5582c1c 100644
>--- a/content.tex
>+++ b/content.tex
>@@ -5452,26 +5452,48 @@ Descriptors} and \ref{sec:Packed Virtqueues / Indirect Flag: Scatter-Gather Supp
>   \item[VIRTIO_F_VERSION_1(32)] This indicates compliance with this
>     specification, giving a simple way to detect legacy devices or drivers.
>
>-  \item[VIRTIO_F_IOMMU_PLATFORM(33)] This feature indicates that the device is
>+  \item[VIRTIO_F_ACCESS_PLATFORM(33)] This feature indicates that
>+  the device can be used on a platform where device access to data
>+  in memory is limited and/or translated. E.g. this is the case if the device can be located
>   behind an IOMMU that translates bus addresses from the device into physical
>-  addresses in memory.  If this feature bit is set to 0, then the device emits
>-  physical addresses which are not translated further, even though an IOMMU
>-  may be present.
>+  addresses in memory, if the device can be limited to only access
>+  certain memory addresses or if special commands such as
>+  a cache flush can be needed to synchronise data in memory with
>+  the device. Whether accesses are actually limited or translated
>+  is described by platform-specific means.
>+  If this feature bit is set to 0, then the device
>+  has same access to memory addresses supplied to it as the
>+  driver has.
>+  In particular, the device will always use physical addresses
>+  matching addresses used by the driver (typically meaning
>+  physical addresses used by the CPU)
>+  and not translated further, and can access any address supplied to it by
>+  the driver. When clear, this overrides any platform-specific description of
>+  whether device access is limited or translated in any way, e.g.
>+  whether an IOMMU may be present.
>   \item[VIRTIO_F_RING_PACKED(34)] This feature indicates
>   support for the packed virtqueue layout as described in
>   \ref{sec:Basic Facilities of a Virtio Device / Packed Virtqueues}~\nameref{sec:Basic Facilities of a Virtio Device / Packed Virtqueues}.
>   \item[VIRTIO_F_IN_ORDER(35)] This feature indicates
>   that all buffers are used by the device in the same
>   order in which they have been made available.
>-  \item[VIRTIO_F_IO_BARRIER(36)] This feature indicates
>-  that the device needs the driver to use the barriers
>-  suitable for hardware devices.  Some transports require
>-  barriers to ensure devices have a consistent view of
>-  memory.  When devices are implemented in software a
>-  weaker form of barrier may be sufficient and yield
>-  better performance.  This feature indicates whether
>-  a stronger form of barrier suitable for hardware
>-  devices is necessary.
>+  \item[VIRTIO_F_ORDER_PLATFORM(36)] This feature indicates
>+  that memory accesses by the driver and the device are ordered
>+  in a way described by the platform.
>+
>+  If this feature bit is negotiated, the ordering in effect for any
>+  memory accesses by the driver that need to be ordered in a specific way
>+  with respect to accesses by the device is the one suitable for devices
>+  described by the platform.

I had to read this sentence several times. How about: "Some memory
accesses by the driver need to be ordered in a specific way with
respect to accesses by the device. If this feature bit is negotiated,
these accesses need to match the ordering requirements of devices as
described for the platform."

In any case:

Reviewed-by: Jens Freimann <jfreimann@redhat.com> 


regards,
Jens 

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

