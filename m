Return-Path: virtio-dev-return-6404-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 580AF985DB8
	for <virtio-dev@lists.oasis-open.org>; Mon, 25 Nov 2019 17:53:20 +0000 (UTC)
Date: Mon, 25 Nov 2019 18:53:16 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Message-ID: <20191125175316.GC945122@lophozonia>
References: <20191122105000.800410-1-jean-philippe@linaro.org>
 <20191122075438-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20191122075438-mutt-send-email-mst@kernel.org>
Subject: [virtio-dev] Re: [RFC 00/13] virtio-iommu on non-devicetree platforms
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org, linux-pci@vger.kernel.org, virtio-dev@lists.oasis-open.org, rjw@rjwysocki.net, lenb@kernel.org, lorenzo.pieralisi@arm.com, guohanjun@huawei.com, sudeep.holla@arm.com, gregkh@linuxfoundation.org, joro@8bytes.org, bhelgaas@google.com, jasowang@redhat.com, jacob.jun.pan@intel.com, eric.auger@redhat.com, sebastien.boeuf@intel.com, kevin.tian@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Nov 22, 2019 at 08:00:46AM -0500, Michael S. Tsirkin wrote:
> > (2) In addition, there are some concerns about having virtio depend on
> >     ACPI or DT. Some hypervisors (Firecracker, QEMU microvm, kvmtool x8=
6
> >     [1])
>=20
> power?

In kvmtool it boot with device tree. It also doesn't need virtio-iommu I
think, since it has its own paravirtualized interface.

> > don't currently implement those methods.
> >=20
> >     It was suggested to embed the topology description into the device.
> >     It can work, as demonstrated at the end of this RFC, with the
> >     following limitations:
> >=20
> >     - The topology description must be read before any endpoint managed
> >       by the IOMMU is probed, and even before the virtio module is
> >       loaded. This RFC uses a PCI quirk to manually parse the virtio
> >       configuration. It assumes that all endpoints managed by the IOMMU
> >       are under this same PCI host.
> >=20
> >     - I don't have a solution for the virtio-mmio transport at the
> >       moment, because I haven't had time to modify a host to test it. I
> >       think it could either use a notifier on the platform bus, or
> >       better, a new 'iommu' command-line argument to the virtio-mmio
> >       driver.
>=20
> =09A notifier seems easier for users. What are the disadvantages of
> =09that?

For each device we have to check if it's virtio-mmio, then map the MMIO
resource and check the device type. Having a dedicated command-line
argument would be more efficient.

Thanks,
Jean

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

