Return-Path: <virtio-dev-return-9062-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4265D9862D3
	for <virtio-dev@lists.oasis-open.org>; Mon, 17 Jan 2022 07:57:58 +0000 (UTC)
Date: Mon, 17 Jan 2022 02:57:50 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20220117025648-mutt-send-email-mst@kernel.org>
References: <20220114082838-mutt-send-email-mst@kernel.org>
 <ce300681-01f1-3b7a-b3db-fe545b9073b7@redhat.com>
MIME-Version: 1.0
In-Reply-To: <ce300681-01f1-3b7a-b3db-fe545b9073b7@redhat.com>
Subject: [virtio-dev] Re: spec inconsistency: Device Configuration Interrupt bit in ISR
 status
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
To: Jason Wang <jasowang@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, "Zhu, Lingshan" <lingshan.zhu@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Jan 17, 2022 at 02:15:55PM +0800, Jason Wang wrote:
>=20
> =E5=9C=A8 2022/1/14 =E4=B8=8B=E5=8D=889:39, Michael S. Tsirkin =E5=86=99=
=E9=81=93:
> > The spec says (v1.1 4.1.4.5 ISR status capability):
> >=20
> > The VIRTIO_PCI_CAP_ISR_CFG capability refers to at least a single byte,=
 which contains the 8=C2=ADbit ISR
> > status field to be used for INT#x interrupt handling.
> >=20
> > and
> >=20
> > to avoid an extra access, simply reading this register resets it to 0 a=
nd causes the device to de=C2=ADassert the
> > interrupt.
> > In this way, driver read of ISR status causes the device to de=C2=ADass=
ert an interrupt.
> >=20
> > See sections 4.1.5.3 and 4.1.5.4 for how this is used.
> >=20
> > and in 4.1.5.4 Notification of Device Configuration Changes
> >=20
> > it says:
> >=20
> > =E2=80=A2 If MSI=C2=ADX capability is disabled:
> > 1. Set the second lower bit of the ISR Status field for the device.
> > 2. Send the appropriate PCI interrupt for the device.
> >=20
> > If MSI=C2=ADX capability is enabled:
> > 1. If config_msix_vector is not NO_VECTOR, request the appropriate MSI=
=C2=ADX interrupt message for
> > the device, config_msix_vector sets the MSI=C2=ADX Table entry number.
> >=20
> > all of the above make it looks like VIRTIO_PCI_CAP_ISR_CFG capability i=
s
> > unused with MSIX.
> >=20
> > This was actually the way the spec was understood by
> > Zhu Lingshan from Intel (Cc'd).
> >=20
> > However, looking at the conformance statements, one finds out this is
> > not the case:
> >=20
> > 4.1.4.5.1 Device Requirements: ISR status capability
> >=20
> >=20
> > The device MUST present at least one VIRTIO_PCI_CAP_ISR_CFG capability.
> > The device MUST set the Device Configuration Interrupt bit in ISR statu=
s before sending a device configu=C2=AD
> > ration change notification to the driver.
> > If MSI=C2=ADX capability is disabled, the device MUST set the Queue Int=
errupt bit in ISR status before sending a
> > virtqueue notification to the driver.
> >=20
> > which implies that the Device Configuration Interrupt bit is set uncond=
itionally.
> >=20
> >=20
> >=20
> > It is unfortunate that it does not copy this requirement in more places=
,
> > and that the non-conformance text is incomplete and does not
> > mention the MSI-X usage at all.
> >=20
> > I propose to extend 4.1.4.5 ISR status capability and
> > 4.1.5.4 Notification of Device Configuration Changes
> > to mention the MSI use.
>=20
>=20
> I wonder do we want
>=20
> 1) mandate ISR bit
>=20
> or
>=20
> 2) remove the ISR bit set for MSI mode?
>=20
> 1) is the current Qemu behavior but seems a little bit contradict with th=
e
> goal of MSI.
>=20
> Thanks
>=20
>=20

I think we want the ISR bit since otherwise we need to go read
a ton of config space fields to check whether anything changed.

--=20
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

