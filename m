Return-Path: virtio-return-3415-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Wed, 27 Nov 2019 16:17:29 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20191127161428-mutt-send-email-mst@kernel.org>
References: <20191028105508.31769-1-mst@redhat.com>
 <F1C6DEC9-5E4D-464A-A0C3-D8E625D53F7E@redhat.com>
MIME-Version: 1.0
In-Reply-To: <F1C6DEC9-5E4D-464A-A0C3-D8E625D53F7E@redhat.com>
Subject: [virtio] Re: [virtio-comment] [PATCH] content: add vendor specific cfg type
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Christophe de Dinechin <cdupontd@redhat.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Nov 27, 2019 at 03:54:17PM +0100, Christophe de Dinechin wrote:
>=20
>=20
> > On 28 Oct 2019, at 11:55, Michael S. Tsirkin <mst@redhat.com> wrote:
> >=20
> > Vendors might want to add their own capability
> > in the PCI capability list. However, Virtio already
> > uses the vendor specific capability ID (0x09)
> > for its own purposes.
> >=20
> > Provide a structure for vendor specific extensions.
> >=20
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> > content.tex | 80 +++++++++++++++++++++++++++++++++++++++++++++++++++++
> > 1 file changed, 80 insertions(+)
> >=20
> > diff --git a/content.tex b/content.tex
> > index b1ea9b9..8a79b03 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -691,6 +691,8 @@ \subsection{Virtio Structure PCI Capabilities}\labe=
l{sec:Virtio Transport Option
> > #define VIRTIO_PCI_CAP_PCI_CFG           5
> > /* Shared memory region */
> > #define VIRTIO_PCI_CAP_SHARED_MEMORY_CFG 8
> > +/* Vendor-specific data */
> > +#define VIRTIO_PCI_CAP_VENDOR_CFG        9
> > \end{lstlisting}
> >=20
> >         Any other value is reserved for future use.
> > @@ -1099,6 +1101,84 @@ \subsubsection{Shared memory capability}\label{s=
ec:Virtio Transport Options / Vi
> >=20
> > The \field{cap.id} MUST be unique for any one device instance.
> >=20
> > +\devicenormative{\paragraph}{Device-specific configuration}{Virtio Tra=
nsport Options / Virtio Over PCI Bus / PCI Device Layout / Shared memory ca=
pability}
> > +
> > +The region defined by the combination of the \field {cap.offset},
> > +\field {cap.offset_hi}, and \field {cap.length}, \field
> > +{cap.length_hi} fields MUST be contained within the declared bar.
>=20
> Uppercase BAR?

\field{bar} I think.

But really this is from "shared memory: Define PCI capability"
that I somehow failed to apply properly :(

> > +
> > +The \field{cap.id} MUST be unique for any one device instance.
> > +
> > +\subsubsection{Vendor data capability}\label{sec:Virtio
> > +Transport Options / Virtio Over PCI Bus / PCI Device Layout /
> > +Vendor data capability}
> > +
> > +The optional Vendor data capability allows the device to present
> > +vendor-specific data to the driver, without
> > +conflicts, for debugging and/or reporting purposes,
> > +and without conflicting with standard functionality.
> > +
> > +This capability augments but does not replace the standard
> > +subsystem ID and subsystem vendor ID fields
> > +(offsets 0x2C and 0x2E in the PCI configuration space header)
> > +as specified by \hyperref[intro:PCI]{[PCI]}.
> > +
> > +Vendor data capability is enumerated on the PCI transport
> > +as a VIRTIO_PCI_CAP_VENDOR_CFG capability.
> > +
> > +The capability has the following structure:
> > +\begin{lstlisting}
> > +struct virtio_pci_vndr_data {
> > +        u8 cap_vndr;    /* Generic PCI field: PCI_CAP_ID_VNDR */
> > +        u8 cap_next;    /* Generic PCI field: next ptr. */
> > +        u8 cap_len;     /* Generic PCI field: capability length */
> > +        u8 cfg_type;    /* Identifies the structure. */
> > +        u16 vendor_id;  /* Identifies the vendor-specific format. */
> > +=09/* For Vendor Definition */
> > +=09/* Pads structure to a multiple of 4 bytes */
> > +=09/* Reads must not have side effects */
> > +};
> > +\end{lstlisting}
> > +
> > +Where \field{vendor_id} identifies the PCI-SIG assigned Vendor ID
> > +as specified by \hyperref[intro:PCI]{[PCI]}.
> > +
> > +Note that the capability size is required to be a multiple of 4.
> > +
> > +To make it safe for a generic driver to access the capability,
> > +reads from this capability MUST NOT have any side effects.
>=20
> I think the intent is that this includes the capability payload, not
> just the generic fields. Worth spelling out?
>=20
> > +
> > +\devicenormative{\subsection}{Vendor data capability}{Virtio
> > +Transport Options / Virtio Over PCI Bus / PCI Device Layout /
> > +Vendor data capability}
> > +
> > +The device SHOULD present the PCI subsystem vendor ID matching
> > +the device vendor, at offset 0x2C in its PCI configuration space
> > +header.
> > +
> > +Devices CAN present \field{vendor_id} that does not match
> > +either the PCI Vendor ID or the PCI Subsystem Vendor ID.
> > +
> > +Devices CAN present multiple Vendor data capabilities with
> > +either different or identical \field{vendor_id} values.
> > +
> > +The value \field{vendor_id} MUST NOT equal 0x1AF4.
> > +
> > +The size of the Vendor data capability MUST be a multiple of 4 bytes.
> > +
> > +Reads of the Vendor data capability by the driver MUST NOT have any
> > +side effects.
> > +
> > +\drivernormative{\subsection}{Vendor data capability}{Virtio
> > +Transport Options / Virtio Over PCI Bus / PCI Device Layout /
> > +Vendor data capability}
> > +
> > +The driver SHOULD NOT use the Vendor data capability except
> > +for debugging and reporting purposes.
>=20
> What is the rationale for this restriction?
>=20
> For example, would it be OK for a vendor to expose the presence
> of a particular firmware bugfix, so that the driver could disable
> some bug workaround? You seem to hint that this is the intent
> in a later response, but on initial reading, it was not clear to me
> that such usage would fit under =E2=80=9Cdebugging=E2=80=9D or =E2=80=9Cr=
eporting=E2=80=9D.
>=20
> (I=E2=80=99m quite new here, so feel free to ignore if it=E2=80=99s clear=
 to everybody else)
>=20
>=20
> > +
> > +The driver MUST qualify the \field{vendor_id} before
> > +interpreting or writing into the Vendor data capability.
> > +
> > \subsubsection{PCI configuration access capability}\label{sec:Virtio Tr=
ansport Options / Virtio Over PCI Bus / PCI Device Layout / PCI configurati=
on access capability}
> >=20
> > The VIRTIO_PCI_CAP_PCI_CFG capability
> > --=20
> > MST
> >=20
> >=20
> > This publicly archived list offers a means to provide input to the
> > OASIS Virtual I/O Device (VIRTIO) TC.
> >=20
> > In order to verify user consent to the Feedback License terms and
> > to minimize spam in the list archive, subscription is required
> > before posting.
> >=20
> > Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> > Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> > List help: virtio-comment-help@lists.oasis-open.org
> > List archive: https://lists.oasis-open.org/archives/virtio-comment/
> > Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.p=
df
> > List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing=
-lists
> > Committee: https://www.oasis-open.org/committees/virtio/
> > Join OASIS: https://www.oasis-open.org/join/
> >=20


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that=20
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php=20

