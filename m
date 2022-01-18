Return-Path: <virtio-comment-return-2569-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Tue, 18 Jan 2022 01:25:23 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20220118012434-mutt-send-email-mst@kernel.org>
References: <20220114082838-mutt-send-email-mst@kernel.org>
 <ce300681-01f1-3b7a-b3db-fe545b9073b7@redhat.com>
 <20220117025648-mutt-send-email-mst@kernel.org>
 <CACGkMEv7PQKxJ5R_WE1Qphq8cq3GpZNpYxntP5E8A2e_iv22zA@mail.gmail.com>
 <e694e330-82a0-53c2-36b8-7d25885e4a97@intel.com>
MIME-Version: 1.0
In-Reply-To: <e694e330-82a0-53c2-36b8-7d25885e4a97@intel.com>
Subject: [virtio-comment] Re: spec inconsistency: Device Configuration Interrupt bit in ISR
 status
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>
Cc: Jason Wang <jasowang@redhat.com>, virtio-comment@lists.oasis-open.org, Virtio-Dev <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Jan 18, 2022 at 11:12:43AM +0800, Zhu, Lingshan wrote:
>=20
>=20
> On 1/18/2022 11:01 AM, Jason Wang wrote:
>=20
>     On Mon, Jan 17, 2022 at 3:57 PM Michael S. Tsirkin <mst@redhat.com> w=
rote:
>=20
>         On Mon, Jan 17, 2022 at 02:15:55PM +0800, Jason Wang wrote:
>=20
>             =E5=9C=A8 2022/1/14 =E4=B8=8B=E5=8D=889:39, Michael S. Tsirki=
n =E5=86=99=E9=81=93:
>=20
>                 The spec says (v1.1 4.1.4.5 ISR status capability):
>=20
>                 The VIRTIO_PCI_CAP_ISR_CFG capability refers to at least =
a single byte, which contains the 8=C2=ADbit ISR
>                 status field to be used for INT#x interrupt handling.
>=20
>                 and
>=20
>                 to avoid an extra access, simply reading this register re=
sets it to 0 and causes the device to de=C2=ADassert the
>                 interrupt.
>                 In this way, driver read of ISR status causes the device =
to de=C2=ADassert an interrupt.
>=20
>                 See sections 4.1.5.3 and 4.1.5.4 for how this is used.
>=20
>                 and in 4.1.5.4 Notification of Device Configuration Chang=
es
>=20
>                 it says:
>=20
>                 =E2=80=A2 If MSI=C2=ADX capability is disabled:
>                 1. Set the second lower bit of the ISR Status field for t=
he device.
>                 2. Send the appropriate PCI interrupt for the device.
>=20
>                 If MSI=C2=ADX capability is enabled:
>                 1. If config_msix_vector is not NO_VECTOR, request the ap=
propriate MSI=C2=ADX interrupt message for
>                 the device, config_msix_vector sets the MSI=C2=ADX Table =
entry number.
>=20
>                 all of the above make it looks like VIRTIO_PCI_CAP_ISR_CF=
G capability is
>                 unused with MSIX.
>=20
>                 This was actually the way the spec was understood by
>                 Zhu Lingshan from Intel (Cc'd).
>=20
>                 However, looking at the conformance statements, one finds=
 out this is
>                 not the case:
>=20
>                 4.1.4.5.1 Device Requirements: ISR status capability
>=20
>=20
>                 The device MUST present at least one VIRTIO_PCI_CAP_ISR_C=
FG capability.
>                 The device MUST set the Device Configuration Interrupt bi=
t in ISR status before sending a device configu=C2=AD
>                 ration change notification to the driver.
>                 If MSI=C2=ADX capability is disabled, the device MUST set=
 the Queue Interrupt bit in ISR status before sending a
>                 virtqueue notification to the driver.
>=20
>                 which implies that the Device Configuration Interrupt bit=
 is set unconditionally.
>=20
>=20
>=20
>                 It is unfortunate that it does not copy this requirement =
in more places,
>                 and that the non-conformance text is incomplete and does =
not
>                 mention the MSI-X usage at all.
>=20
>                 I propose to extend 4.1.4.5 ISR status capability and
>                 4.1.5.4 Notification of Device Configuration Changes
>                 to mention the MSI use.
>=20
> I agree to expand ISR cap usage to MSI(MSIX) usage with clear description=
s,
> and remove the limitations to MSIX. E.g,:
> 4.1.4.5.2 Driver Requirements: ISR status capability
> If MSI-X capability is enabled, the driver SHOULD NOT access ISR status u=
pon
> detecting a Queue Interrupt.
>=20
> Thanks
>=20

No, we actually need that for bypass. Only config interrupts set ISR.

I will need to send a patch, people are still confused.


>             I wonder do we want
>=20
>             1) mandate ISR bit
>=20
>             or
>=20
>             2) remove the ISR bit set for MSI mode?
>=20
>             1) is the current Qemu behavior but seems a little bit contra=
dict with the
>             goal of MSI.
>=20
>             Thanks
>=20
>=20
>=20
>         I think we want the ISR bit
>=20
>     This means there's no chance to use fast irq path but since it's a
>     less frequent operation. It should be fine.
>=20
>     Thanks
>=20
>=20
>         since otherwise we need to go read
>         a ton of config space fields to check whether anything changed.
>=20
>         --
>         MST
>=20
>=20
>=20


This publicly archived list offers a means to provide input to the
OASIS Virtual I/O Device (VIRTIO) TC.

In order to verify user consent to the Feedback License terms and
to minimize spam in the list archive, subscription is required
before posting.

Subscribe: virtio-comment-subscribe@lists.oasis-open.org
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
List help: virtio-comment-help@lists.oasis-open.org
List archive: https://lists.oasis-open.org/archives/virtio-comment/
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lis=
ts
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

