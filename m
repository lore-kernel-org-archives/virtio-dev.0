Return-Path: virtio-dev-return-6403-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5B14E985DB8
	for <virtio-dev@lists.oasis-open.org>; Mon, 25 Nov 2019 17:48:22 +0000 (UTC)
Date: Mon, 25 Nov 2019 18:48:17 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Message-ID: <20191125174817.GB945122@lophozonia>
References: <20191122105000.800410-1-jean-philippe@linaro.org>
 <20191122105000.800410-14-jean-philippe@linaro.org>
 <20191122072753-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20191122072753-mutt-send-email-mst@kernel.org>
Subject: [virtio-dev] Re: [RFC 13/13] iommu/virtio: Add topology description to
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org, linux-pci@vger.kernel.org, virtio-dev@lists.oasis-open.org, rjw@rjwysocki.net, lenb@kernel.org, lorenzo.pieralisi@arm.com, guohanjun@huawei.com, sudeep.holla@arm.com, gregkh@linuxfoundation.org, joro@8bytes.org, bhelgaas@google.com, jasowang@redhat.com, jacob.jun.pan@intel.com, eric.auger@redhat.com, sebastien.boeuf@intel.com, kevin.tian@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Nov 22, 2019 at 07:53:19AM -0500, Michael S. Tsirkin wrote:
> Overall this looks good to me. The only point is that
> I think the way the interface is designed makes writing
> the driver a bit too difficult. Idea: if instead we just
> have a length field and then an array of records
> (preferably unions so we don't need to work hard),
> we can shadow that into memory, then iterate over
> the unions.
>=20
> Maybe add a uniform record length + number of records field.
> Then just skip types you do not know how to handle.
> This will also help make sure it's within bounds.
>=20
> What do you think?

Sounds good, that should simplify the implementation a bit.

> You will need to do something to address the TODO I think.

Yes, I'll try to figure out a way to test platform devices.

> > +static void viommu_cwrite(struct pci_dev *dev, int cfg,
> > +=09=09=09  struct viommu_cap_config *cap, u32 length, u32 offset,
> > +=09=09=09  u32 val)
>=20
> A single user with 4 byte parameter. Just open-code?

Ok

> > +=09=09cap.head.type =3D viommu_cread(dev, pci_cfg, dev_cfg, 2, offset)=
;
> > +=09=09cap.head.next =3D viommu_cread(dev, pci_cfg, dev_cfg, 2, offset =
+ 2);
>=20
> All of this doesn't seem to be endian-clean. Try running sparse I think
> it will complain.

It does, I'll fix this

> > @@ -36,6 +37,31 @@ struct virtio_iommu_config {
> >  =09struct virtio_iommu_range_32=09=09domain_range;
> >  =09/* Probe buffer size */
> >  =09__le32=09=09=09=09=09probe_size;
> > +=09/* Offset to the beginning of the topology table */
> > +=09__le16=09=09=09=09=09topo_offset;
>=20
> why do we need an offset?

I find it awkward to put a variable-size array in the middle of the
config. The virtio_iommu_config struct would be easier to extend later if
we keep the array at the end and only define small static fields here.

>=20
> > +};
> > +
> > +struct virtio_iommu_topo_head {
> > +=09__le16=09=09=09=09=09type;
> > +=09__le16=09=09=09=09=09next;
> > +};
>=20
> So this linked list makes things harder than necessary imho.
> It will be easier to just have a counter with # of records.
> Then make all records the same size.
> Then just read each record out into a buffer, and
> handle it there.

Yes, that should simplify things.

Thanks,
Jean

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

