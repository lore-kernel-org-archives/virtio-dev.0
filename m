Return-Path: <virtio-dev-return-9020-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6CA4A983E07
	for <virtio-dev@lists.oasis-open.org>; Wed, 12 Jan 2022 10:42:16 +0000 (UTC)
Date: Wed, 12 Jan 2022 10:41:43 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <Yd6wZ2WMP0FMXWh8@stefanha-x1.localdomain>
References: <20220112055755.41011-1-jasowang@redhat.com>
 <20220112055755.41011-3-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220112055755.41011-3-jasowang@redhat.com>
Subject: [virtio-dev] Re: [PATCH V2 2/2] virtio-pci: add PASID configuration extended
 capability
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BWUQRZso5osEuxFU"
Content-Disposition: inline
To: Jason Wang <jasowang@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, mst@redhat.com, eperezma@redhat.com, lulu@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

--BWUQRZso5osEuxFU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 12, 2022 at 01:57:55PM +0800, Jason Wang wrote:
> This patch tries to add PASID configuration structure. It is used for
> assigning PASID to virtqueue then the device use PASID TLP prefix for
> the PCI transactions like DMA. The goal is to isolate e.g DMA at
> subdevice level which could be used for things like:
>=20
> - direct queue assignment to userspace
> - virtqueue virtualization
> - presenting multiple vDPA devices within a single PCI device
>=20
> The virtqueue group is introduced as an intermediate layer for having
> better compatibility and flexibility. The virtqueue group is the
> minimal set of the virtqueues that can be assigned with a single
> PASID. The PASID is then assigned at the level of virtqueue group
> instead of the virtqueue itself.
>=20
> For a full PASID capable hardware, it can simply advertise a model
> of 1:1 mapping of the virtqueue and virtqueue group. For the device
> with mediated virtqueues, it can choose to place the mediated
> virtqueues into dedicated virtqueue group(s).
>=20
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  content.tex | 121 +++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 119 insertions(+), 2 deletions(-)
>=20
> diff --git a/content.tex b/content.tex
> index 00a75f2..552c0a8 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -1516,8 +1516,14 @@ \subsection{Virtio Structure PCI Extended Capabili=
ties}\label{sec:Virtio Transpo
>          PCI Express extended configuration space.
> =20
>  \item[\field{cfg_type}]
> -        Identifies the structure. All values are reserved for future
> -        use.
> +        Identifies the structure. according to the following table:
> +
> +\begin{lstlisting}
> +/* PASID configuration */
> +#define VIRTIO_PCI_ECAP_PASID_CFG        1
> +\end{lstlisting}
> +
> +        Any other value is reserved for future use.
> =20
>          The device MAY offer more than one structure of any type - this =
makes it
>          possible for the device to expose multiple interfaces to drivers=
.  The order of
> @@ -1599,6 +1605,117 @@ \subsection{Virtio Structure PCI Extended Capabil=
ities}\label{sec:Virtio Transpo
>  If the device presents multiple structures of the same type, it SHOULD o=
rder
>  them from optimal (first) to least-optimal (last).
> =20
> +\subsubsection{PASID configuration structure layout}
> +
> +The PASID configuration structure is found at the \field{bar} and
> +\field{offset} within the VIRTIO_PCI_ECAP_PASID_CFG extended

It looks like PCI Extended Capabilities have a different namespace from
classic PCI Capabilities (VIRTIO_PCI_**ECAP**_PASID_CFG). If a device
runs out of PCI Configuration Space it will be unable to define
additional capabilities as PCI Extended Capabilities. At least I'm not
aware of VIRTIO_PCI_ECAP_* definitions for existing capabilities. If the
point is to help with PCI Configuration Space exhaustion, should all
capabilities be defined in the same namespace so they can be trivially
defined as either PCI Capabilities or PCI Extended Capabilities?

(Maybe I misunderstood the purpose of adding PCI Extended Capabilities?)

> +capability; its layout is below.
> +
> +\begin{lstlisting}
> +struct virtio_pci_common_cfg {

The struct name looks like it was copy-pasted. Should this be struct
virtio_pci_group_cfg?

> +        /* About the whole device. */
> +        le16 groups;                   /* read-only for driver */
> +        /* About a specific virtqueue */
> +        le16 queue_select;             /* read-write */
> +        le16 group_id;                 /* read-only for driver */
> +        /* About a specific virtqueue group */
> +        le16 group_select;             /* read-write */
> +        le32 group_pasid;              /* read-write */
> +}
> +\end{lstlisting}
> +
> +\begin{description}
> +\item[\field{groups}]
> +        The device specifies the number of virtqueue groups here. A
> +        virtqueue group is the minimal set of the virtqueues that can
> +        be assigned with a single PASID.
> +
> +\item[\field{queue_select}]
> +        Queue Select. The driver selects which virtqueue the
> +        \field{group_id} refers to.
> +
> +\item[\field{group_id}]
> +        Virtqueue Group Identifier. The device specify the virtqueue
> +        group identifier that the virtqueue belongs to.
> +
> +\item[\field{group_select}]
> +        Virtqueue Group Select. The driver selects which virtqueue
> +        group the field{group_pasid} refers to.
> +
> +\item[\field{group_pasid}]
> +        Virtqueue Group PASID. The driver use this field to assign a
> +        PASID to a virtqueue group.
> +\end{description}

The queue_select/group_select interface makes me wonder if an admin
virtqueue interface would be better. The driver is forced to scan
virtqueues and groups, and each access requires a vmexit. An admin
virtqueue interface would allow a more efficient DMA interface where all
virtqueues/groups can be queried or set in a single operation.

Luckily this interface is only used at initialization time, but I
sometimes still wonder if it's scalable enough.

> +
> +\paragraph{PASID Configuration}
> +
> +When PASID extended capability is present and enabled in the device
> +(through the standard PCI Extended configuration space). To assign a
> +PASID to a specific virtqueue group. The driver need to perform the
> +following steps:

This paragraph is a single sentence, the full stops ('.') are used more
like commas (','). I suggest shortening it like this:

  When the PCI PASID Extended Capability is present and enabled, the
  driver performs the following steps to assign a PASID to a virtqueue
  group:

(I also used explicit "PCI PASID Extended Capability" naming so it's
clear we're talking about a formal term defined in the PCI
specification.)

> +
> +\begin{enumerate}
> +\item Identify the number of groups by reading \field{groups}
> +
> +\item Identify the virtqueue group for a specific virtqueue by first
> +  writing the index of the virtqueue to \field{queue_select} then
> +  reading its virtqueue group identifier from \field{group_id}.
> +
> +\item Determine number of PASIDs and the PASID that will be associated
> +  for each virtqueue group.
> +
> +\item Assign PASID to virtqueue groups by first writing the
> +  virtqueue group ID to \field{group_select} then writing the valid
> +  PASID number that assigned to the virtqueue group to
> +  \field{group_pasid}

  \item Assign PASIDs to virtqueue groups by first writing the
    virtqueue group ID to \field{group_select} and then writing a valid
    PASID number to assign to that group to \field{group_pasid}.

> +\end{enumerate}
> +
> +To disable PASID for a virtqueue group, the driver write a special
> +NO_PASID value:

  The driver writes the special VIRTIO_PASID_NO_ID value to disable
  PASID for a virtqueue group:

> +
> +\begin{lstlisting}
> +/* PASID value used to disable PASID for virtqueue group */
> +#define VIRTIO_PASID_NO_ID            0xffffffff
> +\end{lstlisting}
> +
> +\drivernormative{\subsubsection}{PASID configuration structure layout}{V=
irtio Transport Options / Virtio Over PCI Bus / PASID configuration structu=
re layout}
> +
> +Except for VIRTIO_PASID_NO_ID, a driver MUST NOT attempt to assign a
> +PASID number outside the range that is defined in the \field{Max PASID W=
idth}
> +in the PASID Extended Capability.
> +
> +After assigning a PASID to a virtqueue group, the driver MUST verify
> +the success by reading the Virtqueue Group PASID: on success, the
> +previously written value is returned, and on failure
> +VIRTIO_PASID_NO_ID is returned. If a mapping failure is detected, the
> +driver MAY retry assigning with fewer PASIDs, disable PASID or report
> +device failure.
> +
> +\devicenormative{\subsubsection}{PASID configuration structure layout}{V=
irtio Transport Options / Virtio Over PCI Bus / PASID configuration structu=
re layout}
> +
> +The device MUST support at least one virtqueue group if it offers
> +PASID configuration structure.

  the PASID configuration structure.

("a" would be okay too but leaves open the possibility of multiple PASID
configuration structures, which I think we don't want.)

> +
> +The device MUST supply virtqueue group identifiers continuously from
> +number zero up to the number of virtqueue groups minus one. For

s/number zero/the number zero/

> +example, if the device has 4 virtqueue groups, the group ids should be

To avoid using "should":
s/should be/are/

> +0, 1, 2, 3.

/, 3/, and 3/

> +
> +The device MUST make sure all the previous PCIe transactions for the
> +virtqueue group is completed before presenting the new PASID value

s/transactions ... is completed/transactions ... are completed/

> +wrote to the drvier in \field{group_pasid}.

This is ambiguous. It leaves open the possibility that group_pasid
updates at a later point in time instead of immediately after a write by
the driver. My interpretation is that the device must respond
immediately by presenting the new PASID or VIRTIO_PASID_NO_ID when the
driver reads back group_pasid after a write. If you agree, please
rephrase this clause to make it clear that reading group_pasid after
write acts like a barrier (previous PCIe transactions must complete
before the device responds to the read) and the device is not allowed to
present the old group_pasid value until all transactions are completed
and then present the new group_pasid value.

> +
> +The device MUST use PASID TLP prefix for all memory transactions
> +belongs to a virtqueue group if a valid PASID is assigned and PASID is

s/belongs/belonging/

> +enabled in the PASID extended capability.

This statement is vague. Which memory transactions "belong to a
virtqueue group"? vring reads/writes and data buffer reads/writes come
to mind. Virtqueue MSI-X messages are probably not included? Anything
else?

> +
> +The device MUST NOT use PASID TLP prefix for any memory transaction
> +belongs to a virtqueue group if VIRTIO_PASID_NO_ID is assigned or
> +PASID is not enabled in the PASID extended capability.
> +
> +Upon reset, the device MUST present VIRTIO_PASID_NO_ID in
> +\field{group_pasid} for each virtqueue group.
> +
>  \subsection{PCI-specific Initialization And Device Operation}\label{sec:=
Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initializatio=
n And Device Operation}
> =20
>  \subsubsection{Device Initialization}\label{sec:Virtio Transport Options=
 / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation /=
 Device Initialization}
> --=20
> 2.32.0 (Apple Git-132)
>=20

--BWUQRZso5osEuxFU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmHesGcACgkQnKSrs4Gr
c8hJBAgAsXtkP/yrDFR7nBx4EpKgKeqelvLom5R5ocsxDCz1mucF5m4Jq3G38F16
A+wE2dJjozFTHGV3kOxUDepRyW2whxqHdEzGhiJ3tjZgVVFYer1UdZQnH7HMyJhc
9XLk/q+Beyyx4i8pEjJCG5Y+fQD3r6BUwaPtNIlGTqm4qAae2oIsLEI163SmWBds
A0BviTHEW0Rqag734R0TfRuP46rvI0MGAxe676rNEQ3YLEi3WIudLMbmf/r+Id/P
BP7zXvRBvEUUn348XZIJAiUlEf2jlXmGlP+mL7Vy8X51SlcTs2yUqOvFpjh1RgYo
RMp3VzdfnHKKt6/ecGDJYHl4mkhkfA==
=th25
-----END PGP SIGNATURE-----

--BWUQRZso5osEuxFU--

