Return-Path: virtio-dev-return-3069-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id AA893581819D
	for <virtio-dev@lists.oasis-open.org>; Thu, 25 Jan 2018 08:53:57 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180125162709.370-2-sameeh@daynix.com>
References: <20180125162709.370-1-sameeh@daynix.com> <20180125162709.370-2-sameeh@daynix.com>
From: Sameeh Jubran <sameeh@daynix.com>
Date: Thu, 25 Jan 2018 18:53:53 +0200
Message-ID: <CAKPgXcFYxnU5Jr_3W-=O+iTqA+uace0mbNnfu4W0npSW5z4PPw@mail.gmail.com>
Content-Type: multipart/alternative; boundary="001a1140dbb405f05b05639ca07d"
Subject: [virtio-dev] Re: [RFC virtio-net 1/1] content: net: Add VIRTIO_NET_F_CTRL_RSS feature
To: virtio-dev <virtio-dev@lists.oasis-open.org>
Cc: Amnon Ilan <ailan@redhat.com>, Yan Vugenfirer <yan@daynix.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--001a1140dbb405f05b05639ca07d
Content-Type: text/plain; charset="UTF-8"

Please ignore the typos, I mistakenly sent the patch without the fixes.
I'll resend the fixes along with v2.

On Thu, Jan 25, 2018 at 6:27 PM, Sameeh Jubran <sameeh@daynix.com> wrote:

> From: Sameeh Jubran <sameeh.j@gmail.com>
>
> Most modern high end network devices today support configurable hash
> functions,
> this commit introduces RSS - Receive Side Scaling - [1] to virtio net
> device.
>
> The RSS is a technology from Microsoft that boosts network device
> performance
> by efficiently distributing the traffic among the CPUs in a multiprocessor
> system.
>
> This feature is supported in most of the modern network cards as well as
> most
> modern OSes including Linux and Windows. It is worth mentioning that both
> DPDK
> and Hyper-v support RSS too.
>
> [1] https://docs.microsoft.com/en-us/windows-hardware/drivers/
> network/ndis-receive-side-scaling2
>
> Signed-off-by: Sameeh Jubran <sjubran@redhat.com>
> ---
>  content.tex | 133 ++++++++++++++++++++++++++++++
> ++++++++++++++++++++++++++++++
>  1 file changed, 133 insertions(+)
>
> diff --git a/content.tex b/content.tex
> index c840588..5969b28 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -3115,6 +3115,9 @@ features.
>
>  \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through control
>      channel.
> +
> +\item[VIRTIO_NET_F_CTRL_RSS(24)] Device supports configurable RSS hash
> +    functions.
>  \end{description}
>
>  \subsubsection{Feature bit requirements}\label{sec:Device Types / Network
> Device / Feature bits / Feature bit requirements}
> @@ -3138,6 +3141,8 @@ Some networking feature bits require other
> networking feature bits
>  \item[VIRTIO_NET_F_GUEST_ANNOUNCE] Requires VIRTIO_NET_F_CTRL_VQ.
>  \item[VIRTIO_NET_F_MQ] Requires VIRTIO_NET_F_CTRL_VQ.
>  \item[VIRTIO_NET_F_CTRL_MAC_ADDR] Requires VIRTIO_NET_F_CTRL_VQ.
> +
> +\item[VIRTIO_NET_F_CTRL_RSS] Requires VIRTIO_NET_F_MQ.
>  \end{description}
>
>  \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types /
> Network Device / Feature bits / Legacy Interface: Feature bits}
> @@ -3308,6 +3313,7 @@ struct virtio_net_hdr {
>          u8 flags;
>  #define VIRTIO_NET_HDR_GSO_NONE        0
>  #define VIRTIO_NET_HDR_GSO_TCPV4       1
> +#define VIRTIO_NET_HDR_GSO_RSS         2
>  #define VIRTIO_NET_HDR_GSO_UDP         3
>  #define VIRTIO_NET_HDR_GSO_TCPV6       4
>  #define VIRTIO_NET_HDR_GSO_ECN      0x80
> @@ -3317,6 +3323,8 @@ struct virtio_net_hdr {
>          le16 csum_start;
>          le16 csum_offset;
>          le16 num_buffers;
> +// Only if RSS hash offload has been negotiated
> +        le64 rss_hash_value;
>  };
>  \end{lstlisting}
>
> @@ -4007,6 +4015,131 @@ VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET command.
>  The device MUST NOT queue packets on receive queues greater than
>  \field{virtqueue_pairs} once it has placed the
> VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET command in the used ring.
>
> +\paragraph{RSS hash offload}\label{sec:Device Types / Network Device /
> Device Operation / Control Virtqueue / RSS hash offload}
> +
> +\begin{lstlisting}
> +#define RSS_HASH_FUNCTION_NONE      1
> +#define RSS_HASH_FUNCTION_TOEPLITZ  2
> +#define RSS_HASH_FUNCTION_SYMMETRIC 3
> +
> +// Hash function fields
> +#define RSS_HASH_FIELDS_IPV4          0x00000100
> +#define RSS_HASH_FIELDS_TCP_IPV4      0x00000200
> +#define RSS_HASH_FIELDS_IPV6          0x00000400
> +#define RSS_HASH_FIELDS_IPV6_EX       0x00000800
> +#define RSS_HASH_FIELDS_TCP_IPV6      0x00001000
> +#define RSS_HASH_FIELDS_TCP_IPV6_EX   0x00002000
> +
> +struct virtio_net_ctrl_rss_hash{
> +le32 hash_function;
> +}
> +
> +struct virtio_net_rss {
> +le32 hash_function;
> +le32 hash_function_flags;
> +le32 hash_key_length;
> +le32 indirection_table_length;
> +       struct {
> +               le32 hash_key[hash_key_length];
> +               le32 indirection_table[indirection_table_length];
> +       }
> +};
> +
> +#define VIRTIO_NET_F_CTRL_RSS     24
> +
> +#define VIRTIO_NET_CTRL_RSS                           6
> +#define VIRTIO_NET_CTRL_RSS_GET_SUPPORTED_FUNCTIONS   0
> +#define VIRTIO_NET_CTRL_RSS_DISABLE                   1
> +#define VIRTIO_NET_CTRL_RSS_SET                       2
> +\end{lstlisting}
> +
> +If the VIRTIO_NET_F_CTRL_RSS is negotiated the driver can send control
> +commands for the RSS configuration.
> +
> +The class VIRTIO_NET_CTRL_RSS has three commands:
> +
> +\begin{enumerate}
> +\item VIRTIO_NET_CTRL_RSS_GET_SUPPLIED_FUNCTIONS returns the hash
> functions
> +       supported by the device to the driver.
> +\item VIRTIO_NET_CTRL_RSS_DISABLE Instructs the device that RSS hashing
> is no
> +       longer required.
> +\item VIRTIO_NET_CTRL_RSS_SET applies the new RSS configuration. The
> command is
> +       used by the driver for setting RSS hash function, hash key and
> +       indirection table in the device.
> +\end{enumerate}
> +
> +If this feaure has been negotiated, the virtio header has an additional
> +field{rss_hash_value} field attached to it.
> +
> +\devicenormative{\subparagraph}{RSS hash offload}{Device Types / Network
> Device / Device Operation / Control Virtqueue / RSS hash offload}
> +
> +The device MUST fill the virtio_net_ctrl_rss_hash structure with the hash
> +functions it supports and return the structure to the driver. Zero or more
> +flags of the RSS_HASH_FUNCTION flags MUST be used to fill the
> \field{hash_function}
> +field.
> +
> +Upon recieving VIRTIO_NET_CTRL_DISABLE the device SHOULD stop calculating
> and
> +attaching hashes for the packets as well as stop setting the
> VIRTIO_NET_HDR_GSO_RSS
> +in the \field{gso_type} field, however the \field{hash_function} field is
> kept
> +as a part of the header.
> +
> +The device MUST drop all previous RSS configuration upon receiving
> +VIRTIO_NET_CTRL_RSS_SET command.
> +
> +The device MUST set the RSS configuration according to the settings
> provided as
> +follows, once the configuration process is completed the device SHOULD
> apply
> +the hash function to each of the incoming packets and distribute the
> packets
> +through the virqueues using the calculated hash and the indirection table
> +that were earlier provided by the driver.
> +
> +Setting RSS configuration
> +\begin{enumerate}
> +\item The driver fills all of the fields and passes them through the
> control
> +       queue to the device.
> +
> +\item The device sets the RSS configuration as provided by the driver.
> +
> +\item If the device successfully applied the configuration, on each packet
> +       recieved the device MUST calculate the hashing for the packet and
> +       store it in the virtio-net header in rss_hash_value and the hash
> +       fields used in the calculation in rss_hash_type.
> +\end{enumerate}
> +
> +In case of any unexpected values/ unsupported hash function the driver
> +MUST return VIRTIO_NET_ERR in the \field{ack} field.
> +
> +\drivernormative{\subparagraph}{RSS hash offload}{Device Types / Network
> Device / Device Operation / Control Virtqueue / RSS hash offload}
> +
> +If the driver negotiates the feature VIRTIO_NET_F_CTRL_RSS the driver
> SHOULD
> +send VIRTIO_NET_CTRL_RSS_SET command to the device along with the RSS
> structure
> +filled. The RSS structure fields should be filled as follows:
> +
> +\begin{itemize}
> +\item The driver SHOULD choose the hash function that SHOULD be used and
> fill
> +       it in the \field{hash_function} field along with the approperiate
> flags
> +       in the \field{hash_function_flags} field. These flags inidicate to
> the
> +       device which packet fields MUST be used in the calculation process
> of
> +       the hash.
> +\item Once the hash function has been chosen a suitable hash key should
> be set
> +       in the \field{hash_key} field, the length of the key should be
> stored
> +       in the \field{hash_key_length} field.
> +\item Lastly the driver should fill the indirection table array in the
> +       \field{indirection_table} field while setting the array length in
> +       \field{indirection_table_length}. This structure is used by the
> device
> +       for determining in which RX virt queue the packet should be placed.
> +\end{itemize}
> +Once the configuration phase is over successfully, the packets SHOULD
> have the
> +\field{rss_hash_value} field with the hash value that was calculated by
> the
> +device.
> +
> +Whenever the driver wants to discard the current RSS settings, it can
> send an
> +VIRTIO_NET_CTRL_RSS_SET command along with rss structure that has
> +RSS_HASH_FUNCTION_NONE the \field{hash_function} field.
> +
> +The driver MUST check the \field{ack} field value provided by the device,
> in
> +case the value is not VIRTIO_NET_OK then the driver MUST hanlde faliure
> and
> +retry another hash function or else give up.
> +
>  \subparagraph{Legacy Interface: Automatic receive steering in multiqueue
> mode}\label{sec:Device Types / Network Device / Device Operation / Control
> Virtqueue / Automatic receive steering in multiqueue mode / Legacy
> Interface: Automatic receive steering in multiqueue mode}
>  When using the legacy interface, transitional devices and drivers
>  MUST format \field{virtqueue_pairs}
> --
> 2.13.6
>
>


-- 
Respectfully,
*Sameeh Jubran*
*Linkedin <https://il.linkedin.com/pub/sameeh-jubran/87/747/a8a>*
*Software Engineer @ Daynix <http://www.daynix.com>.*

--001a1140dbb405f05b05639ca07d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Please ignore the typos, I mistakenly sent the patch witho=
ut the fixes.<div>I&#39;ll resend the fixes along with v2.</div></div><div =
class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Thu, Jan 25, 2018 a=
t 6:27 PM, Sameeh Jubran <span dir=3D"ltr">&lt;<a href=3D"mailto:sameeh@day=
nix.com" target=3D"_blank">sameeh@daynix.com</a>&gt;</span> wrote:<br><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex"><div class=3D"HOEnZb"><div class=3D"h5">From: Sam=
eeh Jubran &lt;<a href=3D"mailto:sameeh.j@gmail.com">sameeh.j@gmail.com</a>=
&gt;<br>
<br>
Most modern high end network devices today support configurable hash functi=
ons,<br>
this commit introduces RSS - Receive Side Scaling - [1] to virtio net devic=
e.<br>
<br>
The RSS is a technology from Microsoft that boosts network device performan=
ce<br>
by efficiently distributing the traffic among the CPUs in a multiprocessor<=
br>
system.<br>
<br>
This feature is supported in most of the modern network cards as well as mo=
st<br>
modern OSes including Linux and Windows. It is worth mentioning that both D=
PDK<br>
and Hyper-v support RSS too.<br>
<br>
[1] <a href=3D"https://docs.microsoft.com/en-us/windows-hardware/drivers/ne=
twork/ndis-receive-side-scaling2" rel=3D"noreferrer" target=3D"_blank">http=
s://docs.microsoft.com/en-<wbr>us/windows-hardware/drivers/<wbr>network/ndi=
s-receive-side-<wbr>scaling2</a><br>
<br>
Signed-off-by: Sameeh Jubran &lt;<a href=3D"mailto:sjubran@redhat.com">sjub=
ran@redhat.com</a>&gt;<br>
---<br>
=C2=A0content.tex | 133 ++++++++++++++++++++++++++++++<wbr>++++++++++++++++=
++++++++++++++<br>
=C2=A01 file changed, 133 insertions(+)<br>
<br>
diff --git a/content.tex b/content.tex<br>
index c840588..5969b28 100644<br>
--- a/content.tex<br>
+++ b/content.tex<br>
@@ -3115,6 +3115,9 @@ features.<br>
<br>
=C2=A0\item[VIRTIO_NET_F_CTRL_MAC_<wbr>ADDR(23)] Set MAC address through co=
ntrol<br>
=C2=A0 =C2=A0 =C2=A0channel.<br>
+<br>
+\item[VIRTIO_NET_F_CTRL_RSS(<wbr>24)] Device supports configurable RSS has=
h<br>
+=C2=A0 =C2=A0 functions.<br>
=C2=A0\end{description}<br>
<br>
=C2=A0\subsubsection{Feature bit requirements}\label{sec:Device Types / Net=
work Device / Feature bits / Feature bit requirements}<br>
@@ -3138,6 +3141,8 @@ Some networking feature bits require other networking=
 feature bits<br>
=C2=A0\item[VIRTIO_NET_F_GUEST_<wbr>ANNOUNCE] Requires VIRTIO_NET_F_CTRL_VQ=
.<br>
=C2=A0\item[VIRTIO_NET_F_MQ] Requires VIRTIO_NET_F_CTRL_VQ.<br>
=C2=A0\item[VIRTIO_NET_F_CTRL_MAC_<wbr>ADDR] Requires VIRTIO_NET_F_CTRL_VQ.=
<br>
+<br>
+\item[VIRTIO_NET_F_CTRL_RSS] Requires VIRTIO_NET_F_MQ.<br>
=C2=A0\end{description}<br>
<br>
=C2=A0\subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types=
 / Network Device / Feature bits / Legacy Interface: Feature bits}<br>
@@ -3308,6 +3313,7 @@ struct virtio_net_hdr {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u8 flags;<br>
=C2=A0#define VIRTIO_NET_HDR_GSO_NONE=C2=A0 =C2=A0 =C2=A0 =C2=A0 0<br>
=C2=A0#define VIRTIO_NET_HDR_GSO_TCPV4=C2=A0 =C2=A0 =C2=A0 =C2=A01<br>
+#define VIRTIO_NET_HDR_GSO_RSS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02<br>
=C2=A0#define VIRTIO_NET_HDR_GSO_UDP=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A03<br>
=C2=A0#define VIRTIO_NET_HDR_GSO_TCPV6=C2=A0 =C2=A0 =C2=A0 =C2=A04<br>
=C2=A0#define VIRTIO_NET_HDR_GSO_ECN=C2=A0 =C2=A0 =C2=A0 0x80<br>
@@ -3317,6 +3323,8 @@ struct virtio_net_hdr {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0le16 csum_start;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0le16 csum_offset;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0le16 num_buffers;<br>
+// Only if RSS hash offload has been negotiated<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le64 rss_hash_value;<br>
=C2=A0};<br>
=C2=A0\end{lstlisting}<br>
<br>
@@ -4007,6 +4015,131 @@ VIRTIO_NET_CTRL_MQ_VQ_PAIRS_<wbr>SET command.<br>
=C2=A0The device MUST NOT queue packets on receive queues greater than<br>
=C2=A0\field{virtqueue_pairs} once it has placed the VIRTIO_NET_CTRL_MQ_VQ_=
PAIRS_<wbr>SET command in the used ring.<br>
<br>
+\paragraph{RSS hash offload}\label{sec:Device Types / Network Device / Dev=
ice Operation / Control Virtqueue / RSS hash offload}<br>
+<br>
+\begin{lstlisting}<br>
+#define RSS_HASH_FUNCTION_NONE=C2=A0 =C2=A0 =C2=A0 1<br>
+#define RSS_HASH_FUNCTION_TOEPLITZ=C2=A0 2<br>
+#define RSS_HASH_FUNCTION_SYMMETRIC 3<br>
+<br>
+// Hash function fields<br>
+#define RSS_HASH_FIELDS_IPV4=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x00000100<=
br>
+#define RSS_HASH_FIELDS_TCP_IPV4=C2=A0 =C2=A0 =C2=A0 0x00000200<br>
+#define RSS_HASH_FIELDS_IPV6=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x00000400<=
br>
+#define RSS_HASH_FIELDS_IPV6_EX=C2=A0 =C2=A0 =C2=A0 =C2=A00x00000800<br>
+#define RSS_HASH_FIELDS_TCP_IPV6=C2=A0 =C2=A0 =C2=A0 0x00001000<br>
+#define RSS_HASH_FIELDS_TCP_IPV6_EX=C2=A0 =C2=A00x00002000<br>
+<br>
+struct virtio_net_ctrl_rss_hash{<br>
+le32 hash_function;<br>
+}<br>
+<br>
+struct virtio_net_rss {<br>
+le32 hash_function;<br>
+le32 hash_function_flags;<br>
+le32 hash_key_length;<br>
+le32 indirection_table_length;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0le32 hash_key[hash_=
key_length];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0le32 indirection_ta=
ble[indirection_<wbr>table_length];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+};<br>
+<br>
+#define VIRTIO_NET_F_CTRL_RSS=C2=A0 =C2=A0 =C2=A024<br>
+<br>
+#define VIRTIO_NET_CTRL_RSS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A06<br>
+#define VIRTIO_NET_CTRL_RSS_GET_<wbr>SUPPORTED_FUNCTIONS=C2=A0 =C2=A00<br>
+#define VIRTIO_NET_CTRL_RSS_DISABLE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01<br>
+#define VIRTIO_NET_CTRL_RSS_SET=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02<br>
+\end{lstlisting}<br>
+<br>
+If the VIRTIO_NET_F_CTRL_RSS is negotiated the driver can send control<br>
+commands for the RSS configuration.<br>
+<br>
+The class VIRTIO_NET_CTRL_RSS has three commands:<br>
+<br>
+\begin{enumerate}<br>
+\item VIRTIO_NET_CTRL_RSS_GET_<wbr>SUPPLIED_FUNCTIONS returns the hash fun=
ctions<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0supported by the device to the driver.<br>
+\item VIRTIO_NET_CTRL_RSS_DISABLE Instructs the device that RSS hashing is=
 no<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0longer required.<br>
+\item VIRTIO_NET_CTRL_RSS_SET applies the new RSS configuration. The comma=
nd is<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0used by the driver for setting RSS hash functio=
n, hash key and<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0indirection table in the device.<br>
+\end{enumerate}<br>
+<br>
+If this feaure has been negotiated, the virtio header has an additional<br=
>
+field{rss_hash_value} field attached to it.<br>
+<br>
+\devicenormative{\<wbr>subparagraph}{RSS hash offload}{Device Types / Netw=
ork Device / Device Operation / Control Virtqueue / RSS hash offload}<br>
+<br>
+The device MUST fill the virtio_net_ctrl_rss_hash structure with the hash<=
br>
+functions it supports and return the structure to the driver. Zero or more=
<br>
+flags of the RSS_HASH_FUNCTION flags MUST be used to fill the \field{hash_=
function}<br>
+field.<br>
+<br>
+Upon recieving VIRTIO_NET_CTRL_DISABLE the device SHOULD stop calculating =
and<br>
+attaching hashes for the packets as well as stop setting the VIRTIO_NET_HD=
R_GSO_RSS<br>
+in the \field{gso_type} field, however the \field{hash_function} field is =
kept<br>
+as a part of the header.<br>
+<br>
+The device MUST drop all previous RSS configuration upon receiving<br>
+VIRTIO_NET_CTRL_RSS_SET command.<br>
+<br>
+The device MUST set the RSS configuration according to the settings provid=
ed as<br>
+follows, once the configuration process is completed the device SHOULD app=
ly<br>
+the hash function to each of the incoming packets and distribute the packe=
ts<br>
+through the virqueues using the calculated hash and the indirection table<=
br>
+that were earlier provided by the driver.<br>
+<br>
+Setting RSS configuration<br>
+\begin{enumerate}<br>
+\item The driver fills all of the fields and passes them through the contr=
ol<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0queue to the device.<br>
+<br>
+\item The device sets the RSS configuration as provided by the driver.<br>
+<br>
+\item If the device successfully applied the configuration, on each packet=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0recieved the device MUST calculate the hashing =
for the packet and<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0store it in the virtio-net header in rss_hash_v=
alue and the hash<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fields used in the calculation in rss_hash_type=
.<br>
+\end{enumerate}<br>
+<br>
+In case of any unexpected values/ unsupported hash function the driver<br>
+MUST return VIRTIO_NET_ERR in the \field{ack} field.<br>
+<br>
+\drivernormative{\<wbr>subparagraph}{RSS hash offload}{Device Types / Netw=
ork Device / Device Operation / Control Virtqueue / RSS hash offload}<br>
+<br>
+If the driver negotiates the feature VIRTIO_NET_F_CTRL_RSS the driver SHOU=
LD<br>
+send VIRTIO_NET_CTRL_RSS_SET command to the device along with the RSS stru=
cture<br>
+filled. The RSS structure fields should be filled as follows:<br>
+<br>
+\begin{itemize}<br>
+\item The driver SHOULD choose the hash function that SHOULD be used and f=
ill<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0it in the \field{hash_function} field along wit=
h the approperiate flags<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0in the \field{hash_function_flags} field. These=
 flags inidicate to the<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0device which packet fields MUST be used in the =
calculation process of<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0the hash.<br>
+\item Once the hash function has been chosen a suitable hash key should be=
 set<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0in the \field{hash_key} field, the length of th=
e key should be stored<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0in the \field{hash_key_length} field.<br>
+\item Lastly the driver should fill the indirection table array in the<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0\field{indirection_table} field while setting t=
he array length in<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0\field{indirection_table_<wbr>length}. This str=
ucture is used by the device<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0for determining in which RX virt queue the pack=
et should be placed.<br>
+\end{itemize}<br>
+Once the configuration phase is over successfully, the packets SHOULD have=
 the<br>
+\field{rss_hash_value} field with the hash value that was calculated by th=
e<br>
+device.<br>
+<br>
+Whenever the driver wants to discard the current RSS settings, it can send=
 an<br>
+VIRTIO_NET_CTRL_RSS_SET command along with rss structure that has<br>
+RSS_HASH_FUNCTION_NONE the \field{hash_function} field.<br>
+<br>
+The driver MUST check the \field{ack} field value provided by the device, =
in<br>
+case the value is not VIRTIO_NET_OK then the driver MUST hanlde faliure an=
d<br>
+retry another hash function or else give up.<br>
+<br>
=C2=A0\subparagraph{Legacy Interface: Automatic receive steering in multiqu=
eue mode}\label{sec:Device Types / Network Device / Device Operation / Cont=
rol Virtqueue / Automatic receive steering in multiqueue mode / Legacy Inte=
rface: Automatic receive steering in multiqueue mode}<br>
=C2=A0When using the legacy interface, transitional devices and drivers<br>
=C2=A0MUST format \field{virtqueue_pairs}<br>
--<br>
2.13.6<br>
<br>
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
</div>

--001a1140dbb405f05b05639ca07d--
