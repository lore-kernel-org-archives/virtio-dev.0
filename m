Return-Path: virtio-dev-return-4007-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id E2A595818F01
	for <virtio-dev@lists.oasis-open.org>; Sun, 29 Apr 2018 03:23:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <c5fc4733-6adf-effb-5b99-d3bf445b1175@oracle.com>
References: <20180418104656.1450-1-sameeh@daynix.com> <20180418104656.1450-3-sameeh@daynix.com>
 <c5fc4733-6adf-effb-5b99-d3bf445b1175@oracle.com>
From: Sameeh Jubran <sameeh@daynix.com>
Date: Sun, 29 Apr 2018 13:23:08 +0300
Message-ID: <CAKPgXcFNY7ccLdKuKnv4u=tTQKEM-h1jwps4uhhkMMGUXtbRRw@mail.gmail.com>
Content-Type: multipart/alternative; boundary="0000000000009e99c8056afa1f24"
Subject: Re: [virtio-dev] [PATCH v3 2/2] content: net: steering mode: Add RSS
To: Vijayabhaskar Balakrishna <vijay.balakrishna@oracle.com>
Cc: virtio-dev <virtio-dev@lists.oasis-open.org>, Amnon Ilan <ailan@redhat.com>, Yan Vugenfirer <yan@daynix.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--0000000000009e99c8056afa1f24
Content-Type: text/plain; charset="UTF-8"

On Sat, Apr 28, 2018 at 1:09 AM, Vijayabhaskar Balakrishna <
vijay.balakrishna@oracle.com> wrote:

> Hi Sameeh,
>
> See inline..
>
> Thanks,
> Vijay
>
> On 4/18/2018 3:46 AM, Sameeh Jubran wrote:
>
>> From: Sameeh Jubran <sjubran@redhat.com>
>>
>> This commit introduces the RSS feature into virtio-net. It is introduced
>> as a sub mode for a general command which configures the steering mode.
>>
>> Most modern high end network devices today support configurable hash
>> functions,
>> this commit introduces RSS - Receive Side Scaling - [1] to virtio net
>> device.
>>
>> The RSS is a technology from Microsoft that boosts network device
>> performance
>> by efficiently distributing the traffic among the CPUs in a multiprocessor
>> system.
>>
>> This feature is supported in most of the modern network cards as well as
>> most
>> modern OSes including Linux and Windows. It is worth mentioning that both
>> DPDK
>> and Hyper-v support RSS too.
>>
>> [1] https://docs.microsoft.com/en-us/windows-hardware/drivers/ne
>> twork/ndis-receive-side-scaling2
>>
>> Signed-off-by: Sameeh Jubran <sjubran@redhat.com>
>> ---
>>   content.tex | 109 ++++++++++++++++++++++++++++++
>> ++++++++++++++++++++++++++++++
>>   1 file changed, 109 insertions(+)
>>
>> diff --git a/content.tex b/content.tex
>> index 6b1f7ca..3ea2b6a 100644
>> --- a/content.tex
>> +++ b/content.tex
>> @@ -4023,6 +4023,7 @@ according to the native endian of the guest rather
>> than
>>   \begin{lstlisting}
>>   // steering mode flags
>>   #define STEERING_MODE_AUTO          0x1
>> +#define STEERING_MODE_RSS           0x2
>>     // Used by the devide for returning to the driver the supported
>> steering modes
>>   struct virtio_net_steering_modes {
>> @@ -4035,6 +4036,7 @@ le32 command;
>>     // A union which can be used for passing structures to one of the sub
>> modes
>>       union {
>> +    struct virtio_net_rss rss_conf;
>>       }
>>   };
>>   @@ -4074,6 +4076,113 @@ If this feature has been negotiated, the virtio
>> header has an additional
>>     This is the default steering mode, please refer to the "Automatic
>> receive steering in multiqueue" section.
>>   +\subparagraph{Receive Side Scaling}{Device Types / Network Device /
>> Device Operation / Control Virtqueue / Steering mode / Receive Side Scaling}
>> +
>> +\begin{lstlisting}
>> +#define RSS_HASH_FUNCTION_TOEPLITZ  0x1
>> +#define RSS_HASH_FUNCTION_SYMMETRIC 0x2
>> +
>> +// Hash function fields
>> +#define RSS_HASH_FIELDS_IPV4          0x00000100
>> +#define RSS_HASH_FIELDS_TCP_IPV4      0x00000200
>> +#define RSS_HASH_FIELDS_IPV6          0x00000400
>> +#define RSS_HASH_FIELDS_IPV6_EX       0x00000800
>> +#define RSS_HASH_FIELDS_TCP_IPV6      0x00001000
>> +#define RSS_HASH_FIELDS_TCP_IPV6_EX   0x00002000
>> +
>> +struct virtio_net_rss_supported_hash{
>> +le32 hash_function;
>> +}
>> +
>> +struct virtio_net_rss {
>> +le32 hash_function;
>> +le32 hash_function_flags;
>> +le32 hash_key_length;
>> +le32 indirection_table_length;
>> +       struct {
>> +               le32 hash_key[hash_key_length];
>> +               le32 indirection_table[indirection_table_length];
>> +       }
>> +};
>> +
>> +#define VIRTIO_NET_SM_CTRL_RSS_GET_SUPPORTED_FUNCTIONS   0
>> +#define VIRTIO_NET_SM_CTRL_RSS_SET                       1
>> +\end{lstlisting}
>> +
>> +If the VIRTIO_NET_F_CTRL_STEERING_MODE is negotiated the driver can
>> send control
>> +commands using the VIRTIO_NET_CTRL_SM_CONTROL command along with the
>> STEERING_MODE_RSS
>> +flag for configuring RSS the virtio_net_steering_mode should be filled.
>> The
>> +\field{steering_mode} field should be filled with the STEERING_MODE_RSS
>> flag along
>> +with one of the VIRTIO_NET_SM_CTRL_RSS commands in the \field{command}
>> field. The
>> +\field{rss_conf} field should be used.
>>
> May be reworded for clarify along the lines: If
> theVIRTIO_NET_F_CTRL_STEERING_MODE
> feature bit is negotiated, the driver can send steering mode control
> command,
> VIRTIO_NET_CTRL_SM_CONTROL, with the STEERING_MODE_RSSflag for configuring
> RSS provided
> it is one of the supported modes.  The supported steering modes returned
> by device in
> response to VIRTIO_NET_CTRL_SM_GET_SUPPORTED_MODES command issued by the
> driver.
> For configuring particulars of RSS steering mode, the various fields of
> virtio_net_steering_mode should be filled by the driver.  This includes
> \field{steering_mode} with  STEERING_MODE_RSS flag along
> with one of the VIRTIO_NET_SM_CTRL_RSS commands in the \field{command}
> field in addition to union \field{rss_conf} field members.

Thanks for the suggestions, I'll rephrase the paragraph based on the above.

>
> +
>> +The class VIRTIO_NET_CTRL_RSS has two commands:
>> +
>> +\begin{enumerate}
>> +\item VIRTIO_NET_SM_CTRL_RSS_GET_SUPPORTED_FUNCTIONS returns the hash
>> functions
>> +       supported by the device to the driver.
>> +\item VIRTIO_NET_SM_CTRL_RSS_SET applies the new RSS configuration. The
>> command is
>> +       used by the driver for setting RSS hash function, hash key and
>> +       indirection table in the device.
>> +\end{enumerate}
>> +
>> +\devicenormative{\subparagraph}{Receive Side Scaling}{Device Types /
>> Network Device / Device Operation / Control Virtqueue / Steering mode /
>> Receive Side Scaling}
>> +
>> +The device MUST fill the virtio_net_rss_supported_hash structure with
>> the hash
>> +functions it supports and return the structure to the driver. One or more
>> +flags of the RSS_HASH_FUNCTION flags MUST be used to fill the
>> \field{hash_function}
>> +field.
>> +
>> +The device MUST drop all previous RSS configuration upon receiving
>> +VIRTIO_NET_SM_CTRL_RSS_SET command.
>> +
>> +The device MUST set the RSS configuration according to the settings
>> provided as
>> +follows, once the configuration process is completed the device SHOULD
>> apply
>> +the hash function to each of the incoming packets with regards to the
>> flags in
>> +the \field{hash_function_flags} fields and distribute the packets
>> through the
>> +virqueues using the calculated hash and the indirection table that were
>> earlier
>> +provided by the driver.
>> +
>> +Setting RSS configuration
>> +\begin{enumerate}
>> +\item The driver fills all of the fields and passes them through the
>> control
>> +       queue to the device.
>> +
>> +\item The device sets the RSS configuration as provided by the driver.
>> +
>> +\item If the device successfully applied the configuration, on each
>> packet
>> +       received the device MUST calculate the hash for the packet using
>> +       the fields specified in \field{hash_function_flags} and store it
>> in the
>> +       virtio-net header in the \field{hash} field and the hash fields
>> +       used in the calculation.
>> +\end{enumerate}
>> +
>> +\drivernormative{\subparagraph}{Receive Side Scaling}{Device Types /
>> Network Device / Device Operation / Control Virtqueue / Steering mode /
>> Receive Side Scaling}
>> +
>> +If the driver wants to set RSS hash it should fill the RSS structure
>> fields
>> +as follows:
>> +
>> +\begin{itemize}
>> +\item The driver SHOULD choose the hash function that SHOULD be used and
>> fill
>> +       it in the \field{hash_function} field along with the appropriate
>> flags
>> +       in the \field{hash_function_flags} field. These flags indicate to
>> the
>> +       device which packet fields MUST be used in the calculation
>> process of
>> +       the hash.
>> +\item Once the hash function has been chosen a hash key should also be
>> set by
>> +       the driver in the \field{hash_key} field, the length of the key
>> should
>> +       be stored in the \field{hash_key_length} field.
>> +\item Lastly the driver should fill the indirection table array in the
>> +       \field{indirection_table} field while setting the array length in
>> +       \field{indirection_table_length}. This structure is used by the
>> device
>> +       for determining in which RX virt queue the packet should be
>> placed.
>> +\end{itemize}
>> +Once the configuration phase is over successfully, the packets SHOULD
>> have the
>> +\field{hash} field with the hash value that was calculated by the device.
>> +
>> +Whenever the driver wants to stop performing RSS, it can switch back to
>>
> Should we say: ..stop performing RSS or any earlier configured steering
> mode,

Since this section is devoted to RSS I think we should keep this RSS
specific.

>
> +Automatic Steering Mode using the VIRTIO_NET_CTRL_SM_CONTROL command
>> along with
>> +the STEERING_MODE_AUTO flag.
>> +
>>   \paragraph{Offloads State Configuration}\label{sec:Device Types /
>> Network Device / Device Operation / Control Virtqueue / Offloads State
>> Configuration}
>>     If the VIRTIO_NET_F_CTRL_GUEST_OFFLOADS feature is negotiated, the
>> driver can
>>
>
>


-- 
Respectfully,
*Sameeh Jubran*
*Linkedin <https://il.linkedin.com/pub/sameeh-jubran/87/747/a8a>*
*Software Engineer @ Daynix <http://www.daynix.com>.*

--0000000000009e99c8056afa1f24
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Sat, Apr 28, 2018 at 1:09 AM, Vijayabhaskar Balakrishna <span dir=3D=
"ltr">&lt;<a href=3D"mailto:vijay.balakrishna@oracle.com" target=3D"_blank"=
>vijay.balakrishna@oracle.com</a>&gt;</span> wrote:<br><blockquote class=3D=
"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding=
-left:1ex">Hi Sameeh,<br>
<br>
See inline..<br>
<br>
Thanks,<br>
Vijay<div><div class=3D"h5"><br>
On 4/18/2018 3:46 AM, Sameeh Jubran wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
From: Sameeh Jubran &lt;<a href=3D"mailto:sjubran@redhat.com" target=3D"_bl=
ank">sjubran@redhat.com</a>&gt;<br>
<br>
This commit introduces the RSS feature into virtio-net. It is introduced<br=
>
as a sub mode for a general command which configures the steering mode.<br>
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
s://docs.microsoft.com/en-<wbr>us/windows-hardware/drivers/ne<wbr>twork/ndi=
s-receive-side-scalin<wbr>g2</a><br>
<br>
Signed-off-by: Sameeh Jubran &lt;<a href=3D"mailto:sjubran@redhat.com" targ=
et=3D"_blank">sjubran@redhat.com</a>&gt;<br>
---<br>
=C2=A0 content.tex | 109 ++++++++++++++++++++++++++++++<wbr>+++++++++++++++=
+++++++++++++++<br>
=C2=A0 1 file changed, 109 insertions(+)<br>
<br>
diff --git a/content.tex b/content.tex<br>
index 6b1f7ca..3ea2b6a 100644<br>
--- a/content.tex<br>
+++ b/content.tex<br>
@@ -4023,6 +4023,7 @@ according to the native endian of the guest rather th=
an<br>
=C2=A0 \begin{lstlisting}<br>
=C2=A0 // steering mode flags<br>
=C2=A0 #define STEERING_MODE_AUTO=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x1<br>
+#define STEERING_MODE_RSS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x2<br>
=C2=A0 =C2=A0 // Used by the devide for returning to the driver the support=
ed steering modes<br>
=C2=A0 struct virtio_net_steering_modes {<br>
@@ -4035,6 +4036,7 @@ le32 command;<br>
=C2=A0 =C2=A0 // A union which can be used for passing structures to one of=
 the sub modes<br>
=C2=A0 =C2=A0 =C2=A0 union {<br>
+=C2=A0 =C2=A0 struct virtio_net_rss rss_conf;<br>
=C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 };<br>
=C2=A0 @@ -4074,6 +4076,113 @@ If this feature has been negotiated, the vir=
tio header has an additional<br>
=C2=A0 =C2=A0 This is the default steering mode, please refer to the &quot;=
Automatic receive steering in multiqueue&quot; section.<br>
=C2=A0 +\subparagraph{Receive Side Scaling}{Device Types / Network Device /=
 Device Operation / Control Virtqueue / Steering mode / Receive Side Scalin=
g}<br>
+<br>
+\begin{lstlisting}<br>
+#define RSS_HASH_FUNCTION_TOEPLITZ=C2=A0 0x1<br>
+#define RSS_HASH_FUNCTION_SYMMETRIC 0x2<br>
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
+struct virtio_net_rss_supported_hash{<br>
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
+#define VIRTIO_NET_SM_CTRL_RSS_GET_SUP<wbr>PORTED_FUNCTIONS=C2=A0 =C2=A00<=
br>
+#define VIRTIO_NET_SM_CTRL_RSS_SET=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01<br>
+\end{lstlisting}<br>
+<br>
+If the VIRTIO_NET_F_CTRL_STEERING_MOD<wbr>E is negotiated the driver can s=
end control<br>
+commands using the VIRTIO_NET_CTRL_SM_CONTROL command along with the STEER=
ING_MODE_RSS<br>
+flag for configuring RSS the virtio_net_steering_mode should be filled. Th=
e<br>
+\field{steering_mode} field should be filled with the STEERING_MODE_RSS fl=
ag along<br>
+with one of the VIRTIO_NET_SM_CTRL_RSS commands in the \field{command} fie=
ld. The<br>
+\field{rss_conf} field should be used.<br>
</blockquote></div></div>
May be reworded for clarify along the lines: If theVIRTIO_NET_F_CTRL_STEERI=
NG_<wbr>MODE<br>
feature bit is negotiated, the driver can send steering mode control comman=
d,<br>
VIRTIO_NET_CTRL_SM_CONTROL, with the STEERING_MODE_RSSflag for configuring =
RSS provided<br>
it is one of the supported modes.=C2=A0 The supported steering modes return=
ed by device in<br>
response to VIRTIO_NET_CTRL_SM_GET_SUPPORT<wbr>ED_MODES command issued by t=
he driver.<br>
For configuring particulars of RSS steering mode, the various fields of<br>
virtio_net_steering_mode should be filled by the driver.=C2=A0 This include=
s<br>
\field{steering_mode} with=C2=A0 STEERING_MODE_RSS flag along<span class=3D=
""><br>
with one of the VIRTIO_NET_SM_CTRL_RSS commands in the \field{command}<br><=
/span>
field in addition to union \field{rss_conf} field members.</blockquote><div=
>Thanks for the suggestions, I&#39;ll rephrase the paragraph based on the a=
bove.=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex"><div><div class=3D"h5"><br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
+<br>
+The class VIRTIO_NET_CTRL_RSS has two commands:<br>
+<br>
+\begin{enumerate}<br>
+\item VIRTIO_NET_SM_CTRL_RSS_GET_SUP<wbr>PORTED_FUNCTIONS returns the hash=
 functions<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0supported by the device to the driver.<br>
+\item VIRTIO_NET_SM_CTRL_RSS_SET applies the new RSS configuration. The co=
mmand is<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0used by the driver for setting RSS hash functio=
n, hash key and<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0indirection table in the device.<br>
+\end{enumerate}<br>
+<br>
+\devicenormative{\subparagrap<wbr>h}{Receive Side Scaling}{Device Types / =
Network Device / Device Operation / Control Virtqueue / Steering mode / Rec=
eive Side Scaling}<br>
+<br>
+The device MUST fill the virtio_net_rss_supported_hash structure with the =
hash<br>
+functions it supports and return the structure to the driver. One or more<=
br>
+flags of the RSS_HASH_FUNCTION flags MUST be used to fill the \field{hash_=
function}<br>
+field.<br>
+<br>
+The device MUST drop all previous RSS configuration upon receiving<br>
+VIRTIO_NET_SM_CTRL_RSS_SET command.<br>
+<br>
+The device MUST set the RSS configuration according to the settings provid=
ed as<br>
+follows, once the configuration process is completed the device SHOULD app=
ly<br>
+the hash function to each of the incoming packets with regards to the flag=
s in<br>
+the \field{hash_function_flags} fields and distribute the packets through =
the<br>
+virqueues using the calculated hash and the indirection table that were ea=
rlier<br>
+provided by the driver.<br>
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
+=C2=A0 =C2=A0 =C2=A0 =C2=A0received the device MUST calculate the hash for=
 the packet using<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0the fields specified in \field{hash_function_fl=
ags} and store it in the<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0virtio-net header in the \field{hash} field and=
 the hash fields<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0used in the calculation.<br>
+\end{enumerate}<br>
+<br>
+\drivernormative{\subparagrap<wbr>h}{Receive Side Scaling}{Device Types / =
Network Device / Device Operation / Control Virtqueue / Steering mode / Rec=
eive Side Scaling}<br>
+<br>
+If the driver wants to set RSS hash it should fill the RSS structure field=
s<br>
+as follows:<br>
+<br>
+\begin{itemize}<br>
+\item The driver SHOULD choose the hash function that SHOULD be used and f=
ill<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0it in the \field{hash_function} field along wit=
h the appropriate flags<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0in the \field{hash_function_flags} field. These=
 flags indicate to the<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0device which packet fields MUST be used in the =
calculation process of<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0the hash.<br>
+\item Once the hash function has been chosen a hash key should also be set=
 by<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0the driver in the \field{hash_key} field, the l=
ength of the key should<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0be stored in the \field{hash_key_length} field.=
<br>
+\item Lastly the driver should fill the indirection table array in the<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0\field{indirection_table} field while setting t=
he array length in<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0\field{indirection_table_leng<wbr>th}. This str=
ucture is used by the device<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0for determining in which RX virt queue the pack=
et should be placed.<br>
+\end{itemize}<br>
+Once the configuration phase is over successfully, the packets SHOULD have=
 the<br>
+\field{hash} field with the hash value that was calculated by the device.<=
br>
+<br>
+Whenever the driver wants to stop performing RSS, it can switch back to<br=
>
</blockquote></div></div>
Should we say: ..stop performing RSS or any earlier configured steering mod=
e,</blockquote><div>Since this section is devoted to RSS I think we should =
keep this RSS specific.=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div cla=
ss=3D"HOEnZb"><div class=3D"h5"><br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
+Automatic Steering Mode using the VIRTIO_NET_CTRL_SM_CONTROL command along=
 with<br>
+the STEERING_MODE_AUTO flag.<br>
+<br>
=C2=A0 \paragraph{Offloads State Configuration}\label{sec:Devic<wbr>e Types=
 / Network Device / Device Operation / Control Virtqueue / Offloads State C=
onfiguration}<br>
=C2=A0 =C2=A0 If the VIRTIO_NET_F_CTRL_GUEST_OFFLOA<wbr>DS feature is negot=
iated, the driver can<br>
</blockquote>
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
</div></div>

--0000000000009e99c8056afa1f24--
