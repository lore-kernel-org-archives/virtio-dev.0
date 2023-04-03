Return-Path: <virtio-dev-return-11887-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A96E4C761A6
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 14:45:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 08A0277E4
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 14:45:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DD8D39863EF
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 14:45:29 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C75A69863D6; Mon,  3 Apr 2023 14:45:29 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B58359863DD
	for <virtio-dev@lists.oasis-open.org>; Mon,  3 Apr 2023 14:45:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: E6WhJ0hLMM-Lel2uH2G9WQ-1
Date: Mon, 3 Apr 2023 10:45:23 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: mst@redhat.com, virtio-dev@lists.oasis-open.org, cohuck@redhat.com,
	virtio-comment@lists.oasis-open.org, shahafs@nvidia.com
Message-ID: <20230403144523.GC302168@fedora>
References: <20230330225834.506969-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1a6AGOtXMwSQZ4Bx"
Content-Disposition: inline
In-Reply-To: <20230330225834.506969-1-parav@nvidia.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Subject: [virtio-dev] Re: [virtio-comment] [PATCH 00/11] Introduce transitional mmr pci
 device

--1a6AGOtXMwSQZ4Bx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 31, 2023 at 01:58:23AM +0300, Parav Pandit wrote:
> Overview:
> ---------
> The Transitional MMR device is a variant of the transitional PCI device.

What does "MMR" mean?

> It has its own small Device ID range. It does not have I/O
> region BAR; instead it exposes legacy configuration and device
> specific registers at an offset in the memory region BAR.
>=20
> Such transitional MMR devices will be used at the scale of
> thousands of devices using PCI SR-IOV and/or future scalable
> virtualization technology to provide backward
> compatibility (for legacy devices) and also future
> compatibility with new features.
>=20
> Usecase:
> --------
> 1. A hypervisor/system needs to provide transitional
>    virtio devices to the guest VM at scale of thousands,
>    typically, one to eight devices per VM.
>=20
> 2. A hypervisor/system needs to provide such devices using a
>    vendor agnostic driver in the hypervisor system.

Is the idea that the hypervisor configures the new Transitional MMR
devices and makes them appear like virtio-pci Transitional devices?

In other words, the guest doesn't know about Transitional MMR and does
not need any code changes.

> 3. A hypervisor system prefers to have single stack regardless of
>    virtio device type (net/blk) and be future compatible with a
>    single vfio stack using SR-IOV or other scalable device
>    virtualization technology to map PCI devices to the guest VM.
>    (as transitional or otherwise)

What does this paragraph mean?

>=20
> Motivation/Background:
> ----------------------
> The existing transitional PCI device is missing support for
> PCI SR-IOV based devices. Currently it does not work beyond
> PCI PF, or as software emulated device in reality. It currently
> has below cited system level limitations:
>=20
> [a] PCIe spec citation:
> VFs do not support I/O Space and thus VF BARs shall not
> indicate I/O Space.
>=20
> [b] cpu arch citiation:
> Intel 64 and IA-32 Architectures Software Developer=E2=80=99s Manual:
> The processor=E2=80=99s I/O address space is separate and distinct from
> the physical-memory address space. The I/O address space consists
> of 64K individually addressable 8-bit I/O ports, numbered 0 through FFFFH.
>=20
> [c] PCIe spec citation:
> If a bridge implements an I/O address range,...I/O address range
> will be aligned to a 4 KB boundary.
>=20
> [d] I/O region accesses at PCI system level is slow as they are non-posted
> operations in PCIe fabric.
>=20
> The usecase requirements and limitations above can be solved by
> extending the transitional device, mapping legacy and device
> specific configuration registers in a memory PCI BAR instead
> of using non composable I/O region.
>=20
> Please review.

Modern devices were added to Linux in 2014 and support SR-IOV. Why is it
important to support Transitional (which really means Legacy devices,
otherwise Modern devices would be sufficient)?

>=20
> Patch summary:
> --------------
> patch 1 to 5 prepares the spec
> patch 6 to 11 defines transitional mmr device
>=20
> patch-1 uses lower case alphabets to name device id
> patch-2 move transitional device id in legay section along with
>         revision id
> patch-3 splits legacy feature bits description from device id
> patch-4 rename and moves virtio config registers next to 1.x
>         registers section
> patch-5 Adds missing helper verb in terminology definitions
> patch-6 introduces transitional mmr device
> patch-7 introduces transitional mmr device pci device ids
> patch-8 introduces virtio extended pci capability
> patch-9 describes new pci capability to locate legacy mmr
>         registers
> patch-10 extended usage of driver notification capability for
>          the transitional mmr device
> patch-11 adds conformance section of the transitional mmr device
>=20
> This design and details further described below.
>=20
> Design:
> -------
> Below picture captures the main small difference between current
> transitional PCI SR-IOV VF and transitional MMR SR-IOV VF.
>=20
> +------------------+ +--------------------+ +--------------------+
> |virtio 1.x        | |Transitional        | |Transitional        |
> |SRIOV VF          | |SRIOV VF            | |MMR SRIOV VF        |
> |                  | |                    | |                    |
> ++---------------+ | ++---------------+   | ++---------------+   |
> ||dev_id =3D       | | ||dev_id =3D       |   | ||dev_id =3D       |   |
> ||{0x1040-0x106C}| | ||{0x1000-0x103f}|   | ||{0x10f9-0x10ff}|   |
> |+---------------+ | |+---------------+   | |+---------------+   |
> |                  | |                    | |                    |
> |+------------+    | |+------------+      | |+-----------------+ |
> ||Memory BAR  |    | ||Memory BAR  |      | ||Memory BAR       | |
> |+------------+    | |+------------+      | ||                 | |
> |                  | |                    | || +--------------+| |
> |                  | |+-----------------+ | || |legacy virtio || |
> |                  | ||IOBAR impossible | | || |+ dev cfg     || |
> |                  | |+-----------------+ | || |registers     || |
> |                  | |                    | || +--------------+| |
> |                  | |                    | |+-----------------+ |
> +------------------+ +--------------------+ +--------------------+
>=20
> Here transitional MMR SR-IOV VF has legacy configuration and
> legacy device specific registers located at an offset in the memory
> region BAR.
>=20
> A memory region can be dedicated at BAR0 or it can be in an
> existing BAR, allowing flexibility when implementing support
> in a hardware device.
>=20
> Transitional MMR SR-IOV VFs use a distinct device ID range to that
> of existing virtio SR-IOV VFs to allow flexibility in driver
> binding.
>=20
> A more zoom-in version of transitional MMR SR-IOV device shows
> that the location of the legacy registers are discovered by the
> driver using a new capability.
>=20
> +------------------------------+
> |Transitional                  |
> |MMR SRIOV VF                  |
> |                              |
> ++---------------+             |
> ||dev_id =3D       |             |
> ||{0x10f9-0x10ff}|             |
> |+---------------+             |
> |                              |
> ++--------------------+        |
> || PCIe ext cap =3D 0xB |        |
> || cfg_type =3D 10      |        |
> || offset   =3D 0x1000  |        |
> || bar      =3D N {0..5}|        |
> |+--|-----------------+        |
> |   |                          |
> |   |                          |
> |   |    +-------------------+ |
> |   |    | Memory BAR =3D A    | |
> |   |    |                   | |
> |   +------>+--------------+ | |
> |        |  |legacy virtio | | |
> |        |  |+ dev cfg     | | |
> |        |  |registers     | | |
> |        |  +--------------+ | |
> |        +-----------------+ | |
> +------------------------------+
>=20
> Software usage:
> ---------------
> Transitional MMR device can be used by multiple ways.
>=20
> 1. The most common way to use and map to the guest VM is by
> using vfio driver framework in Linux kernel.
>=20
>                 +----------------------+
>                 |pci_dev_id =3D 0x100X   |
> +---------------|pci_rev_id =3D 0x0      |-----+
> |vfio device    |BAR0 =3D I/O region     |     |
> |               |Other attributes      |     |
> |               +----------------------+     |
> |                                            |
> +   +--------------+     +-----------------+ |
> |   |I/O to memory |     | Other vfio      | |
> |   |rd/wr mapper  |     | functionalities | |
> |   +--------------+     +-----------------+ |
> |                                            |
> +-------------------+------------------------+
>                     |
>        +------------+-----------------+
>        |         Transitional         |
>        |         MMR SRIOV VF         |
>        +------------------------------+
>=20
> 2. Virtio pci driver to bind to the listed device id and
>    use it as native device in the host.
>=20
> 3. Use it in a light weight hypervisor to run bare-metal OS.
>=20
> Parav Pandit (11):
>   transport-pci: Use lowecase alphabets
>   transport-pci: Move transitional device id to legacy section
>   transport-pci: Split notes of PCI Device Layout
>   transport-pci: Rename and move legacy PCI Device layout section
>   introduction: Add missing helping verb
>   introduction: Introduce transitional MMR interface
>   transport-pci: Introduce transitional MMR device id
>   transport-pci: Introduce virtio extended capability
>   transport-pci: Describe PCI MMR dev config registers
>   transport-pci: Use driver notification PCI capability
>   conformance: Add transitional MMR interface conformance
>=20
>  conformance.tex      |  11 +-
>  introduction.tex     |  34 +++-
>  tmmr-conformance.tex |  27 +++
>  transport-pci.tex    | 405 ++++++++++++++++++++++++++++++-------------
>  4 files changed, 354 insertions(+), 123 deletions(-)
>  create mode 100644 tmmr-conformance.tex
>=20
> --=20
> 2.26.2
>=20
>=20
> This publicly archived list offers a means to provide input to the
> OASIS Virtual I/O Device (VIRTIO) TC.
>=20
> In order to verify user consent to the Feedback License terms and
> to minimize spam in the list archive, subscription is required
> before posting.
>=20
> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> List help: virtio-comment-help@lists.oasis-open.org
> List archive: https://lists.oasis-open.org/archives/virtio-comment/
> Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
> List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-l=
ists
> Committee: https://www.oasis-open.org/committees/virtio/
> Join OASIS: https://www.oasis-open.org/join/
>=20

--1a6AGOtXMwSQZ4Bx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmQq5oMACgkQnKSrs4Gr
c8hkRQgAyOEYGJ/TsTFTNmsiYWiyzvcdQsHDp49U+q3x6o+g3Qg40Xprsk8LINap
VYpwByT8ZR1AYt3V9J5MvxiKvePbbuJaTKxN0dqoNu38UnwtG0b9cbcc+aa3R26u
i2jMvKjqYwi89q50kzynUWCvH6u5ZKtJWmBx55KnvlVds/7BCp0CfbKZDXYrDImv
MEmJNDYenjfnw1QUvo9X8qpwFGy33RK5nYMvxJkfNvhvwJVnaVAd4aJDCybQAc09
ZY7HO/WUvJH24ZYEpycD+U63Sv0RcXv6sigYlQwhcU96QkA2Xwmk5jrubvRje4Vw
wmFEpMOLc2bcNo8L3YoKQ3m/x8quLA==
=t5Z9
-----END PGP SIGNATURE-----

--1a6AGOtXMwSQZ4Bx--

