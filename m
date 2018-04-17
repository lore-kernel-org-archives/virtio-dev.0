Return-Path: virtio-dev-return-3851-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 2E4A45818F87
	for <virtio-dev@lists.oasis-open.org>; Tue, 17 Apr 2018 04:50:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180417020616-mutt-send-email-mst@kernel.org>
References: <20180416130526.6233-1-sameeh@daynix.com> <20180416130526.6233-3-sameeh@daynix.com>
 <20180417020616-mutt-send-email-mst@kernel.org>
From: Sameeh Jubran <sameeh@daynix.com>
Date: Tue, 17 Apr 2018 14:50:15 +0300
Message-ID: <CAKPgXcGh+_PeEKjrtKGDH08=ZEyxDpmxqNW07JmYCeaqSCBj9w@mail.gmail.com>
Content-Type: multipart/alternative; boundary="883d24f24a7021c0fc056a09f174"
Subject: Re: [virtio-dev] [PATCH v2 2/2] content: net: steering mode: Add RSS
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev <virtio-dev@lists.oasis-open.org>, Jason Wang <jasowang@redhat.com>, Vijayabhaskar Balakrishna <vijay.balakrishna@oracle.com>, Yan Vugenfirer <yan@daynix.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--883d24f24a7021c0fc056a09f174
Content-Type: text/plain; charset="UTF-8"

On Tue, Apr 17, 2018 at 4:50 AM, Michael S. Tsirkin <mst@redhat.com> wrote:

> On Mon, Apr 16, 2018 at 04:05:26PM +0300, Sameeh Jubran wrote:
> > From: Sameeh Jubran <sjubran@redhat.com>
> >
> > This commit introduces the RSS feature into virtio-net. It is introduced
> > as a sub mode for a general command which configures the steering mode.
> >
> > Most modern high end network devices today support configurable hash
> functions,
> > this commit introduces RSS - Receive Side Scaling - [1] to virtio net
> device.
> >
> > The RSS is a technology from Microsoft that boosts network device
> performance
> > by efficiently distributing the traffic among the CPUs in a
> multiprocessor
> > system.
> >
> > This feature is supported in most of the modern network cards as well as
> most
> > modern OSes including Linux and Windows. It is worth mentioning that
> both DPDK
> > and Hyper-v support RSS too.
> >
> > [1] https://docs.microsoft.com/en-us/windows-hardware/drivers/
> network/ndis-receive-side-scaling2
> >
> > Signed-off-by: Sameeh Jubran <sjubran@redhat.com>
> > ---
> >  content.tex | 114 ++++++++++++++++++++++++++++++
> ++++++++++++++++++++++++++++++
> >  1 file changed, 114 insertions(+)
> >
> > diff --git a/content.tex b/content.tex
> > index 3d538e8..8076147 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -4017,6 +4017,7 @@ The device MUST NOT queue packets on receive
> queues greater than
> >  \begin{lstlisting}
> >  // steering mode flags
> >  #define STEERING_MODE_AUTO          1
> > +#define STEERING_MODE_RSS           2
> >
> >  struct virtio_net_steering_modes {
> >  le32 steering_modes;
> > @@ -4027,6 +4028,7 @@ le32 steering_mode;
> >  le32 command;
> >
> >      union {
> > +    struct virtio_net_rss rss_conf;
> >      }
> >  };
> >
> > @@ -4066,6 +4068,118 @@ If this feature has been negotiated, the virtio
> header has an additional
> >
> >  This is the default steering mode, please refer to the "Automatic
> receive steering in multiqueue" section.
> >
> > +\subparagraph{Receive Side Scaling}{Device Types / Network Device /
> Device Operation / Control Virtqueue / Steering mode / Receive Side Scaling}
> > +
> > +\begin{lstlisting}
> > +#define RSS_HASH_FUNCTION_NONE      1
> > +#define RSS_HASH_FUNCTION_TOEPLITZ  2
> > +#define RSS_HASH_FUNCTION_SYMMETRIC 3
> > +
> > +// Hash function fields
> > +#define RSS_HASH_FIELDS_IPV4          0x00000100
> > +#define RSS_HASH_FIELDS_TCP_IPV4      0x00000200
> > +#define RSS_HASH_FIELDS_IPV6          0x00000400
> > +#define RSS_HASH_FIELDS_IPV6_EX       0x00000800
> > +#define RSS_HASH_FIELDS_TCP_IPV6      0x00001000
> > +#define RSS_HASH_FIELDS_TCP_IPV6_EX   0x00002000
> > +
> > +struct virtio_net_rss_supported_hash{
> > +le32 hash_function;
> > +}
> > +
> > +struct virtio_net_rss {
> > +le32 hash_function;
> > +le32 hash_function_flags;
> > +le32 hash_key_length;
> > +le32 indirection_table_length;
> > +     struct {
> > +             le32 hash_key[hash_key_length];
> > +             le32 indirection_table[indirection_table_length];
> > +     }
> > +};
> > +
> > +#define VIRTIO_NET_SM_CTRL_RSS_GET_SUPPORTED_FUNCTIONS   0
> > +#define VIRTIO_NET_SM_CTRL_RSS_SET                       1
>
>
> Please add comments in the code as well.

Do you mean that I should add more comments to the code above which
explains the structures and defines?

>


> > +\end{lstlisting}
> > +
> > +If the VIRTIO_NET_F_CTRL_STEERING_MODE is negotiated the driver can
> send control
> > +commands for the RSS configuration.
>
> Confused.  Does VIRTIO_NET_F_CTRL_STEERING_MODE imply steering mode
> generally or RSS specifically?
> How does a device with streering mode ctrl but without RSS look?

The steering mode provides an infrastructure to multiple modes and it is
not specific to RSS. The default mode of the steering mode is the Automatic
mode which is the default mode when MQ is enabled. I though this would be
the best option to provide backward compatibility and makes sense as we
already have "Automatic steering mode" in the spec.
VIRTIO_NET_F_CTRL_STEERING_MODE  gives each mode it's own subset of
commands as is the case in RSS.

>
>
> > For configuring RSS the virtio_net_steering_mode
> > +should be filled. The \field{steering_mode} field should be filled with
> the STEERING_MODE_RSS
> > +flag along with one of the VIRTIO_NET_SM_CTRL_RSS commands in the
> \field{command} field. The
> > +\field{rss_conf} field should be used.
> > +
> > +The class VIRTIO_NET_CTRL_RSS has two commands:
> > +
> > +\begin{enumerate}
> > +\item VIRTIO_NET_SM_CTRL_RSS_GET_SUPPORTED_FUNCTIONS returns the hash
> functions
> > +     supported by the device to the driver.
> > +\item VIRTIO_NET_SM_CTRL_RSS_SET applies the new RSS configuration. The
> command is
> > +     used by the driver for setting RSS hash function, hash key and
> > +     indirection table in the device.
> > +\end{enumerate}
> > +
> > +\devicenormative{\subparagraph}{Receive Side Scaling}{Device Types /
> Network Device / Device Operation / Control Virtqueue / Steering mode /
> Receive Side Scaling}
> > +
> > +The device MUST fill the virtio_net_rss_supported_hash structure with
> the hash
> > +functions it supports and return the structure to the driver. Zero or
> more
> > +flags of the RSS_HASH_FUNCTION flags MUST be used to fill the
> \field{hash_function}
> > +field.
> > +
> > +The device MUST drop all previous RSS configuration upon receiving
> > +VIRTIO_NET_SM_CTRL_RSS_SET command.
> > +
> > +The device MUST set the RSS configuration according to the settings
> provided as
> > +follows, once the configuration process is completed the device SHOULD
> apply
> > +the hash function to each of the incoming packets and distribute the
> packets
> > +through the virqueues using the calculated hash and the indirection
> table
> > +that were earlier provided by the driver.
> > +
> > +Setting RSS configuration
> > +\begin{enumerate}
> > +\item The driver fills all of the fields and passes them through the
> control
> > +     queue to the device.
> > +
> > +\item The device sets the RSS configuration as provided by the driver.
> > +
> > +\item If the device successfully applied the configuration, on each
> packet
> > +     received the device MUST calculate the hashing for the packet and
> > +     store it in the virtio-net header in the \field{hash} field and the
> > +     hash fields used in the calculation in rss_hash_type.
> > +\end{enumerate}
> > +
> > +In case of any unexpected values/ unsupported hash function the driver
> > +MUST return VIRTIO_NET_ERR in the \field{ack} field.
>
> driver or the device?


> All MUST statements belon in correct normative sections.
>
True, this is obviously a mistake, it should be the device instead of the
driver.

>
> Generally what is the text trying to say here?
>
That the device should handle errors and inform the drivers if there are
any errors during the execution of the commands.

>
> > +
> > +\drivernormative{\subparagraph}{Receive Side Scaling}{Device Types /
> Network Device / Device Operation / Control Virtqueue / Steering mode /
> Receive Side Scaling}
> > +
> > +If the driver wants to set RSS hash it should fill the RSS structure
> fields
> > +as follows:
> > +
> > +\begin{itemize}
> > +\item The driver SHOULD choose the hash function that SHOULD be used
> and fill
> > +     it in the \field{hash_function} field along with the appropriate
> flags
> > +     in the \field{hash_function_flags} field. These flags indicate to
> the
> > +     device which packet fields MUST be used in the calculation process
> of
> > +     the hash.
> > +\item Once the hash function has been chosen a suitable hash key should
> be set
> > +     in the \field{hash_key} field,
>
> which key is suitable?
>
depends on the configuration, in Windows case the OS provide us with the
key, however, in general it could be anything.

>
> > the length of the key should be stored
> > +     in the \field{hash_key_length} field.
>
> in 4 byte units?
> are there limits on the length?
>
I think one byte can be used as well as now it is 40 bytes in Windows. What
is the best size that should be chosen in order to keep it future proof?

>
> > +\item Lastly the driver should fill the indirection table array
>
> is an indirection table required? why not have a function produce
> the queue number?
>
Yes it is required as in Windows it is given by the OS. the indirection
table is basically a map between the hash and cpu ids which correspond to
queue ids.

>
> > in the
> > +     \field{indirection_table} field while setting the array length in
> > +     \field{indirection_table_length}.
>
> any limits on the length here?
>
currently the indirection table is 128 bytes in Windows. We can change the
sizes to fit that case, but what about future compatibility? What do you
think should be the optimal size of the fields in order to keep this future
proof while keeping the overhead minimal.

>
> > This structure is used by the device
> > +     for determining in which RX virt queue the packet should be placed.
>
> How?
>
By applying the hash function on the packet while using the provided key in
order to determine the hash for the packet and then use the indirection
table to place the packet inside the suitable queue. This is hash function
dependent implementation, but more elaboration can be added indeed.

>
> > +\end{itemize}
> > +Once the configuration phase is over successfully, the packets SHOULD
> have the
> > +\field{hash} field with the hash value that was calculated by the
> device.
>
> Why not make this optional? I suspect it's not really useful e.g. for
> dpdk or xdp which do not generally use hardware offloads.
>
Good point, will make it optional.

>
> > +
> > +Whenever the driver wants to discard the current RSS settings, it can
> send an
> > +VIRTIO_NET_SM_CTRL_RSS_SET command along with rss structure that has
> > +RSS_HASH_FUNCTION_NONE the \field{hash_function} field.
>
> And then what happens?
>
and then the device is configured with RSS settings and MUST start
distributing the packets into the queues accordingly while attaching the
calculated hash to the header.

>
> > +
> > +The driver MUST check the \field{ack} field value provided by the
> device, in
> > +case the value is not VIRTIO_NET_OK then the driver MUST handle failure
> and
> > +retry another hash function or else give up.
>
> Is there anything special here?
>
Not really just describing the error handling in detail.

>
> > +
> >  \subparagraph{Legacy Interface: Automatic receive steering in
> multiqueue mode}\label{sec:Device Types / Network Device / Device Operation
> / Control Virtqueue / Automatic receive steering in multiqueue mode /
> Legacy Interface: Automatic receive steering in multiqueue mode}
> >  When using the legacy interface, transitional devices and drivers
> >  MUST format \field{virtqueue_pairs}
>
> conformance statements will need to be updated.
>
which statements for example?

>
> > --
> > 2.13.6
> >
> >
> > ---------------------------------------------------------------------
> > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>



-- 
Respectfully,
*Sameeh Jubran*
*Linkedin <https://il.linkedin.com/pub/sameeh-jubran/87/747/a8a>*
*Software Engineer @ Daynix <http://www.daynix.com>.*

--883d24f24a7021c0fc056a09f174
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Tue, Apr 17, 2018 at 4:50 AM, Michael S. Tsirkin <span dir=3D"ltr">&=
lt;<a href=3D"mailto:mst@redhat.com" target=3D"_blank">mst@redhat.com</a>&g=
t;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div =
class=3D"gmail-HOEnZb"><div class=3D"gmail-h5">On Mon, Apr 16, 2018 at 04:0=
5:26PM +0300, Sameeh Jubran wrote:<br>
&gt; From: Sameeh Jubran &lt;<a href=3D"mailto:sjubran@redhat.com">sjubran@=
redhat.com</a>&gt;<br>
&gt; <br>
&gt; This commit introduces the RSS feature into virtio-net. It is introduc=
ed<br>
&gt; as a sub mode for a general command which configures the steering mode=
.<br>
&gt; <br>
&gt; Most modern high end network devices today support configurable hash f=
unctions,<br>
&gt; this commit introduces RSS - Receive Side Scaling - [1] to virtio net =
device.<br>
&gt; <br>
&gt; The RSS is a technology from Microsoft that boosts network device perf=
ormance<br>
&gt; by efficiently distributing the traffic among the CPUs in a multiproce=
ssor<br>
&gt; system.<br>
&gt; <br>
&gt; This feature is supported in most of the modern network cards as well =
as most<br>
&gt; modern OSes including Linux and Windows. It is worth mentioning that b=
oth DPDK<br>
&gt; and Hyper-v support RSS too.<br>
&gt; <br>
&gt; [1] <a href=3D"https://docs.microsoft.com/en-us/windows-hardware/drive=
rs/network/ndis-receive-side-scaling2" rel=3D"noreferrer" target=3D"_blank"=
>https://docs.microsoft.com/en-<wbr>us/windows-hardware/drivers/<wbr>networ=
k/ndis-receive-side-<wbr>scaling2</a><br>
&gt; <br>
&gt; Signed-off-by: Sameeh Jubran &lt;<a href=3D"mailto:sjubran@redhat.com"=
>sjubran@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 content.tex | 114 ++++++++++++++++++++++++++++++<wbr>+++++++++++=
+++++++++++++++++++<br>
&gt;=C2=A0 1 file changed, 114 insertions(+)<br>
&gt; <br>
&gt; diff --git a/content.tex b/content.tex<br>
&gt; index 3d538e8..8076147 100644<br>
&gt; --- a/content.tex<br>
&gt; +++ b/content.tex<br>
&gt; @@ -4017,6 +4017,7 @@ The device MUST NOT queue packets on receive que=
ues greater than<br>
&gt;=C2=A0 \begin{lstlisting}<br>
&gt;=C2=A0 // steering mode flags<br>
&gt;=C2=A0 #define STEERING_MODE_AUTO=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1<b=
r>
&gt; +#define STEERING_MODE_RSS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02<b=
r>
&gt;=C2=A0 <br>
&gt;=C2=A0 struct virtio_net_steering_modes {<br>
&gt;=C2=A0 le32 steering_modes;<br>
&gt; @@ -4027,6 +4028,7 @@ le32 steering_mode;<br>
&gt;=C2=A0 le32 command;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 union {<br>
&gt; +=C2=A0 =C2=A0 struct virtio_net_rss rss_conf;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 };<br>
&gt;=C2=A0 <br>
&gt; @@ -4066,6 +4068,118 @@ If this feature has been negotiated, the virti=
o header has an additional<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 This is the default steering mode, please refer to the &quot;Aut=
omatic receive steering in multiqueue&quot; section.<br>
&gt;=C2=A0 <br>
&gt; +\subparagraph{Receive Side Scaling}{Device Types / Network Device / D=
evice Operation / Control Virtqueue / Steering mode / Receive Side Scaling}=
<br>
&gt; +<br>
&gt; +\begin{lstlisting}<br>
&gt; +#define RSS_HASH_FUNCTION_NONE=C2=A0 =C2=A0 =C2=A0 1<br>
&gt; +#define RSS_HASH_FUNCTION_TOEPLITZ=C2=A0 2<br>
&gt; +#define RSS_HASH_FUNCTION_SYMMETRIC 3<br>
&gt; +<br>
&gt; +// Hash function fields<br>
&gt; +#define RSS_HASH_FIELDS_IPV4=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x0000=
0100<br>
&gt; +#define RSS_HASH_FIELDS_TCP_IPV4=C2=A0 =C2=A0 =C2=A0 0x00000200<br>
&gt; +#define RSS_HASH_FIELDS_IPV6=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x0000=
0400<br>
&gt; +#define RSS_HASH_FIELDS_IPV6_EX=C2=A0 =C2=A0 =C2=A0 =C2=A00x00000800<=
br>
&gt; +#define RSS_HASH_FIELDS_TCP_IPV6=C2=A0 =C2=A0 =C2=A0 0x00001000<br>
&gt; +#define RSS_HASH_FIELDS_TCP_IPV6_EX=C2=A0 =C2=A00x00002000<br>
&gt; +<br>
&gt; +struct virtio_net_rss_supported_hash{<br>
&gt; +le32 hash_function;<br>
&gt; +}<br>
&gt; +<br>
&gt; +struct virtio_net_rss {<br>
&gt; +le32 hash_function;<br>
&gt; +le32 hash_function_flags;<br>
&gt; +le32 hash_key_length;<br>
&gt; +le32 indirection_table_length;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0le32 hash_key[hash_ke=
y_length];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0le32 indirection_tabl=
e[indirection_<wbr>table_length];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +};<br>
&gt; +<br>
&gt; +#define VIRTIO_NET_SM_CTRL_RSS_GET_<wbr>SUPPORTED_FUNCTIONS=C2=A0 =C2=
=A00<br>
&gt; +#define VIRTIO_NET_SM_CTRL_RSS_SET=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01<br>
<br>
<br>
</div></div>Please add comments in the code as well.</blockquote><div>Do yo=
u mean that I should add more comments to the code above which explains the=
 structures and defines?</div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">=C2=A0</blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><=
span class=3D"gmail-"><br>
&gt; +\end{lstlisting}<br>
&gt; +<br>
&gt; +If the VIRTIO_NET_F_CTRL_STEERING_<wbr>MODE is negotiated the driver =
can send control<br>
&gt; +commands for the RSS configuration.<br>
<br>
</span>Confused.=C2=A0 Does VIRTIO_NET_F_CTRL_STEERING_<wbr>MODE imply stee=
ring mode<br>
generally or RSS specifically?<br>
How does a device with streering mode ctrl but without RSS look?</blockquot=
e><div>The steering mode provides an infrastructure to multiple modes and i=
t is not specific to RSS. The default mode of the steering mode is the Auto=
matic mode which is the default mode when MQ is enabled. I though this woul=
d be the best option to provide backward compatibility and makes sense as w=
e already have &quot;Automatic steering mode&quot; in the spec.</div><div>

<span style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:s=
mall;font-style:normal;font-variant-ligatures:normal;font-variant-caps:norm=
al;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;t=
ext-transform:none;white-space:normal;word-spacing:0px;background-color:rgb=
(255,255,255);text-decoration-style:initial;text-decoration-color:initial;f=
loat:none;display:inline">VIRTIO_NET_F_CTRL_STEERING_</span><wbr style=3D"c=
olor:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-style:=
normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:4=
00;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:no=
ne;white-space:normal;word-spacing:0px;background-color:rgb(255,255,255);te=
xt-decoration-style:initial;text-decoration-color:initial"><span style=3D"c=
olor:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-style:=
normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:4=
00;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:no=
ne;white-space:normal;word-spacing:0px;background-color:rgb(255,255,255);te=
xt-decoration-style:initial;text-decoration-color:initial;float:none;displa=
y:inline">MODE<span>=C2=A0</span></span>=C2=A0gives each mode it&#39;s own =
subset of commands as is the case in RSS.<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">
<div><div class=3D"gmail-h5"><br>
<br>
&gt; For configuring RSS the virtio_net_steering_mode<br>
&gt; +should be filled. The \field{steering_mode} field should be filled wi=
th the STEERING_MODE_RSS<br>
&gt; +flag along with one of the VIRTIO_NET_SM_CTRL_RSS commands in the \fi=
eld{command} field. The<br>
&gt; +\field{rss_conf} field should be used.<br>
&gt; +<br>
&gt; +The class VIRTIO_NET_CTRL_RSS has two commands:<br>
&gt; +<br>
&gt; +\begin{enumerate}<br>
&gt; +\item VIRTIO_NET_SM_CTRL_RSS_GET_<wbr>SUPPORTED_FUNCTIONS returns the=
 hash functions<br>
&gt; +=C2=A0 =C2=A0 =C2=A0supported by the device to the driver.<br>
&gt; +\item VIRTIO_NET_SM_CTRL_RSS_SET applies the new RSS configuration. T=
he command is<br>
&gt; +=C2=A0 =C2=A0 =C2=A0used by the driver for setting RSS hash function,=
 hash key and<br>
&gt; +=C2=A0 =C2=A0 =C2=A0indirection table in the device.<br>
&gt; +\end{enumerate}<br>
&gt; +<br>
&gt; +\devicenormative{\<wbr>subparagraph}{Receive Side Scaling}{Device Typ=
es / Network Device / Device Operation / Control Virtqueue / Steering mode =
/ Receive Side Scaling}<br>
&gt; +<br>
&gt; +The device MUST fill the virtio_net_rss_supported_hash structure with=
 the hash<br>
&gt; +functions it supports and return the structure to the driver. Zero or=
 more<br>
&gt; +flags of the RSS_HASH_FUNCTION flags MUST be used to fill the \field{=
hash_function}<br>
&gt; +field.<br>
&gt; +<br>
&gt; +The device MUST drop all previous RSS configuration upon receiving<br=
>
&gt; +VIRTIO_NET_SM_CTRL_RSS_SET command.<br>
&gt; +<br>
&gt; +The device MUST set the RSS configuration according to the settings p=
rovided as<br>
&gt; +follows, once the configuration process is completed the device SHOUL=
D apply<br>
&gt; +the hash function to each of the incoming packets and distribute the =
packets<br>
&gt; +through the virqueues using the calculated hash and the indirection t=
able<br>
&gt; +that were earlier provided by the driver.<br>
&gt; +<br>
&gt; +Setting RSS configuration<br>
&gt; +\begin{enumerate}<br>
&gt; +\item The driver fills all of the fields and passes them through the =
control<br>
&gt; +=C2=A0 =C2=A0 =C2=A0queue to the device.<br>
&gt; +<br>
&gt; +\item The device sets the RSS configuration as provided by the driver=
.<br>
&gt; +<br>
&gt; +\item If the device successfully applied the configuration, on each p=
acket<br>
&gt; +=C2=A0 =C2=A0 =C2=A0received the device MUST calculate the hashing fo=
r the packet and<br>
&gt; +=C2=A0 =C2=A0 =C2=A0store it in the virtio-net header in the \field{h=
ash} field and the<br>
&gt; +=C2=A0 =C2=A0 =C2=A0hash fields used in the calculation in rss_hash_t=
ype.<br>
&gt; +\end{enumerate}<br>
&gt; +<br>
&gt; +In case of any unexpected values/ unsupported hash function the drive=
r<br>
&gt; +MUST return VIRTIO_NET_ERR in the \field{ack} field.<br>
<br>
</div></div>driver or the device?=C2=A0</blockquote><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">
<br>
All MUST statements belon in correct normative sections.<br></blockquote><d=
iv>True, this is obviously a mistake, it should be the device instead of th=
e driver.=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Generally what is the text trying to say here?<br></blockquote><div>That th=
e device should handle errors and inform the drivers if there are any error=
s during the execution of the commands.=C2=A0</div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">
<span class=3D"gmail-"><br>
&gt; +<br>
&gt; +\drivernormative{\<wbr>subparagraph}{Receive Side Scaling}{Device Typ=
es / Network Device / Device Operation / Control Virtqueue / Steering mode =
/ Receive Side Scaling}<br>
&gt; +<br>
&gt; +If the driver wants to set RSS hash it should fill the RSS structure =
fields<br>
&gt; +as follows:<br>
&gt; +<br>
&gt; +\begin{itemize}<br>
&gt; +\item The driver SHOULD choose the hash function that SHOULD be used =
and fill<br>
&gt; +=C2=A0 =C2=A0 =C2=A0it in the \field{hash_function} field along with =
the appropriate flags<br>
&gt; +=C2=A0 =C2=A0 =C2=A0in the \field{hash_function_flags} field. These f=
lags indicate to the<br>
&gt; +=C2=A0 =C2=A0 =C2=A0device which packet fields MUST be used in the ca=
lculation process of<br>
&gt; +=C2=A0 =C2=A0 =C2=A0the hash.<br>
&gt; +\item Once the hash function has been chosen a suitable hash key shou=
ld be set<br>
&gt; +=C2=A0 =C2=A0 =C2=A0in the \field{hash_key} field,<br>
<br>
</span>which key is suitable?<br></blockquote><div>depends on the configura=
tion, in Windows case the OS provide us with the key, however, in general i=
t could be anything.=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">
<span class=3D"gmail-"><br>
&gt; the length of the key should be stored<br>
&gt; +=C2=A0 =C2=A0 =C2=A0in the \field{hash_key_length} field.<br>
<br>
</span>in 4 byte units?<br>
are there limits on the length?<br></blockquote><div>I think one byte can b=
e used as well as now it is 40 bytes in Windows. What is the best size that=
 should be chosen in order to keep it future proof?</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
<span class=3D"gmail-"><br>
&gt; +\item Lastly the driver should fill the indirection table array<br>
<br>
</span>is an indirection table required? why not have a function produce<br=
>
the queue number?<br></blockquote><div>Yes it is required as in Windows it =
is given by the OS. the indirection table is basically a map between the ha=
sh and cpu ids which correspond to queue ids.=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
<span class=3D"gmail-"><br>
&gt; in the<br>
&gt; +=C2=A0 =C2=A0 =C2=A0\field{indirection_table} field while setting the=
 array length in<br>
&gt; +=C2=A0 =C2=A0 =C2=A0\field{indirection_table_<wbr>length}.<br>
<br>
</span>any limits on the length here?<br></blockquote><div>currently the in=
direction table is 128 bytes in Windows. We can change the sizes to fit tha=
t case, but what about future compatibility? What do you think should be th=
e optimal size of the fields in order to keep this future proof while keepi=
ng the overhead minimal.</div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">
<span class=3D"gmail-"><br>
&gt; This structure is used by the device<br>
&gt; +=C2=A0 =C2=A0 =C2=A0for determining in which RX virt queue the packet=
 should be placed.<br>
<br>
</span>How?<br></blockquote><div>By applying the hash function on the packe=
t while using the provided key in order to determine the hash for the packe=
t and then use the indirection table to place the packet inside the suitabl=
e queue. This is hash function dependent implementation, but more elaborati=
on can be added indeed.=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
<span class=3D"gmail-"><br>
&gt; +\end{itemize}<br>
&gt; +Once the configuration phase is over successfully, the packets SHOULD=
 have the<br>
&gt; +\field{hash} field with the hash value that was calculated by the dev=
ice.<br>
<br>
</span>Why not make this optional? I suspect it&#39;s not really useful e.g=
. for<br>
dpdk or xdp which do not generally use hardware offloads.<br></blockquote><=
div>Good point, will make it optional.=C2=A0</div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">
<span class=3D"gmail-"><br>
&gt; +<br>
&gt; +Whenever the driver wants to discard the current RSS settings, it can=
 send an<br>
&gt; +VIRTIO_NET_SM_CTRL_RSS_SET command along with rss structure that has<=
br>
&gt; +RSS_HASH_FUNCTION_NONE the \field{hash_function} field.<br>
<br>
</span>And then what happens?<br></blockquote><div>and then the device is c=
onfigured with RSS settings and MUST start distributing the packets into th=
e queues accordingly while attaching the calculated hash to the header.</di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">
<span class=3D"gmail-"><br>
&gt; +<br>
&gt; +The driver MUST check the \field{ack} field value provided by the dev=
ice, in<br>
&gt; +case the value is not VIRTIO_NET_OK then the driver MUST handle failu=
re and<br>
&gt; +retry another hash function or else give up.<br>
<br>
</span>Is there anything special here?<br></blockquote><div>Not really just=
 describing the error handling in detail.=C2=A0</div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">
<span class=3D"gmail-"><br>
&gt; +<br>
&gt;=C2=A0 \subparagraph{Legacy Interface: Automatic receive steering in mu=
ltiqueue mode}\label{sec:Device Types / Network Device / Device Operation /=
 Control Virtqueue / Automatic receive steering in multiqueue mode / Legacy=
 Interface: Automatic receive steering in multiqueue mode}<br>
&gt;=C2=A0 When using the legacy interface, transitional devices and driver=
s<br>
&gt;=C2=A0 MUST format \field{virtqueue_pairs}<br>
<br>
</span>conformance statements will need to be updated.<br></blockquote><div=
>which statements for example?</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
<span class=3D"gmail-HOEnZb"><font color=3D"#888888"><br>
&gt; -- <br>
&gt; 2.13.6<br>
&gt; <br>
&gt; <br>
&gt; ------------------------------<wbr>------------------------------<wbr>=
---------<br>
&gt; To unsubscribe, e-mail: <a href=3D"mailto:virtio-dev-unsubscribe@lists=
.oasis-open.org">virtio-dev-unsubscribe@lists.<wbr>oasis-open.org</a><br>
&gt; For additional commands, e-mail: <a href=3D"mailto:virtio-dev-help@lis=
ts.oasis-open.org">virtio-dev-help@lists.oasis-<wbr>open.org</a><br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r><div class=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr"><di=
v><div dir=3D"ltr"><div><div dir=3D"ltr"><font size=3D"4" color=3D"#0b5394"=
 face=3D"times new roman, serif">Respectfully,<br></font><div style=3D"font=
-size:12.8px;color:rgb(136,136,136)"><font size=3D"4" color=3D"#0b5394" fac=
e=3D"times new roman, serif"><b><i>Sameeh Jubran</i></b></font></div><div s=
tyle=3D"font-size:12.8px;color:rgb(136,136,136)"><i style=3D"color:rgb(7,55=
,99);font-family:&quot;times new roman&quot;,serif;font-size:large"><span s=
tyle=3D"line-height:15px"><a href=3D"https://il.linkedin.com/pub/sameeh-jub=
ran/87/747/a8a" title=3D"View public profile" name=3D"UNIQUE_ID_SafeHtmlFil=
ter_UNIQUE_ID_SafeHtmlFilter_UNIQUE_ID_SafeHtmlFilter_UNIQUE_ID_SafeHtmlFil=
ter_UNIQUE_ID_SafeHtmlFilter_14e2c1de96f8c195_UNIQUE_ID_SafeHtmlFilter_Safe=
HtmlFilter_SafeHtmlFilter_webProfileURL" style=3D"color:rgb(17,85,204);marg=
in:0px;padding:0px;border-width:0px;outline:none;vertical-align:baseline;te=
xt-decoration:none" target=3D"_blank">Linkedin</a></span></i><br></div><div=
 style=3D"font-size:12.8px;color:rgb(136,136,136)"><font size=3D"4" face=3D=
"times new roman, serif" color=3D"#073763"><i>Software Engineer @ <a href=
=3D"http://www.daynix.com" target=3D"_blank">Daynix</a>.</i></font></div></=
div></div></div></div></div></div></div></div>
</div></div>

--883d24f24a7021c0fc056a09f174--
