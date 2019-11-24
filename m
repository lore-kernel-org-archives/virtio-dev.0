Return-Path: virtio-return-3399-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Sun, 24 Nov 2019 07:29:45 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20191124072923-mutt-send-email-mst@kernel.org>
References: <20191028161240.24806-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191028161240.24806-1-mst@redhat.com>
Subject: Re: [virtio] [PATCH] pci: strengthen requirement of the correct
 subsystem id
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: virtio@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Oct 28, 2019 at 12:12:49PM -0400, Michael S. Tsirkin wrote:
> If a hardware implementation of virtio does not have
> the correct subsystem id, then drivers can't report
> ir properly, or detect and work around bugs.
> Change the requirement from MAY to SHOULD.
>=20
> We can't make it a MUST since we did not require this
> historically.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/61

> ---
>  content.tex | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/content.tex b/content.tex
> index 4bcb728..8f1518c 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -562,7 +562,7 @@ \subsection{PCI Device Discovery}\label{sec:Virtio Tr=
ansport Options / Virtio Ov
>  For example, the network card device with the Virtio Device ID 1
>  has the PCI Device ID 0x1041 or the Transitional PCI Device ID 0x1000.
> =20
> -The PCI Subsystem Vendor ID and the PCI Subsystem Device ID MAY reflect
> +The PCI Subsystem Vendor ID and the PCI Subsystem Device ID SHOULD refle=
ct
>  the PCI Vendor and Device ID of the environment (for informational purpo=
ses by the driver).
> =20
>  Non-transitional devices SHOULD have a PCI Device ID in the range
> --=20
> MST
>=20
>=20
> ---------------------------------------------------------------------
> To unsubscribe from this mail list, you must leave the OASIS TC that
> generates this mail.  Follow this link to all your TCs in OASIS at:
> https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that=20
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php=20

