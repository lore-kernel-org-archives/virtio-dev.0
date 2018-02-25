Return-Path: virtio-dev-return-3270-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 701EC58180C6
	for <virtio-dev@lists.oasis-open.org>; Sun, 25 Feb 2018 07:20:52 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
From: Yan Vugenfirer <yvugenfi@redhat.com>
In-Reply-To: <20180222175250.97135.98386.stgit@mdrustad-mac04.local>
Date: Sun, 25 Feb 2018 17:20:47 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <7B7DC8E0-9F6A-403F-8077-39FC3939482E@redhat.com>
References: <20180222175250.97135.98386.stgit@mdrustad-mac04.local>
Subject: Re: [virtio-dev] [RFC PATCH V2] virtio_pci: Add SR-IOV support
To: Mark Rustad <mark.d.rustad@intel.com>
Cc: virtio-dev@lists.oasis-open.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, dan.daly@intel.com, alex.williamson@redhat.com, MRustad@gmail.com, alexander.duyck@gmail.com, mst@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>



> On 22 Feb 2018, at 19:52, Mark Rustad <mark.d.rustad@intel.com> wrote:
>=20
> Hardware-realized virtio-pci devices can implement SR-IOV, so this
> patch enables its use. The device in question is an upcoming Intel
> NIC that implements both a virtio-net PF and virtio-net VFs. These
> are hardware realizations of what has been up to now been a software
> interface.
>=20
> The device in question has the following 4-part PCI IDs:
>=20
> PF: device: 1af4 vendor: 1041 subvendor: 8086 subdevice: 15fe
> VF: device: 1af4 vendor: 1041 subvendor: 8086 subdevice: 05fe

Small mistake in the commit message. Red Hat (Qumranet) vendor ID is =
1af4, virtio-net device ID is 1041.
Should be:
PF: vendor: 1af4 device: 1041 subvendor: 8086 subdevice: 15fe
VF: vendor: 1af4 device: 1041 subvendor: 8086 subdevice: 05fe

Best regards,
Yan.

>=20
> The patch needs no check for device ID, because the callback will
> never be made for devices that do not assert the capability or
> when run on a platform incapable of SR-IOV.
>=20
> One reason for this patch is because the hardware requires the
> vendor ID of a VF to be the same as the vendor ID of the PF that
> created it. So it seemed logical to simply have a fully-functioning
> virtio-net PF create the VFs. This patch makes that possible.
>=20
> Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
> Reviewed-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
> Changes in V2:
> - Simplified logic from previous version, removed added driver =
variable
> - Disable SR-IOV on driver removal excapt when VFs are assigned
> - Sent as RFC to virtio-dev, linux-pci, netdev, lkml and others
> ---
> drivers/virtio/virtio_pci_common.c |   47 =
++++++++++++++++++++++++++++++++++++
> 1 file changed, 47 insertions(+)
>=20
> diff --git a/drivers/virtio/virtio_pci_common.c =
b/drivers/virtio/virtio_pci_common.c
> index 48d4d1cf1cb6..78b53ffc4cee 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -572,6 +572,47 @@ static int virtio_pci_probe(struct pci_dev =
*pci_dev,
> 	return rc;
> }
>=20
> +#ifdef CONFIG_PCI_IOV
> +static int virtio_pci_sriov_disable(struct pci_dev *pci_dev)
> +{
> +	/* If vfs are assigned we cannot shut down SR-IOV without =
causing
> +	 * issues, so just leave the hardware available.
> +	 */
> +	if (pci_vfs_assigned(pci_dev)) {
> +		dev_warn(&pci_dev->dev,
> +			 "Unloading driver while VFs are assigned - VFs =
will not be deallocated\n");
> +		return -EPERM;
> +	}
> +	pci_disable_sriov(pci_dev);
> +	return 0;
> +}
> +
> +static int virtio_pci_sriov_enable(struct pci_dev *pci_dev, int =
num_vfs)
> +{
> +	int rc =3D 0;
> +
> +	if (pci_num_vf(pci_dev))
> +		return -EINVAL;
> +
> +	rc =3D pci_enable_sriov(pci_dev, num_vfs);
> +	if (rc) {
> +		dev_warn(&pci_dev->dev, "Failed to enable PCI sriov: =
%d\n", rc);
> +		return rc;
> +	}
> +	dev_info(&pci_dev->dev, "SR-IOV enabled with %d VFs\n", =
num_vfs);
> +	return num_vfs;
> +}
> +
> +static int virtio_pci_sriov_configure(struct pci_dev *dev, int =
num_vfs)
> +{
> +	if (num_vfs)
> +		return virtio_pci_sriov_enable(dev, num_vfs);
> +	if (!pci_num_vf(dev))
> +		return -EINVAL;
> +	return virtio_pci_sriov_disable(dev);
> +}
> +#endif /* CONFIG_PCI_IOV */
> +
> static void virtio_pci_remove(struct pci_dev *pci_dev)
> {
> 	struct virtio_pci_device *vp_dev =3D pci_get_drvdata(pci_dev);
> @@ -584,6 +625,9 @@ static void virtio_pci_remove(struct pci_dev =
*pci_dev)
> 	else
> 		virtio_pci_modern_remove(vp_dev);
>=20
> +#ifdef CONFIG_PCI_IOV
> +	virtio_pci_sriov_disable(pci_dev);
> +#endif
> 	pci_disable_device(pci_dev);
> 	put_device(dev);
> }
> @@ -596,6 +640,9 @@ static void virtio_pci_remove(struct pci_dev =
*pci_dev)
> #ifdef CONFIG_PM_SLEEP
> 	.driver.pm	=3D &virtio_pci_pm_ops,
> #endif
> +#ifdef CONFIG_PCI_IOV
> +	.sriov_configure =3D virtio_pci_sriov_configure,
> +#endif
> };
>=20
> module_pci_driver(virtio_pci_driver);
>=20
>=20
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>=20


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

