Return-Path: virtio-dev-return-3852-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id A1E6B5818F5B
	for <virtio-dev@lists.oasis-open.org>; Tue, 17 Apr 2018 07:14:45 -0700 (PDT)
Date: Tue, 17 Apr 2018 17:14:33 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180417170532-mutt-send-email-mst@kernel.org>
References: <20180416130526.6233-1-sameeh@daynix.com>
 <20180416130526.6233-3-sameeh@daynix.com>
 <20180417020616-mutt-send-email-mst@kernel.org>
 <CAKPgXcGh+_PeEKjrtKGDH08=ZEyxDpmxqNW07JmYCeaqSCBj9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAKPgXcGh+_PeEKjrtKGDH08=ZEyxDpmxqNW07JmYCeaqSCBj9w@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH v2 2/2] content: net: steering mode: Add RSS
To: Sameeh Jubran <sameeh@daynix.com>
Cc: virtio-dev <virtio-dev@lists.oasis-open.org>, Jason Wang <jasowang@redhat.com>, Vijayabhaskar Balakrishna <vijay.balakrishna@oracle.com>, Yan Vugenfirer <yan@daynix.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Apr 17, 2018 at 02:50:15PM +0300, Sameeh Jubran wrote:
>=20
>=20
> On Tue, Apr 17, 2018 at 4:50 AM, Michael S. Tsirkin <mst@redhat.com> wrot=
e:
>=20
>     On Mon, Apr 16, 2018 at 04:05:26PM +0300, Sameeh Jubran wrote:
>     > From: Sameeh Jubran <sjubran@redhat.com>
>     >
>     > This commit introduces the RSS feature into virtio-net. It is intro=
duced
>     > as a sub mode for a general command which configures the steering m=
ode.
>     >
>     > Most modern high end network devices today support configurable hash
>     functions,
>     > this commit introduces RSS - Receive Side Scaling - [1] to virtio n=
et
>     device.
>     >
>     > The RSS is a technology from Microsoft that boosts network device
>     performance
>     > by efficiently distributing the traffic among the CPUs in a
>     multiprocessor
>     > system.
>     >
>     > This feature is supported in most of the modern network cards as we=
ll as
>     most
>     > modern OSes including Linux and Windows. It is worth mentioning tha=
t both
>     DPDK
>     > and Hyper-v support RSS too.
>     >
>     > [1] https://docs.microsoft.com/en-us/windows-hardware/drivers/netwo=
rk/
>     ndis-receive-side-scaling2
>     >
>     > Signed-off-by: Sameeh Jubran <sjubran@redhat.com>
>     > ---
>     >=A0 content.tex | 114 ++++++++++++++++++++++++++++++
>     ++++++++++++++++++++++++++++++
>     >=A0 1 file changed, 114 insertions(+)
>     >
>     > diff --git a/content.tex b/content.tex
>     > index 3d538e8..8076147 100644
>     > --- a/content.tex
>     > +++ b/content.tex
>     > @@ -4017,6 +4017,7 @@ The device MUST NOT queue packets on receive =
queues
>     greater than
>     >=A0 \begin{lstlisting}
>     >=A0 // steering mode flags
>     >=A0 #define STEERING_MODE_AUTO=A0 =A0 =A0 =A0 =A0 1
>     > +#define STEERING_MODE_RSS=A0 =A0 =A0 =A0 =A0 =A02
>     >=A0
>     >=A0 struct virtio_net_steering_modes {
>     >=A0 le32 steering_modes;
>     > @@ -4027,6 +4028,7 @@ le32 steering_mode;
>     >=A0 le32 command;
>     >=A0
>     >=A0 =A0 =A0 union {
>     > +=A0 =A0 struct virtio_net_rss rss_conf;
>     >=A0 =A0 =A0 }
>     >=A0 };
>     >=A0
>     > @@ -4066,6 +4068,118 @@ If this feature has been negotiated, the vi=
rtio
>     header has an additional
>     >=A0
>     >=A0 This is the default steering mode, please refer to the "Automatic
>     receive steering in multiqueue" section.
>     >=A0
>     > +\subparagraph{Receive Side Scaling}{Device Types / Network Device /
>     Device Operation / Control Virtqueue / Steering mode / Receive Side
>     Scaling}
>     > +
>     > +\begin{lstlisting}
>     > +#define RSS_HASH_FUNCTION_NONE=A0 =A0 =A0 1
>     > +#define RSS_HASH_FUNCTION_TOEPLITZ=A0 2
>     > +#define RSS_HASH_FUNCTION_SYMMETRIC 3
>     > +
>     > +// Hash function fields
>     > +#define RSS_HASH_FIELDS_IPV4=A0 =A0 =A0 =A0 =A0 0x00000100
>     > +#define RSS_HASH_FIELDS_TCP_IPV4=A0 =A0 =A0 0x00000200
>     > +#define RSS_HASH_FIELDS_IPV6=A0 =A0 =A0 =A0 =A0 0x00000400
>     > +#define RSS_HASH_FIELDS_IPV6_EX=A0 =A0 =A0 =A00x00000800
>     > +#define RSS_HASH_FIELDS_TCP_IPV6=A0 =A0 =A0 0x00001000
>     > +#define RSS_HASH_FIELDS_TCP_IPV6_EX=A0 =A00x00002000
>     > +
>     > +struct virtio_net_rss_supported_hash{
>     > +le32 hash_function;
>     > +}
>     > +
>     > +struct virtio_net_rss {
>     > +le32 hash_function;
>     > +le32 hash_function_flags;
>     > +le32 hash_key_length;
>     > +le32 indirection_table_length;
>     > +=A0 =A0 =A0struct {
>     > +=A0 =A0 =A0 =A0 =A0 =A0 =A0le32 hash_key[hash_key_length];
>     > +=A0 =A0 =A0 =A0 =A0 =A0 =A0le32 indirection_table[indirection_tabl=
e_length];
>     > +=A0 =A0 =A0}
>     > +};
>     > +
>     > +#define VIRTIO_NET_SM_CTRL_RSS_GET_SUPPORTED_FUNCTIONS=A0 =A00
>     > +#define VIRTIO_NET_SM_CTRL_RSS_SET=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A01
>=20
>=20
>     Please add comments in the code as well.
>=20
> Do you mean that I should add more comments to the code above which expla=
ins
> the structures and defines?

Exactly.

>     =A0
>=20
>   =20
>     > +\end{lstlisting}
>     > +
>     > +If the VIRTIO_NET_F_CTRL_STEERING_MODE is negotiated the driver ca=
n send
>     control
>     > +commands for the RSS configuration.
>=20
>     Confused.=A0 Does VIRTIO_NET_F_CTRL_STEERING_MODE imply steering mode
>     generally or RSS specifically?
>     How does a device with streering mode ctrl but without RSS look?
>=20
> The steering mode provides an infrastructure to multiple modes and it is =
not
> specific to RSS.


Then maybe this sentence should not imply that VIRTIO_NET_F_CTRL_STEERING_M=
ODE
allows RSS.

> The default mode of the steering mode is the Automatic mode
> which is the default mode when MQ is enabled. I though this would be the =
best
> option to provide backward compatibility and makes sense as we already ha=
ve
> "Automatic steering mode" in the spec.
> VIRTIO_NET_F_CTRL_STEERING_MODE=A0=A0gives each mode it's own subset of c=
ommands as
> is the case in RSS.
>=20
>=20
>=20
>     > For configuring RSS the virtio_net_steering_mode
>     > +should be filled. The \field{steering_mode} field should be filled=
 with
>     the STEERING_MODE_RSS
>     > +flag along with one of the VIRTIO_NET_SM_CTRL_RSS commands in the =
\field
>     {command} field. The
>     > +\field{rss_conf} field should be used.
>     > +
>     > +The class VIRTIO_NET_CTRL_RSS has two commands:
>     > +
>     > +\begin{enumerate}
>     > +\item VIRTIO_NET_SM_CTRL_RSS_GET_SUPPORTED_FUNCTIONS returns the h=
ash
>     functions
>     > +=A0 =A0 =A0supported by the device to the driver.
>     > +\item VIRTIO_NET_SM_CTRL_RSS_SET applies the new RSS configuration=
. The
>     command is
>     > +=A0 =A0 =A0used by the driver for setting RSS hash function, hash =
key and
>     > +=A0 =A0 =A0indirection table in the device.
>     > +\end{enumerate}
>     > +
>     > +\devicenormative{\subparagraph}{Receive Side Scaling}{Device Types=
 /
>     Network Device / Device Operation / Control Virtqueue / Steering mode=
 /
>     Receive Side Scaling}
>     > +
>     > +The device MUST fill the virtio_net_rss_supported_hash structure w=
ith
>     the hash
>     > +functions it supports and return the structure to the driver. Zero=
 or
>     more
>     > +flags of the RSS_HASH_FUNCTION flags MUST be used to fill the \fie=
ld
>     {hash_function}
>     > +field.
>     > +
>     > +The device MUST drop all previous RSS configuration upon receiving
>     > +VIRTIO_NET_SM_CTRL_RSS_SET command.
>     > +
>     > +The device MUST set the RSS configuration according to the settings
>     provided as
>     > +follows, once the configuration process is completed the device SH=
OULD
>     apply
>     > +the hash function to each of the incoming packets and distribute t=
he
>     packets
>     > +through the virqueues using the calculated hash and the indirection
>     table
>     > +that were earlier provided by the driver.
>     > +
>     > +Setting RSS configuration
>     > +\begin{enumerate}
>     > +\item The driver fills all of the fields and passes them through t=
he
>     control
>     > +=A0 =A0 =A0queue to the device.
>     > +
>     > +\item The device sets the RSS configuration as provided by the dri=
ver.
>     > +
>     > +\item If the device successfully applied the configuration, on each
>     packet
>     > +=A0 =A0 =A0received the device MUST calculate the hashing for the =
packet and
>     > +=A0 =A0 =A0store it in the virtio-net header in the \field{hash} f=
ield and the
>     > +=A0 =A0 =A0hash fields used in the calculation in rss_hash_type.
>     > +\end{enumerate}
>     > +
>     > +In case of any unexpected values/ unsupported hash function the dr=
iver
>     > +MUST return VIRTIO_NET_ERR in the \field{ack} field.
>=20
>     driver or the device?=A0
>=20
>=20
>     All MUST statements belon in correct normative sections.
>=20
> True, this is obviously a mistake, it should be the device instead of the
> driver.=A0
>=20
>=20
>     Generally what is the text trying to say here?
>=20
> That the device should handle errors and inform the drivers if there are =
any
> errors during the execution of the commands.=A0
>=20
>   =20
>     > +
>     > +\drivernormative{\subparagraph}{Receive Side Scaling}{Device Types=
 /
>     Network Device / Device Operation / Control Virtqueue / Steering mode=
 /
>     Receive Side Scaling}
>     > +
>     > +If the driver wants to set RSS hash it should fill the RSS structu=
re
>     fields
>     > +as follows:
>     > +
>     > +\begin{itemize}
>     > +\item The driver SHOULD choose the hash function that SHOULD be us=
ed and
>     fill
>     > +=A0 =A0 =A0it in the \field{hash_function} field along with the ap=
propriate
>     flags
>     > +=A0 =A0 =A0in the \field{hash_function_flags} field. These flags i=
ndicate to
>     the
>     > +=A0 =A0 =A0device which packet fields MUST be used in the calculat=
ion process
>     of
>     > +=A0 =A0 =A0the hash.
>     > +\item Once the hash function has been chosen a suitable hash key s=
hould
>     be set
>     > +=A0 =A0 =A0in the \field{hash_key} field,
>=20
>     which key is suitable?
>=20
> depends on the configuration, in Windows case the OS provide us with the =
key,
> however, in general it could be anything.=A0
>=20

We need to somehow describe it in the spec :)

>     > the length of the key should be stored
>     > +=A0 =A0 =A0in the \field{hash_key_length} field.
>=20
>     in 4 byte units?
>     are there limits on the length?
>=20
> I think one byte can be used as well as now it is 40 bytes in Windows. Wh=
at is
> the best size that should be chosen in order to keep it future proof?

As a 1st step, could you add spec text explaining what it is?


>     > +\item Lastly the driver should fill the indirection table array
>=20
>     is an indirection table required? why not have a function produce
>     the queue number?
>=20
> Yes it is required as in Windows it is given by the OS. the indirection t=
able
> is basically a map between the hash and cpu ids which correspond to queue=
 ids.=A0
>=20
>   =20
>     > in the
>     > +=A0 =A0 =A0\field{indirection_table} field while setting the array=
 length in
>     > +=A0 =A0 =A0\field{indirection_table_length}.
>=20
>     any limits on the length here?
>=20
> currently the indirection table is 128 bytes in Windows. We can change the
> sizes to fit that case, but what about future compatibility? What do you =
think
> should be the optimal size of the fields in order to keep this future pro=
of
> while keeping the overhead minimal.

As host must maintain this in memory, you can have host specify the
maximum. guest will bail out if host does not support what it needs.


>   =20
>     > This structure is used by the device
>     > +=A0 =A0 =A0for determining in which RX virt queue the packet shoul=
d be placed.
>=20
>     How?
>=20
> By applying the hash function on the packet while using the provided key =
in
> order to determine the hash for the packet and then use the indirection t=
able
> to place the packet inside the suitable queue. This is hash function depe=
ndent
> implementation, but more elaboration can be added indeed.=A0

I guess indirection table is independent?

>   =20
>     > +\end{itemize}
>     > +Once the configuration phase is over successfully, the packets SHO=
ULD
>     have the
>     > +\field{hash} field with the hash value that was calculated by the
>     device.
>=20
>     Why not make this optional? I suspect it's not really useful e.g. for
>     dpdk or xdp which do not generally use hardware offloads.
>=20
> Good point, will make it optional.=A0
>=20
>   =20
>     > +
>     > +Whenever the driver wants to discard the current RSS settings, it =
can
>     send an
>     > +VIRTIO_NET_SM_CTRL_RSS_SET command along with rss structure that h=
as
>     > +RSS_HASH_FUNCTION_NONE the \field{hash_function} field.
>=20
>     And then what happens?
>=20
> and then the device is configured with RSS settings


so NONE will enable RSS?

> and MUST start distributing
> the packets into the queues accordingly while attaching the calculated ha=
sh to
> the header.
>=20
>   =20
>     > +
>     > +The driver MUST check the \field{ack} field value provided by the
>     device, in
>     > +case the value is not VIRTIO_NET_OK then the driver MUST handle fa=
ilure
>     and
>     > +retry another hash function or else give up.
>=20
>     Is there anything special here?
>=20
> Not really just describing the error handling in detail.=A0

If it applies to all commands maybe add it to generic code.

>   =20
>     > +
>     >=A0 \subparagraph{Legacy Interface: Automatic receive steering in mu=
ltiqueue
>     mode}\label{sec:Device Types / Network Device / Device Operation / Co=
ntrol
>     Virtqueue / Automatic receive steering in multiqueue mode / Legacy
>     Interface: Automatic receive steering in multiqueue mode}
>     >=A0 When using the legacy interface, transitional devices and drivers
>     >=A0 MUST format \field{virtqueue_pairs}
>=20
>     conformance statements will need to be updated.
>=20
> which statements for example?

I mean links are needed in conformance.tex

>   =20
>     > --
>     > 2.13.6
>     >
>     >
>     > -------------------------------------------------------------------=
--
>     > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
>     > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.o=
rg
>=20
>=20
>=20
>=20
> --
> Respectfully,
> Sameeh Jubran
> Linkedin
> Software Engineer @ Daynix.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

