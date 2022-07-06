Return-Path: <mst@redhat.com>
Date: Wed, 6 Jul 2022 08:23:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-comment] Re: [PATCH v5 1/7] Introduce device group
Message-ID: <20220706081205-mutt-send-email-mst@kernel.org>
References: <b2239b43-a542-2d54-ecb2-86c0f4e35dd0@nvidia.com>
 <87o7zvezkc.fsf@redhat.com>
 <152fa52f-23c3-b222-68f6-db42b4231144@nvidia.com>
 <CACGkMEsLRf+6PR8s0Vo2cv4ScMLBECtY+zDC2TSuov5NtPJVHQ@mail.gmail.com>
 <20220602024254-mutt-send-email-mst@kernel.org>
 <58349984-d638-31af-82e5-8cb0fff6b0fb@nvidia.com>
 <20220628144422-mutt-send-email-mst@kernel.org>
 <5db67816-b377-0367-0b47-72f3024f004f@nvidia.com>
 <20220706074142-mutt-send-email-mst@kernel.org>
 <d2e4fd9d-805a-c65a-8faa-9f4e210214a4@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <d2e4fd9d-805a-c65a-8faa-9f4e210214a4@nvidia.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: Jason Wang <jasowang@redhat.com>, Cornelia Huck <cohuck@redhat.com>, virtio-comment@lists.oasis-open.org, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Oren Duer <oren@nvidia.com>, Parav Pandit <parav@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Ariel Adam <aadam@redhat.com>, virtio@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jul 06, 2022 at 03:01:14PM +0300, Max Gurtovoy wrote:
>=20
> On 7/6/2022 2:42 PM, Michael S. Tsirkin wrote:
> > On Wed, Jul 06, 2022 at 02:25:52PM +0300, Max Gurtovoy wrote:
> > > > maybe add here "devices of this type use the Virtio PCI transport
> > > > (link)"
> > > >=20
> > > > I am not sure. Maybe we want a section about SR-IOV generally,
> > > > with mentions of the feature bit and the group type.
> > > > For now I think what you have is enough.
> > > Ok.
> > >=20
> > > So for now we won't=A0 add this.
> > Well adding a link can't hurt.
>=20
> Ok.
>=20
> Can you review the bellow please ? reviewed-by will be great..
>=20
> diff --git a/introduction.tex b/introduction.tex
> index aa9ec1b..c9ca978 100644
> --- a/introduction.tex
> +++ b/introduction.tex
> @@ -156,6 +156,21 @@ \subsection{Transition from earlier specification
> drafts}\label{sec:Transition f
> =A0sections tagged "Legacy Interface" in the section title.
> =A0These highlight the changes made since the earlier drafts.
>=20
> +\subsection{Device group}\label{sec:Introduction / Terminology / Device
> group}
> +
> +A device group includes one or more virtio devices.
> +Each virtio device has a unique group member identifier (group_member_id)
> within a device group. A valid group member identifier
> +is a 64-bit field

field->value

> in the range of 0x0 - 0xFFFFFFFFFFFFFFF0. Member
> identifier 0xFFFFFFFFFFFFFFFF is a value that

The value 0xFFFFFFFFFFFFFFFF

> refers to all devices in a
> +device group and isn't a valid group member identifier.
> +
> +For now, the supported device groups are:
> +\begin{enumerate}
> +\item SR-IOV type - this group includes a virtio PCI SR-IOV physical
> function (PF) and all its virtual functions (VFs).
> +For this group type, the PF device has group member identifier of 0. Each
> VF has a group member identifier matching it's VF number
> +(according to PCI Express Base Specification, Single Root I/O
> Virtualization and Sharing chapter). Devices that are members in this gro=
up
> use
> +the Virtio PCI transport (for more details see \ref{sec:Virtio Transport
> Options / Virtio Over PCI Bus}).
> +\end{enumerate}
> +
> =A0\section{Structure Specifications}\label{sec:Structure Specifications}
>=20
> =A0Many device and driver in-memory structure layouts are documented using


