Return-Path: virtio-dev-return-3854-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 461D25818F65
	for <virtio-dev@lists.oasis-open.org>; Wed, 18 Apr 2018 03:34:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180417170532-mutt-send-email-mst@kernel.org>
References: <20180416130526.6233-1-sameeh@daynix.com> <20180416130526.6233-3-sameeh@daynix.com>
 <20180417020616-mutt-send-email-mst@kernel.org> <CAKPgXcGh+_PeEKjrtKGDH08=ZEyxDpmxqNW07JmYCeaqSCBj9w@mail.gmail.com>
 <20180417170532-mutt-send-email-mst@kernel.org>
From: Sameeh Jubran <sameeh@daynix.com>
Date: Wed, 18 Apr 2018 13:34:48 +0300
Message-ID: <CAKPgXcHZvS-vhhwDWyO4cgrQG2UmTuD=wpurv-_NjpdLrjrFpg@mail.gmail.com>
Content-Type: multipart/alternative; boundary="94eb2c0e4b5e1d4cda056a1d0110"
Subject: Re: [virtio-dev] [PATCH v2 2/2] content: net: steering mode: Add RSS
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev <virtio-dev@lists.oasis-open.org>, Jason Wang <jasowang@redhat.com>, Vijayabhaskar Balakrishna <vijay.balakrishna@oracle.com>, Yan Vugenfirer <yan@daynix.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--94eb2c0e4b5e1d4cda056a1d0110
Content-Type: text/plain; charset="UTF-8"

On Tue, Apr 17, 2018 at 5:14 PM, Michael S. Tsirkin <mst@redhat.com> wrote:

> On Tue, Apr 17, 2018 at 02:50:15PM +0300, Sameeh Jubran wrote:
> >
> >
> > On Tue, Apr 17, 2018 at 4:50 AM, Michael S. Tsirkin <mst@redhat.com>
> wrote:
> >
> >     On Mon, Apr 16, 2018 at 04:05:26PM +0300, Sameeh Jubran wrote:
> >     > From: Sameeh Jubran <sjubran@redhat.com>
> >     >
> >     > This commit introduces the RSS feature into virtio-net. It is
> introduced
> >     > as a sub mode for a general command which configures the steering
> mode.
> >     >
> >     > Most modern high end network devices today support configurable
> hash
> >     functions,
> >     > this commit introduces RSS - Receive Side Scaling - [1] to virtio
> net
> >     device.
> >     >
> >     > The RSS is a technology from Microsoft that boosts network device
> >     performance
> >     > by efficiently distributing the traffic among the CPUs in a
> >     multiprocessor
> >     > system.
> >     >
> >     > This feature is supported in most of the modern network cards as
> well as
> >     most
> >     > modern OSes including Linux and Windows. It is worth mentioning
> that both
> >     DPDK
> >     > and Hyper-v support RSS too.
> >     >
> >     > [1] https://docs.microsoft.com/en-us/windows-hardware/drivers/
> network/
> >     ndis-receive-side-scaling2
> >     >
> >     > Signed-off-by: Sameeh Jubran <sjubran@redhat.com>
> >     > ---
> >     >  content.tex | 114 ++++++++++++++++++++++++++++++
> >     ++++++++++++++++++++++++++++++
> >     >  1 file changed, 114 insertions(+)
> >     >
> >     > diff --git a/content.tex b/content.tex
> >     > index 3d538e8..8076147 100644
> >     > --- a/content.tex
> >     > +++ b/content.tex
> >     > @@ -4017,6 +4017,7 @@ The device MUST NOT queue packets on receive
> queues
> >     greater than
> >     >  \begin{lstlisting}
> >     >  // steering mode flags
> >     >  #define STEERING_MODE_AUTO          1
> >     > +#define STEERING_MODE_RSS           2
> >     >
> >     >  struct virtio_net_steering_modes {
> >     >  le32 steering_modes;
> >     > @@ -4027,6 +4028,7 @@ le32 steering_mode;
> >     >  le32 command;
> >     >
> >     >      union {
> >     > +    struct virtio_net_rss rss_conf;
> >     >      }
> >     >  };
> >     >
> >     > @@ -4066,6 +4068,118 @@ If this feature has been negotiated, the
> virtio
> >     header has an additional
> >     >
> >     >  This is the default steering mode, please refer to the "Automatic
> >     receive steering in multiqueue" section.
> >     >
> >     > +\subparagraph{Receive Side Scaling}{Device Types / Network Device
> /
> >     Device Operation / Control Virtqueue / Steering mode / Receive Side
> >     Scaling}
> >     > +
> >     > +\begin{lstlisting}
> >     > +#define RSS_HASH_FUNCTION_NONE      1
> >     > +#define RSS_HASH_FUNCTION_TOEPLITZ  2
> >     > +#define RSS_HASH_FUNCTION_SYMMETRIC 3
> >     > +
> >     > +// Hash function fields
> >     > +#define RSS_HASH_FIELDS_IPV4          0x00000100
> >     > +#define RSS_HASH_FIELDS_TCP_IPV4      0x00000200
> >     > +#define RSS_HASH_FIELDS_IPV6          0x00000400
> >     > +#define RSS_HASH_FIELDS_IPV6_EX       0x00000800
> >     > +#define RSS_HASH_FIELDS_TCP_IPV6      0x00001000
> >     > +#define RSS_HASH_FIELDS_TCP_IPV6_EX   0x00002000
> >     > +
> >     > +struct virtio_net_rss_supported_hash{
> >     > +le32 hash_function;
> >     > +}
> >     > +
> >     > +struct virtio_net_rss {
> >     > +le32 hash_function;
> >     > +le32 hash_function_flags;
> >     > +le32 hash_key_length;
> >     > +le32 indirection_table_length;
> >     > +     struct {
> >     > +             le32 hash_key[hash_key_length];
> >     > +             le32 indirection_table[indirection_table_length];
> >     > +     }
> >     > +};
> >     > +
> >     > +#define VIRTIO_NET_SM_CTRL_RSS_GET_SUPPORTED_FUNCTIONS   0
> >     > +#define VIRTIO_NET_SM_CTRL_RSS_SET                       1
> >
> >
> >     Please add comments in the code as well.
> >
> > Do you mean that I should add more comments to the code above which
> explains
> > the structures and defines?
>
> Exactly.
>
> >
> >
> >
> >     > +\end{lstlisting}
> >     > +
> >     > +If the VIRTIO_NET_F_CTRL_STEERING_MODE is negotiated the driver
> can send
> >     control
> >     > +commands for the RSS configuration.
> >
> >     Confused.  Does VIRTIO_NET_F_CTRL_STEERING_MODE imply steering mode
> >     generally or RSS specifically?
> >     How does a device with streering mode ctrl but without RSS look?
> >
> > The steering mode provides an infrastructure to multiple modes and it is
> not
> > specific to RSS.
>
>
> Then maybe this sentence should not imply that VIRTIO_NET_F_CTRL_STEERING_
> MODE
> allows RSS.
>
> > The default mode of the steering mode is the Automatic mode
> > which is the default mode when MQ is enabled. I though this would be the
> best
> > option to provide backward compatibility and makes sense as we already
> have
> > "Automatic steering mode" in the spec.
> > VIRTIO_NET_F_CTRL_STEERING_MODE  gives each mode it's own subset of
> commands as
> > is the case in RSS.
> >
> >
> >
> >     > For configuring RSS the virtio_net_steering_mode
> >     > +should be filled. The \field{steering_mode} field should be
> filled with
> >     the STEERING_MODE_RSS
> >     > +flag along with one of the VIRTIO_NET_SM_CTRL_RSS commands in the
> \field
> >     {command} field. The
> >     > +\field{rss_conf} field should be used.
> >     > +
> >     > +The class VIRTIO_NET_CTRL_RSS has two commands:
> >     > +
> >     > +\begin{enumerate}
> >     > +\item VIRTIO_NET_SM_CTRL_RSS_GET_SUPPORTED_FUNCTIONS returns the
> hash
> >     functions
> >     > +     supported by the device to the driver.
> >     > +\item VIRTIO_NET_SM_CTRL_RSS_SET applies the new RSS
> configuration. The
> >     command is
> >     > +     used by the driver for setting RSS hash function, hash key
> and
> >     > +     indirection table in the device.
> >     > +\end{enumerate}
> >     > +
> >     > +\devicenormative{\subparagraph}{Receive Side Scaling}{Device
> Types /
> >     Network Device / Device Operation / Control Virtqueue / Steering
> mode /
> >     Receive Side Scaling}
> >     > +
> >     > +The device MUST fill the virtio_net_rss_supported_hash structure
> with
> >     the hash
> >     > +functions it supports and return the structure to the driver.
> Zero or
> >     more
> >     > +flags of the RSS_HASH_FUNCTION flags MUST be used to fill the
> \field
> >     {hash_function}
> >     > +field.
> >     > +
> >     > +The device MUST drop all previous RSS configuration upon receiving
> >     > +VIRTIO_NET_SM_CTRL_RSS_SET command.
> >     > +
> >     > +The device MUST set the RSS configuration according to the
> settings
> >     provided as
> >     > +follows, once the configuration process is completed the device
> SHOULD
> >     apply
> >     > +the hash function to each of the incoming packets and distribute
> the
> >     packets
> >     > +through the virqueues using the calculated hash and the
> indirection
> >     table
> >     > +that were earlier provided by the driver.
> >     > +
> >     > +Setting RSS configuration
> >     > +\begin{enumerate}
> >     > +\item The driver fills all of the fields and passes them through
> the
> >     control
> >     > +     queue to the device.
> >     > +
> >     > +\item The device sets the RSS configuration as provided by the
> driver.
> >     > +
> >     > +\item If the device successfully applied the configuration, on
> each
> >     packet
> >     > +     received the device MUST calculate the hashing for the
> packet and
> >     > +     store it in the virtio-net header in the \field{hash} field
> and the
> >     > +     hash fields used in the calculation in rss_hash_type.
> >     > +\end{enumerate}
> >     > +
> >     > +In case of any unexpected values/ unsupported hash function the
> driver
> >     > +MUST return VIRTIO_NET_ERR in the \field{ack} field.
> >
> >     driver or the device?
> >
> >
> >     All MUST statements belon in correct normative sections.
> >
> > True, this is obviously a mistake, it should be the device instead of the
> > driver.
> >
> >
> >     Generally what is the text trying to say here?
> >
> > That the device should handle errors and inform the drivers if there are
> any
> > errors during the execution of the commands.
> >
> >
> >     > +
> >     > +\drivernormative{\subparagraph}{Receive Side Scaling}{Device
> Types /
> >     Network Device / Device Operation / Control Virtqueue / Steering
> mode /
> >     Receive Side Scaling}
> >     > +
> >     > +If the driver wants to set RSS hash it should fill the RSS
> structure
> >     fields
> >     > +as follows:
> >     > +
> >     > +\begin{itemize}
> >     > +\item The driver SHOULD choose the hash function that SHOULD be
> used and
> >     fill
> >     > +     it in the \field{hash_function} field along with the
> appropriate
> >     flags
> >     > +     in the \field{hash_function_flags} field. These flags
> indicate to
> >     the
> >     > +     device which packet fields MUST be used in the calculation
> process
> >     of
> >     > +     the hash.
> >     > +\item Once the hash function has been chosen a suitable hash key
> should
> >     be set
> >     > +     in the \field{hash_key} field,
> >
> >     which key is suitable?
> >
> > depends on the configuration, in Windows case the OS provide us with the
> key,
> > however, in general it could be anything.
> >
>
> We need to somehow describe it in the spec :)
>
> >     > the length of the key should be stored
> >     > +     in the \field{hash_key_length} field.
> >
> >     in 4 byte units?
> >     are there limits on the length?
> >
> > I think one byte can be used as well as now it is 40 bytes in Windows.
> What is
> > the best size that should be chosen in order to keep it future proof?
>
> As a 1st step, could you add spec text explaining what it is?
>
>
> >     > +\item Lastly the driver should fill the indirection table array
> >
> >     is an indirection table required? why not have a function produce
> >     the queue number?
> >
> > Yes it is required as in Windows it is given by the OS. the indirection
> table
> > is basically a map between the hash and cpu ids which correspond to
> queue ids.
> >
> >
> >     > in the
> >     > +     \field{indirection_table} field while setting the array
> length in
> >     > +     \field{indirection_table_length}.
> >
> >     any limits on the length here?
> >
> > currently the indirection table is 128 bytes in Windows. We can change
> the
> > sizes to fit that case, but what about future compatibility? What do you
> think
> > should be the optimal size of the fields in order to keep this future
> proof
> > while keeping the overhead minimal.
>
> As host must maintain this in memory, you can have host specify the
> maximum. guest will bail out if host does not support what it needs.
>
>
> >
> >     > This structure is used by the device
> >     > +     for determining in which RX virt queue the packet should be
> placed.
> >
> >     How?
> >
> > By applying the hash function on the packet while using the provided key
> in
> > order to determine the hash for the packet and then use the indirection
> table
> > to place the packet inside the suitable queue. This is hash function
> dependent
> > implementation, but more elaboration can be added indeed.
>
> I guess indirection table is independent?
>
> >
> >     > +\end{itemize}
> >     > +Once the configuration phase is over successfully, the packets
> SHOULD
> >     have the
> >     > +\field{hash} field with the hash value that was calculated by the
> >     device.
> >
> >     Why not make this optional? I suspect it's not really useful e.g. for
> >     dpdk or xdp which do not generally use hardware offloads.
> >
> > Good point, will make it optional.
> >
> >
> >     > +
> >     > +Whenever the driver wants to discard the current RSS settings, it
> can
> >     send an
> >     > +VIRTIO_NET_SM_CTRL_RSS_SET command along with rss structure that
> has
> >     > +RSS_HASH_FUNCTION_NONE the \field{hash_function} field.
> >
> >     And then what happens?
> >
> > and then the device is configured with RSS settings
>
>
> so NONE will enable RSS?
>
> > and MUST start distributing
> > the packets into the queues accordingly while attaching the calculated
> hash to
> > the header.
> >
> >
> >     > +
> >     > +The driver MUST check the \field{ack} field value provided by the
> >     device, in
> >     > +case the value is not VIRTIO_NET_OK then the driver MUST handle
> failure
> >     and
> >     > +retry another hash function or else give up.
> >
> >     Is there anything special here?
> >
> > Not really just describing the error handling in detail.
>
> If it applies to all commands maybe add it to generic code.
>
> >
> >     > +
> >     >  \subparagraph{Legacy Interface: Automatic receive steering in
> multiqueue
> >     mode}\label{sec:Device Types / Network Device / Device Operation /
> Control
> >     Virtqueue / Automatic receive steering in multiqueue mode / Legacy
> >     Interface: Automatic receive steering in multiqueue mode}
> >     >  When using the legacy interface, transitional devices and drivers
> >     >  MUST format \field{virtqueue_pairs}
> >
> >     conformance statements will need to be updated.
> >
> > which statements for example?
>
> I mean links are needed in conformance.tex
>
Do you think that the Steering Mode should be in conformance?

>
> >
> >     > --
> >     > 2.13.6
> >     >
> >     >
> >     > ------------------------------------------------------------
> ---------
> >     > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.
> oasis-open.org
> >     > For additional commands, e-mail: virtio-dev-help@lists.oasis-
> open.org
> >
> >
> >
> >
> > --
> > Respectfully,
> > Sameeh Jubran
> > Linkedin
> > Software Engineer @ Daynix.
>



-- 
Respectfully,
*Sameeh Jubran*
*Linkedin <https://il.linkedin.com/pub/sameeh-jubran/87/747/a8a>*
*Software Engineer @ Daynix <http://www.daynix.com>.*

--94eb2c0e4b5e1d4cda056a1d0110
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Tue, Apr 17, 2018 at 5:14 PM, Michael S. Tsirkin <span dir=3D"ltr">&=
lt;<a href=3D"mailto:mst@redhat.com" target=3D"_blank">mst@redhat.com</a>&g=
t;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><d=
iv class=3D"h5">On Tue, Apr 17, 2018 at 02:50:15PM +0300, Sameeh Jubran wro=
te:<br>
&gt; <br>
&gt; <br>
&gt; On Tue, Apr 17, 2018 at 4:50 AM, Michael S. Tsirkin &lt;<a href=3D"mai=
lto:mst@redhat.com">mst@redhat.com</a>&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On Mon, Apr 16, 2018 at 04:05:26PM +0300, Sameeh Ju=
bran wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; From: Sameeh Jubran &lt;<a href=3D"mailto:sjub=
ran@redhat.com">sjubran@redhat.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; This commit introduces the RSS feature into vi=
rtio-net. It is introduced<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; as a sub mode for a general command which conf=
igures the steering mode.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Most modern high end network devices today sup=
port configurable hash<br>
&gt;=C2=A0 =C2=A0 =C2=A0functions,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; this commit introduces RSS - Receive Side Scal=
ing - [1] to virtio net<br>
&gt;=C2=A0 =C2=A0 =C2=A0device.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; The RSS is a technology from Microsoft that bo=
osts network device<br>
&gt;=C2=A0 =C2=A0 =C2=A0performance<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; by efficiently distributing the traffic among =
the CPUs in a<br>
&gt;=C2=A0 =C2=A0 =C2=A0multiprocessor<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; system.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; This feature is supported in most of the moder=
n network cards as well as<br>
&gt;=C2=A0 =C2=A0 =C2=A0most<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; modern OSes including Linux and Windows. It is=
 worth mentioning that both<br>
&gt;=C2=A0 =C2=A0 =C2=A0DPDK<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; and Hyper-v support RSS too.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; [1] <a href=3D"https://docs.microsoft.com/en-u=
s/windows-hardware/drivers/network/" rel=3D"noreferrer" target=3D"_blank">h=
ttps://docs.microsoft.com/en-<wbr>us/windows-hardware/drivers/<wbr>network/=
</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0ndis-receive-side-scaling2<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Signed-off-by: Sameeh Jubran &lt;<a href=3D"ma=
ilto:sjubran@redhat.com">sjubran@redhat.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; ---<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 content.tex | 114 ++++++++++++++++++++++=
++++++++<br>
&gt;=C2=A0 =C2=A0 =C2=A0++++++++++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 1 file changed, 114 insertions(+)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; diff --git a/content.tex b/content.tex<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; index 3d538e8..8076147 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; --- a/content.tex<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +++ b/content.tex<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; @@ -4017,6 +4017,7 @@ The device MUST NOT queu=
e packets on receive queues<br>
&gt;=C2=A0 =C2=A0 =C2=A0greater than<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 \begin{lstlisting}<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 // steering mode flags<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 #define STEERING_MODE_AUTO=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 1<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#define STEERING_MODE_RSS=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A02<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 struct virtio_net_steering_modes {<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 le32 steering_modes;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; @@ -4027,6 +4028,7 @@ le32 steering_mode;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 le32 command;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 union {<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 struct virtio_net_rss rss_conf;=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 };<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; @@ -4066,6 +4068,118 @@ If this feature has be=
en negotiated, the virtio<br>
&gt;=C2=A0 =C2=A0 =C2=A0header has an additional<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 This is the default steering mode, pleas=
e refer to the &quot;Automatic<br>
&gt;=C2=A0 =C2=A0 =C2=A0receive steering in multiqueue&quot; section.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +\subparagraph{Receive Side Scaling}{Device Ty=
pes / Network Device /<br>
&gt;=C2=A0 =C2=A0 =C2=A0Device Operation / Control Virtqueue / Steering mod=
e / Receive Side<br>
&gt;=C2=A0 =C2=A0 =C2=A0Scaling}<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +\begin{lstlisting}<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#define RSS_HASH_FUNCTION_NONE=C2=A0 =C2=A0 =
=C2=A0 1<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#define RSS_HASH_FUNCTION_TOEPLITZ=C2=A0 2<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#define RSS_HASH_FUNCTION_SYMMETRIC 3<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +// Hash function fields<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#define RSS_HASH_FIELDS_IPV4=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 0x00000100<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#define RSS_HASH_FIELDS_TCP_IPV4=C2=A0 =C2=A0=
 =C2=A0 0x00000200<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#define RSS_HASH_FIELDS_IPV6=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 0x00000400<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#define RSS_HASH_FIELDS_IPV6_EX=C2=A0 =C2=A0 =
=C2=A0 =C2=A00x00000800<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#define RSS_HASH_FIELDS_TCP_IPV6=C2=A0 =C2=A0=
 =C2=A0 0x00001000<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#define RSS_HASH_FIELDS_TCP_IPV6_EX=C2=A0 =C2=
=A00x00002000<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +struct virtio_net_rss_supported_hash{<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +le32 hash_function;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +struct virtio_net_rss {<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +le32 hash_function;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +le32 hash_function_flags;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +le32 hash_key_length;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +le32 indirection_table_length;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0struct {<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0le32 hash_key[hash_key_length];<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0le32 indirection_table[indirection_<wbr>table_length];<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +};<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#define VIRTIO_NET_SM_CTRL_RSS_GET_<wbr>SUPPO=
RTED_FUNCTIONS=C2=A0 =C2=A00<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#define VIRTIO_NET_SM_CTRL_RSS_SET=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01<=
br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Please add comments in the code as well.<br>
&gt; <br>
&gt; Do you mean that I should add more comments to the code above which ex=
plains<br>
&gt; the structures and defines?<br>
<br>
</div></div>Exactly.<br>
<span class=3D""><br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +\end{lstlisting}<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +If the VIRTIO_NET_F_CTRL_STEERING_<wbr>MODE i=
s negotiated the driver can send<br>
&gt;=C2=A0 =C2=A0 =C2=A0control<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +commands for the RSS configuration.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Confused.=C2=A0 Does VIRTIO_NET_F_CTRL_STEERING_<wb=
r>MODE imply steering mode<br>
&gt;=C2=A0 =C2=A0 =C2=A0generally or RSS specifically?<br>
&gt;=C2=A0 =C2=A0 =C2=A0How does a device with streering mode ctrl but with=
out RSS look?<br>
&gt; <br>
&gt; The steering mode provides an infrastructure to multiple modes and it =
is not<br>
&gt; specific to RSS.<br>
<br>
<br>
</span>Then maybe this sentence should not imply that VIRTIO_NET_F_CTRL_STE=
ERING_<wbr>MODE<br>
allows RSS.<br>
<div><div class=3D"h5"><br>
&gt; The default mode of the steering mode is the Automatic mode<br>
&gt; which is the default mode when MQ is enabled. I though this would be t=
he best<br>
&gt; option to provide backward compatibility and makes sense as we already=
 have<br>
&gt; &quot;Automatic steering mode&quot; in the spec.<br>
&gt; VIRTIO_NET_F_CTRL_STEERING_<wbr>MODE=C2=A0=C2=A0gives each mode it&#39=
;s own subset of commands as<br>
&gt; is the case in RSS.<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; For configuring RSS the virtio_net_steering_mo=
de<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +should be filled. The \field{steering_mode} f=
ield should be filled with<br>
&gt;=C2=A0 =C2=A0 =C2=A0the STEERING_MODE_RSS<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +flag along with one of the VIRTIO_NET_SM_CTRL=
_RSS commands in the \field<br>
&gt;=C2=A0 =C2=A0 =C2=A0{command} field. The<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +\field{rss_conf} field should be used.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +The class VIRTIO_NET_CTRL_RSS has two command=
s:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +\begin{enumerate}<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +\item VIRTIO_NET_SM_CTRL_RSS_GET_<wbr>SUPPORT=
ED_FUNCTIONS returns the hash<br>
&gt;=C2=A0 =C2=A0 =C2=A0functions<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0supported by the device t=
o the driver.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +\item VIRTIO_NET_SM_CTRL_RSS_SET applies the =
new RSS configuration. The<br>
&gt;=C2=A0 =C2=A0 =C2=A0command is<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0used by the driver for se=
tting RSS hash function, hash key and<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0indirection table in the =
device.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +\end{enumerate}<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +\devicenormative{\<wbr>subparagraph}{Receive =
Side Scaling}{Device Types /<br>
&gt;=C2=A0 =C2=A0 =C2=A0Network Device / Device Operation / Control Virtque=
ue / Steering mode /<br>
&gt;=C2=A0 =C2=A0 =C2=A0Receive Side Scaling}<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +The device MUST fill the virtio_net_rss_suppo=
rted_hash structure with<br>
&gt;=C2=A0 =C2=A0 =C2=A0the hash<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +functions it supports and return the structur=
e to the driver. Zero or<br>
&gt;=C2=A0 =C2=A0 =C2=A0more<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +flags of the RSS_HASH_FUNCTION flags MUST be =
used to fill the \field<br>
&gt;=C2=A0 =C2=A0 =C2=A0{hash_function}<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +field.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +The device MUST drop all previous RSS configu=
ration upon receiving<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +VIRTIO_NET_SM_CTRL_RSS_SET command.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +The device MUST set the RSS configuration acc=
ording to the settings<br>
&gt;=C2=A0 =C2=A0 =C2=A0provided as<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +follows, once the configuration process is co=
mpleted the device SHOULD<br>
&gt;=C2=A0 =C2=A0 =C2=A0apply<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +the hash function to each of the incoming pac=
kets and distribute the<br>
&gt;=C2=A0 =C2=A0 =C2=A0packets<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +through the virqueues using the calculated ha=
sh and the indirection<br>
&gt;=C2=A0 =C2=A0 =C2=A0table<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +that were earlier provided by the driver.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +Setting RSS configuration<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +\begin{enumerate}<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +\item The driver fills all of the fields and =
passes them through the<br>
&gt;=C2=A0 =C2=A0 =C2=A0control<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0queue to the device.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +\item The device sets the RSS configuration a=
s provided by the driver.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +\item If the device successfully applied the =
configuration, on each<br>
&gt;=C2=A0 =C2=A0 =C2=A0packet<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0received the device MUST =
calculate the hashing for the packet and<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0store it in the virtio-ne=
t header in the \field{hash} field and the<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0hash fields used in the c=
alculation in rss_hash_type.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +\end{enumerate}<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +In case of any unexpected values/ unsupported=
 hash function the driver<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +MUST return VIRTIO_NET_ERR in the \field{ack}=
 field.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0driver or the device?=C2=A0<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0All MUST statements belon in correct normative sect=
ions.<br>
&gt; <br>
&gt; True, this is obviously a mistake, it should be the device instead of =
the<br>
&gt; driver.=C2=A0<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Generally what is the text trying to say here?<br>
&gt; <br>
&gt; That the device should handle errors and inform the drivers if there a=
re any<br>
&gt; errors during the execution of the commands.=C2=A0<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +\drivernormative{\<wbr>subparagraph}{Receive =
Side Scaling}{Device Types /<br>
&gt;=C2=A0 =C2=A0 =C2=A0Network Device / Device Operation / Control Virtque=
ue / Steering mode /<br>
&gt;=C2=A0 =C2=A0 =C2=A0Receive Side Scaling}<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +If the driver wants to set RSS hash it should=
 fill the RSS structure<br>
&gt;=C2=A0 =C2=A0 =C2=A0fields<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +as follows:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +\begin{itemize}<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +\item The driver SHOULD choose the hash funct=
ion that SHOULD be used and<br>
&gt;=C2=A0 =C2=A0 =C2=A0fill<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0it in the \field{hash_fun=
ction} field along with the appropriate<br>
&gt;=C2=A0 =C2=A0 =C2=A0flags<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0in the \field{hash_functi=
on_flags} field. These flags indicate to<br>
&gt;=C2=A0 =C2=A0 =C2=A0the<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0device which packet field=
s MUST be used in the calculation process<br>
&gt;=C2=A0 =C2=A0 =C2=A0of<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0the hash.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +\item Once the hash function has been chosen =
a suitable hash key should<br>
&gt;=C2=A0 =C2=A0 =C2=A0be set<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0in the \field{hash_key} f=
ield,<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0which key is suitable?<br>
&gt; <br>
&gt; depends on the configuration, in Windows case the OS provide us with t=
he key,<br>
&gt; however, in general it could be anything.=C2=A0<br>
&gt; <br>
<br>
</div></div>We need to somehow describe it in the spec :)<br>
<span class=3D""><br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; the length of the key should be stored<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0in the \field{hash_key_le=
ngth} field.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0in 4 byte units?<br>
&gt;=C2=A0 =C2=A0 =C2=A0are there limits on the length?<br>
&gt; <br>
&gt; I think one byte can be used as well as now it is 40 bytes in Windows.=
 What is<br>
&gt; the best size that should be chosen in order to keep it future proof?<=
br>
<br>
</span>As a 1st step, could you add spec text explaining what it is?<br>
<span class=3D""><br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +\item Lastly the driver should fill the indir=
ection table array<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0is an indirection table required? why not have a fu=
nction produce<br>
&gt;=C2=A0 =C2=A0 =C2=A0the queue number?<br>
&gt; <br>
&gt; Yes it is required as in Windows it is given by the OS. the indirectio=
n table<br>
&gt; is basically a map between the hash and cpu ids which correspond to qu=
eue ids.=C2=A0<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; in the<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0\field{indirection_table}=
 field while setting the array length in<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0\field{indirection_table_=
<wbr>length}.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0any limits on the length here?<br>
&gt; <br>
&gt; currently the indirection table is 128 bytes in Windows. We can change=
 the<br>
&gt; sizes to fit that case, but what about future compatibility? What do y=
ou think<br>
&gt; should be the optimal size of the fields in order to keep this future =
proof<br>
&gt; while keeping the overhead minimal.<br>
<br>
</span>As host must maintain this in memory, you can have host specify the<=
br>
maximum. guest will bail out if host does not support what it needs.<br>
<span class=3D""><br>
<br>
&gt;=C2=A0 =C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; This structure is used by the device<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0for determining in which =
RX virt queue the packet should be placed.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0How?<br>
&gt; <br>
&gt; By applying the hash function on the packet while using the provided k=
ey in<br>
&gt; order to determine the hash for the packet and then use the indirectio=
n table<br>
&gt; to place the packet inside the suitable queue. This is hash function d=
ependent<br>
&gt; implementation, but more elaboration can be added indeed.=C2=A0<br>
<br>
</span>I guess indirection table is independent?<br>
<span class=3D""><br>
&gt;=C2=A0 =C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +\end{itemize}<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +Once the configuration phase is over successf=
ully, the packets SHOULD<br>
&gt;=C2=A0 =C2=A0 =C2=A0have the<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +\field{hash} field with the hash value that w=
as calculated by the<br>
&gt;=C2=A0 =C2=A0 =C2=A0device.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Why not make this optional? I suspect it&#39;s not =
really useful e.g. for<br>
&gt;=C2=A0 =C2=A0 =C2=A0dpdk or xdp which do not generally use hardware off=
loads.<br>
&gt; <br>
&gt; Good point, will make it optional.=C2=A0<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +Whenever the driver wants to discard the curr=
ent RSS settings, it can<br>
&gt;=C2=A0 =C2=A0 =C2=A0send an<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +VIRTIO_NET_SM_CTRL_RSS_SET command along with=
 rss structure that has<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +RSS_HASH_FUNCTION_NONE the \field{hash_functi=
on} field.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0And then what happens?<br>
&gt; <br>
&gt; and then the device is configured with RSS settings<br>
<br>
<br>
</span>so NONE will enable RSS?<br>
<span class=3D""><br>
&gt; and MUST start distributing<br>
&gt; the packets into the queues accordingly while attaching the calculated=
 hash to<br>
&gt; the header.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +The driver MUST check the \field{ack} field v=
alue provided by the<br>
&gt;=C2=A0 =C2=A0 =C2=A0device, in<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +case the value is not VIRTIO_NET_OK then the =
driver MUST handle failure<br>
&gt;=C2=A0 =C2=A0 =C2=A0and<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +retry another hash function or else give up.<=
br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Is there anything special here?<br>
&gt; <br>
&gt; Not really just describing the error handling in detail.=C2=A0<br>
<br>
</span>If it applies to all commands maybe add it to generic code.<br>
<span class=3D""><br>
&gt;=C2=A0 =C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 \subparagraph{Legacy Interface: Automati=
c receive steering in multiqueue<br>
&gt;=C2=A0 =C2=A0 =C2=A0mode}\label{sec:Device Types / Network Device / Dev=
ice Operation / Control<br>
&gt;=C2=A0 =C2=A0 =C2=A0Virtqueue / Automatic receive steering in multiqueu=
e mode / Legacy<br>
&gt;=C2=A0 =C2=A0 =C2=A0Interface: Automatic receive steering in multiqueue=
 mode}<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 When using the legacy interface, transit=
ional devices and drivers<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 MUST format \field{virtqueue_pairs}<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0conformance statements will need to be updated.<br>
&gt; <br>
&gt; which statements for example?<br>
<br>
</span>I mean links are needed in conformance.tex<br></blockquote><div>Do y=
ou think that the Steering Mode should be in conformance?=C2=A0=C2=A0</div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt;=C2=A0 =C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; --<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; 2.13.6<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; ------------------------------<wbr>-----------=
-------------------<wbr>---------<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; To unsubscribe, e-mail: <a href=3D"mailto:virt=
io-dev-unsubscribe@lists.oasis-open.org">virtio-dev-unsubscribe@lists.<wbr>=
oasis-open.org</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; For additional commands, e-mail: <a href=3D"ma=
ilto:virtio-dev-help@lists.oasis-open.org">virtio-dev-help@lists.oasis-<wbr=
>open.org</a><br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; --<br>
&gt; Respectfully,<br>
&gt; Sameeh Jubran<br>
&gt; Linkedin<br>
&gt; Software Engineer @ Daynix.<br>
</div></div></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>=
<div class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=
=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr">=
<font size=3D"4" color=3D"#0b5394" face=3D"times new roman, serif">Respectf=
ully,<br></font><div style=3D"font-size:12.8px;color:rgb(136,136,136)"><fon=
t size=3D"4" color=3D"#0b5394" face=3D"times new roman, serif"><b><i>Sameeh=
 Jubran</i></b></font></div><div style=3D"font-size:12.8px;color:rgb(136,13=
6,136)"><i style=3D"color:rgb(7,55,99);font-family:&quot;times new roman&qu=
ot;,serif;font-size:large"><span style=3D"line-height:15px"><a href=3D"http=
s://il.linkedin.com/pub/sameeh-jubran/87/747/a8a" title=3D"View public prof=
ile" name=3D"UNIQUE_ID_SafeHtmlFilter_UNIQUE_ID_SafeHtmlFilter_UNIQUE_ID_Sa=
feHtmlFilter_UNIQUE_ID_SafeHtmlFilter_UNIQUE_ID_SafeHtmlFilter_14e2c1de96f8=
c195_UNIQUE_ID_SafeHtmlFilter_SafeHtmlFilter_SafeHtmlFilter_webProfileURL" =
style=3D"color:rgb(17,85,204);margin:0px;padding:0px;border-width:0px;outli=
ne:none;vertical-align:baseline;text-decoration:none" target=3D"_blank">Lin=
kedin</a></span></i><br></div><div style=3D"font-size:12.8px;color:rgb(136,=
136,136)"><font size=3D"4" face=3D"times new roman, serif" color=3D"#073763=
"><i>Software Engineer @ <a href=3D"http://www.daynix.com" target=3D"_blank=
">Daynix</a>.</i></font></div></div></div></div></div></div></div></div></d=
iv>
</div></div>

--94eb2c0e4b5e1d4cda056a1d0110--

