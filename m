Return-Path: <virtio-comment-return-2551-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Message-ID: <ce300681-01f1-3b7a-b3db-fe545b9073b7@redhat.com>
Date: Mon, 17 Jan 2022 14:15:55 +0800
MIME-Version: 1.0
References: <20220114082838-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220114082838-mutt-send-email-mst@kernel.org>
Subject: [virtio-comment] Re: spec inconsistency: Device Configuration Interrupt bit in ISR
 status
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, "Zhu, Lingshan" <lingshan.zhu@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>


=E5=9C=A8 2022/1/14 =E4=B8=8B=E5=8D=889:39, Michael S. Tsirkin =E5=86=99=E9=
=81=93:
> The spec says (v1.1 4.1.4.5 ISR status capability):
>
> The VIRTIO_PCI_CAP_ISR_CFG capability refers to at least a single byte, w=
hich contains the 8=C2=ADbit ISR
> status field to be used for INT#x interrupt handling.
>
> and
>
> to avoid an extra access, simply reading this register resets it to 0 and=
 causes the device to de=C2=ADassert the
> interrupt.
> In this way, driver read of ISR status causes the device to de=C2=ADasser=
t an interrupt.
>
> See sections 4.1.5.3 and 4.1.5.4 for how this is used.
>
> and in 4.1.5.4 Notification of Device Configuration Changes
>
> it says:
>
> =E2=80=A2 If MSI=C2=ADX capability is disabled:
> 1. Set the second lower bit of the ISR Status field for the device.
> 2. Send the appropriate PCI interrupt for the device.
>
> If MSI=C2=ADX capability is enabled:
> 1. If config_msix_vector is not NO_VECTOR, request the appropriate MSI=C2=
=ADX interrupt message for
> the device, config_msix_vector sets the MSI=C2=ADX Table entry number.
>
> all of the above make it looks like VIRTIO_PCI_CAP_ISR_CFG capability is
> unused with MSIX.
>
> This was actually the way the spec was understood by
> Zhu Lingshan from Intel (Cc'd).
>
> However, looking at the conformance statements, one finds out this is
> not the case:
>
> 4.1.4.5.1 Device Requirements: ISR status capability
>
>
> The device MUST present at least one VIRTIO_PCI_CAP_ISR_CFG capability.
> The device MUST set the Device Configuration Interrupt bit in ISR status =
before sending a device configu=C2=AD
> ration change notification to the driver.
> If MSI=C2=ADX capability is disabled, the device MUST set the Queue Inter=
rupt bit in ISR status before sending a
> virtqueue notification to the driver.
>
> which implies that the Device Configuration Interrupt bit is set uncondit=
ionally.
>
>
>
> It is unfortunate that it does not copy this requirement in more places,
> and that the non-conformance text is incomplete and does not
> mention the MSI-X usage at all.
>
> I propose to extend 4.1.4.5 ISR status capability and
> 4.1.5.4 Notification of Device Configuration Changes
> to mention the MSI use.


I wonder do we want

1) mandate ISR bit

or

2) remove the ISR bit set for MSI mode?

1) is the current Qemu behavior but seems a little bit contradict with=20
the goal of MSI.

Thanks


>


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

