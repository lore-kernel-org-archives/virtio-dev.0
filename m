Return-Path: <virtio-dev-return-9048-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4CA6A986508
	for <virtio-dev@lists.oasis-open.org>; Fri, 14 Jan 2022 13:39:57 +0000 (UTC)
Date: Fri, 14 Jan 2022 08:39:50 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20220114082838-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Subject: [virtio-dev] spec inconsistency: Device Configuration Interrupt bit in ISR status
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, "Zhu, Lingshan" <lingshan.zhu@intel.com>
Cc: jasowang@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

The spec says (v1.1 4.1.4.5 ISR status capability):

The VIRTIO_PCI_CAP_ISR_CFG capability refers to at least a single byte, whi=
ch contains the 8=C2=ADbit ISR
status field to be used for INT#x interrupt handling.

and

to avoid an extra access, simply reading this register resets it to 0 and c=
auses the device to de=C2=ADassert the
interrupt.
In this way, driver read of ISR status causes the device to de=C2=ADassert =
an interrupt.

See sections 4.1.5.3 and 4.1.5.4 for how this is used.

and in 4.1.5.4 Notification of Device Configuration Changes

it says:

=E2=80=A2 If MSI=C2=ADX capability is disabled:
1. Set the second lower bit of the ISR Status field for the device.
2. Send the appropriate PCI interrupt for the device.

If MSI=C2=ADX capability is enabled:
1. If config_msix_vector is not NO_VECTOR, request the appropriate MSI=C2=
=ADX interrupt message for
the device, config_msix_vector sets the MSI=C2=ADX Table entry number.

all of the above make it looks like VIRTIO_PCI_CAP_ISR_CFG capability is
unused with MSIX.

This was actually the way the spec was understood by
Zhu Lingshan from Intel (Cc'd).

However, looking at the conformance statements, one finds out this is
not the case:

4.1.4.5.1 Device Requirements: ISR status capability


The device MUST present at least one VIRTIO_PCI_CAP_ISR_CFG capability.
The device MUST set the Device Configuration Interrupt bit in ISR status be=
fore sending a device configu=C2=AD
ration change notification to the driver.
If MSI=C2=ADX capability is disabled, the device MUST set the Queue Interru=
pt bit in ISR status before sending a
virtqueue notification to the driver.

which implies that the Device Configuration Interrupt bit is set unconditio=
nally.



It is unfortunate that it does not copy this requirement in more places,
and that the non-conformance text is incomplete and does not
mention the MSI-X usage at all.

I propose to extend 4.1.4.5 ISR status capability and=20
4.1.5.4 Notification of Device Configuration Changes
to mention the MSI use.

--=20
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

