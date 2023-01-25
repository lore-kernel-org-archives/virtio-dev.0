Return-Path: <virtio-comment-return-3906-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Wed, 25 Jan 2023 19:04:54 +0100
From: Halil Pasic <pasic@linux.ibm.com>
Message-ID: <20230125190454.043e54e0.pasic@linux.ibm.com>
In-Reply-To: <20230112212550.763889-1-parav@nvidia.com>
References: <20230112212550.763889-1-parav@nvidia.com>
MIME-Version: 1.0
Subject: Re: [virtio-comment] [PATCH v10] virtio-net: Clarify VLAN filter
 table configuration
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: Parav Pandit <parav@nvidia.com>
Cc: mst@redhat.com, virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org, si-wei.liu@oracle.com, Halil Pasic <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, 12 Jan 2023 23:25:50 +0200
Parav Pandit <parav@nvidia.com> wrote:

> The filtering behavior of the VLAN filter commands is not very clear as
> discussed in thread [1].
>=20
> Hence, add the command description and device requirements for it.
>=20
> [1] https://lists.oasis-open.org/archives/virtio-dev/202301/msg00210.html

Reference is wrong. This links an unrelated thread.

For reference see:

https://www.mail-archive.com/virtio-dev@lists.oasis-open.org/msg09424.html

[..]
@ -1194,7 +1194,11 @@ \subsubsection{Control Virtqueue}\label{sec:Device
Types / Network Device / Devi
>  \paragraph{VLAN Filtering}\label{sec:Device Types / Network Device / Dev=
ice Operation / Control Virtqueue / VLAN Filtering}
> =20
>  If the driver negotiates the VIRTIO_NET_F_CTRL_VLAN feature, it
> -can control a VLAN filter table in the device.
> +can control a VLAN filter table in the device. The VLAN filter
> +table applies only to VLAN tagged packets.
> +
> +When VIRTIO_NET_F_CTRL_VLAN is negotiated, the device starts with
> +an empty VLAN filter table.
> =20
>  \begin{note}
>  Similar to the MAC address based filtering, the VLAN filtering
> @@ -1210,6 +1214,22 @@ \subsubsection{Control Virtqueue}\label{sec:Device=
 Types / Network Device / Devi
>  Both the VIRTIO_NET_CTRL_VLAN_ADD and VIRTIO_NET_CTRL_VLAN_DEL
>  command take a little-endian 16-bit VLAN id as the command-specific-data=
.
> =20
[..]
> +
> +\devicenormative{\subparagraph}{VLAN Filtering}{Device Types / Network D=
evice / Device Operation / Control Virtqueue / VLAN Filtering}
> +
> +When VIRTIO_NET_F_CTRL_VLAN is not negotiated, the device MUST
> +accept all VLAN tagged packets as per the device configuration.


The story so far (other thread):

> > I find "as per the device configuration" difficult to comprehend. Maybe=
 we can
> > work on this with an editorial. What are you trying to express here? On=
 one
> > hand you say "the device MUST accept all VLAN tagged packets" on the ot=
her
> > hand "per the device configuration" may explain, or may relativize and =
restrict
> > that statement.
> >  =20
> From VLAN filtering perspective, it should accept all packets, but this i=
s subject to other device configuration such as MAC programming.
> The current one is fine that cover both the aspects to VLAN specific and =
other config.

IMHO you need to be explicit about this "From the VLAN filtering
perspective". A sub-case of "not negotiated" is "not offered because the
device does not support it" and in that case there is conceptually
no "VLAN filtering perspective".

> > Would
> > "When VIRTIO_NET_F_CTRL_VLAN is not negotiated, VLAN filtering is not
> > applied. I.e. VLAN tags are ignored by the device."
> > also work?
> > =20
> No. its not about ignoring "VLAN tags". Its about dealing with "packets" =
that starts with the VLAN tag.

I'm not sure I understand the difference.

Would just=20
"When VIRTIO_NET_F_CTRL_VLAN is not negotiated, no VLAN filtering is
done by the device."
work?

I don't like this "as per device configuration" formulation. If you
have multiple filtering mechanisms, like VLAN and MAC, and describe
all of these using this "as per device configuration", you would
end up with statements like:
"When feature F_X is not negotiated, the device MUST accept all
P_X packets as the per device configuration."
Where as per device configuration is supposed to cover all other
active filtering mechanisms except the one that is tied to F_X, but
exclude the mechanism that is tied to the feature F_X.

I'm also not convinced about the information content of "as per
device configuration". Kind of the complementer would be "contrary
to the device configuration" which does not make much sense. I would
also argue that we can add "as per device configuration" to most
of our  device normative statements. It would IMHO only decrease
clarity and increase the confusion. But if you ask yourself
is the behavior prescribed by an arbitrary device normative statemen "as
per device configuration" or not, I don't think one would ever answer
"no" to that question.

> +
> +When VIRTIO_NET_F_CTRL_VLAN is negotiated, the device MUST
> +accept all VLAN tagged packets whose VLAN tag is present in
> +the VLAN filter table and SHOULD drop all VLAN tagged packets
> +whose VLAN tag is absent in the VLAN filter table.

We could also add "as per device configuration" here as well...

From the other thread

On Mon, 23 Jan 2023 12:41:16 +0000
Parav Pandit <parav@nvidia.com> wrote:

> > BTW why SHOULD drop? =20
> This is the offload feature to drop such packets so that OS driver doesn'=
t need to do the filtering work. :)

Why not MUST drop? If the device is allowed to produce false negatives,
then I think the OS probably wants to check again to filter out those.
Can we change SHOULD to MUST, so the conforming device is guaranteed to
do the filtering, and the OS can rely on it?

Regards,
Halil=20


> +
>  \subparagraph{Legacy Interface: VLAN Filtering}\label{sec:Device Types /=
 Network Device / Device Operation / Control Virtqueue / VLAN Filtering / L=
egacy Interface: VLAN Filtering}
>  When using the legacy interface, transitional devices and drivers
>  MUST format the VLAN id
> diff --git a/device-types/net/device-conformance.tex b/device-types/net/d=
evice-conformance.tex
> index c686377..54f6783 100644
> --- a/device-types/net/device-conformance.tex
> +++ b/device-types/net/device-conformance.tex
> @@ -9,6 +9,7 @@
>  \item \ref{devicenormative:Device Types / Network Device / Device Operat=
ion / Processing of Incoming Packets}
>  \item \ref{devicenormative:Device Types / Network Device / Device Operat=
ion / Control Virtqueue / Packet Receive Filtering}
>  \item \ref{devicenormative:Device Types / Network Device / Device Operat=
ion / Control Virtqueue / Setting MAC Address Filtering}
> +\item \ref{devicenormative:Device Types / Network Device / Device Operat=
ion / Control Virtqueue / VLAN Filtering}
>  \item \ref{devicenormative:Device Types / Network Device / Device Operat=
ion / Control Virtqueue / Gratuitous Packet Sending}
>  \item \ref{devicenormative:Device Types / Network Device / Device Operat=
ion / Control Virtqueue / Automatic receive steering in multiqueue mode}
>  \item \ref{devicenormative:Device Types / Network Device / Device Operat=
ion / Control Virtqueue / Receive-side scaling (RSS) / RSS processing}


This publicly archived list offers a means to provide input to the=0D
OASIS Virtual I/O Device (VIRTIO) TC.=0D
=0D
In order to verify user consent to the Feedback License terms and=0D
to minimize spam in the list archive, subscription is required=0D
before posting.=0D
=0D
Subscribe: virtio-comment-subscribe@lists.oasis-open.org=0D
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org=0D
List help: virtio-comment-help@lists.oasis-open.org=0D
List archive: https://lists.oasis-open.org/archives/virtio-comment/=0D
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf=
=0D
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lis=
ts=0D
Committee: https://www.oasis-open.org/committees/virtio/=0D
Join OASIS: https://www.oasis-open.org/join/

