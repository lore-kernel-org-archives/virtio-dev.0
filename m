Return-Path: virtio-dev-return-3850-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 0F12C5818F87
	for <virtio-dev@lists.oasis-open.org>; Tue, 17 Apr 2018 04:18:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <cb72bb71-f6d5-838f-33da-8b58f9f41486@oracle.com>
References: <20180416130526.6233-1-sameeh@daynix.com> <20180416130526.6233-3-sameeh@daynix.com>
 <cb72bb71-f6d5-838f-33da-8b58f9f41486@oracle.com>
From: Sameeh Jubran <sameeh@daynix.com>
Date: Tue, 17 Apr 2018 14:18:00 +0300
Message-ID: <CAKPgXcEXFHhizfMWs4yGkgp5te8DDZqfzmZXK4B5PscE1iR-FQ@mail.gmail.com>
Content-Type: multipart/alternative; boundary="089e08210a3cc6c0a0056a097d9c"
Subject: [virtio-dev] Re: [PATCH v2 2/2] content: net: steering mode: Add RSS
To: Vijayabhaskar Balakrishna <vijay.balakrishna@oracle.com>
Cc: virtio-dev <virtio-dev@lists.oasis-open.org>, Jason Wang <jasowang@redhat.com>, Yan Vugenfirer <yan@daynix.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--089e08210a3cc6c0a0056a097d9c
Content-Type: text/plain; charset="UTF-8"

On Tue, Apr 17, 2018 at 4:30 AM, Vijayabhaskar Balakrishna <
vijay.balakrishna@oracle.com> wrote:

>
>
> On 4/16/2018 6:05 AM, Sameeh Jubran wrote:
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
>>   content.tex | 114 ++++++++++++++++++++++++++++++
>> ++++++++++++++++++++++++++++++
>>   1 file changed, 114 insertions(+)
>>
>> diff --git a/content.tex b/content.tex
>> index 3d538e8..8076147 100644
>> --- a/content.tex
>> +++ b/content.tex
>> @@ -4017,6 +4017,7 @@ The device MUST NOT queue packets on receive queues
>> greater than
>>   \begin{lstlisting}
>>   // steering mode flags
>>   #define STEERING_MODE_AUTO          1
>> +#define STEERING_MODE_RSS           2
>>     struct virtio_net_steering_modes {
>>   le32 steering_modes;
>> @@ -4027,6 +4028,7 @@ le32 steering_mode;
>>   le32 command;
>>         union {
>> +    struct virtio_net_rss rss_conf;
>>       }
>>   };
>>   @@ -4066,6 +4068,118 @@ If this feature has been negotiated, the virtio
>> header has an additional
>>     This is the default steering mode, please refer to the "Automatic
>> receive steering in multiqueue" section.
>>   +\subparagraph{Receive Side Scaling}{Device Types / Network Device /
>> Device Operation / Control Virtqueue / Steering mode / Receive Side Scaling}
>> +
>> +\begin{lstlisting}
>> +#define RSS_HASH_FUNCTION_NONE      1
>> +#define RSS_HASH_FUNCTION_TOEPLITZ  2
>> +#define RSS_HASH_FUNCTION_SYMMETRIC 3
>>
> Above are bit fields?  Should it be 0x1, 0x2, 0x4 etc.,

Will do.

>
> +
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
>> +commands for the RSS configuration. For configuring RSS the
>> virtio_net_steering_mode
>> +should be filled. The \field{steering_mode} field should be filled with
>> the STEERING_MODE_RSS
>> +flag along with one of the VIRTIO_NET_SM_CTRL_RSS commands in the
>> \field{command} field. The
>> +\field{rss_conf} field should be used.
>> +
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
>> +functions it supports and return the structure to the driver. Zero or
>> more
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
>> +the hash function to each of the incoming packets and distribute the
>> packets
>> +through the virqueues using the calculated hash and the indirection table
>> +that were earlier provided by the driver.
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
>> +       received the device MUST calculate the hashing for the packet and
>>
> calculate the hash for the packet..
>
>> +       store it in the virtio-net header in the \field{hash} field and
>> the
>> +       hash fields used in the calculation in rss_hash_type.
>>
> "rss_hash_type" carryover from previous (v1) patch?  May be should say:
>
>  MUST calculate the hash for the packet using fields specified in
> hash_function_flags
>
Will do thanks :)

>
>

> +\end{enumerate}
>> +
>> +In case of any unexpected values/ unsupported hash function the driver
>> +MUST return VIRTIO_NET_ERR in the \field{ack} field.
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
>> +\item Once the hash function has been chosen a suitable hash key should
>> be set
>> +       in the \field{hash_key} field, the length of the key should be
>> stored
>> +       in the \field{hash_key_length} field.
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
>> +Whenever the driver wants to discard the current RSS settings, it can
>> send an
>> +VIRTIO_NET_SM_CTRL_RSS_SET command along with rss structure that has
>> +RSS_HASH_FUNCTION_NONE the \field{hash_function} field.
>> +
>> +The driver MUST check the \field{ack} field value provided by the
>> device, in
>> +case the value is not VIRTIO_NET_OK then the driver MUST handle failure
>> and
>> +retry another hash function or else give up.
>> +
>>   \subparagraph{Legacy Interface: Automatic receive steering in
>> multiqueue mode}\label{sec:Device Types / Network Device / Device Operation
>> / Control Virtqueue / Automatic receive steering in multiqueue mode /
>> Legacy Interface: Automatic receive steering in multiqueue mode}
>>   When using the legacy interface, transitional devices and drivers
>>   MUST format \field{virtqueue_pairs}
>>
>
>


-- 
Respectfully,
*Sameeh Jubran*
*Linkedin <https://il.linkedin.com/pub/sameeh-jubran/87/747/a8a>*
*Software Engineer @ Daynix <http://www.daynix.com>.*

--089e08210a3cc6c0a0056a097d9c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Tue, Apr 17, 2018 at 4:30 AM, Vijayabhaskar Balakrishna <span dir=3D=
"ltr">&lt;<a href=3D"mailto:vijay.balakrishna@oracle.com" target=3D"_blank"=
>vijay.balakrishna@oracle.com</a>&gt;</span> wrote:<br><blockquote class=3D=
"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding=
-left:1ex"><div class=3D"HOEnZb"><div class=3D"h5"><br>
<br>
On 4/16/2018 6:05 AM, Sameeh Jubran wrote:<br>
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
=C2=A0 content.tex | 114 ++++++++++++++++++++++++++++++<wbr>+++++++++++++++=
+++++++++++++++<br>
=C2=A0 1 file changed, 114 insertions(+)<br>
<br>
diff --git a/content.tex b/content.tex<br>
index 3d538e8..8076147 100644<br>
--- a/content.tex<br>
+++ b/content.tex<br>
@@ -4017,6 +4017,7 @@ The device MUST NOT queue packets on receive queues g=
reater than<br>
=C2=A0 \begin{lstlisting}<br>
=C2=A0 // steering mode flags<br>
=C2=A0 #define STEERING_MODE_AUTO=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1<br>
+#define STEERING_MODE_RSS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02<br>
=C2=A0 =C2=A0 struct virtio_net_steering_modes {<br>
=C2=A0 le32 steering_modes;<br>
@@ -4027,6 +4028,7 @@ le32 steering_mode;<br>
=C2=A0 le32 command;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 union {<br>
+=C2=A0 =C2=A0 struct virtio_net_rss rss_conf;<br>
=C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 };<br>
=C2=A0 @@ -4066,6 +4068,118 @@ If this feature has been negotiated, the vir=
tio header has an additional<br>
=C2=A0 =C2=A0 This is the default steering mode, please refer to the &quot;=
Automatic receive steering in multiqueue&quot; section.<br>
=C2=A0 +\subparagraph{Receive Side Scaling}{Device Types / Network Device /=
 Device Operation / Control Virtqueue / Steering mode / Receive Side Scalin=
g}<br>
+<br>
+\begin{lstlisting}<br>
+#define RSS_HASH_FUNCTION_NONE=C2=A0 =C2=A0 =C2=A0 1<br>
+#define RSS_HASH_FUNCTION_TOEPLITZ=C2=A0 2<br>
+#define RSS_HASH_FUNCTION_SYMMETRIC 3<br>
</blockquote></div></div>
Above are bit fields?=C2=A0 Should it be 0x1, 0x2, 0x4 etc.,</blockquote><d=
iv>Will do.=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 =
0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div><div class=3D"h5=
"><br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
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
+commands for the RSS configuration. For configuring RSS the virtio_net_ste=
ering_mode<br>
+should be filled. The \field{steering_mode} field should be filled with th=
e STEERING_MODE_RSS<br>
+flag along with one of the VIRTIO_NET_SM_CTRL_RSS commands in the \field{c=
ommand} field. The<br>
+\field{rss_conf} field should be used.<br>
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
+functions it supports and return the structure to the driver. Zero or more=
<br>
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
+=C2=A0 =C2=A0 =C2=A0 =C2=A0received the device MUST calculate the hashing =
for the packet and<br>
</blockquote></div></div>
calculate the hash for the packet..<span class=3D""><br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0store it in the virtio-net header in the \field=
{hash} field and the<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0hash fields used in the calculation in rss_hash=
_type.<br>
</blockquote></span>
&quot;rss_hash_type&quot; carryover from previous (v1) patch?=C2=A0 May be =
should say:<br>
<br>
=C2=A0MUST calculate the hash for the packet using fields specified in hash=
_function_flags<div class=3D"HOEnZb"><div class=3D"h5"><span style=3D"color=
:rgb(34,34,34)"></span></div></div></blockquote><div>Will do thanks :)=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><div class=3D=
"h5"><span style=3D"color:rgb(34,34,34)">=C2=A0</span><br></div></div></blo=
ckquote><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border=
-left:1px #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><div class=3D"=
h5">
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
+\end{enumerate}<br>
+<br>
+In case of any unexpected values/ unsupported hash function the driver<br>
+MUST return VIRTIO_NET_ERR in the \field{ack} field.<br>
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
+\item Once the hash function has been chosen a suitable hash key should be=
 set<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0in the \field{hash_key} field, the length of th=
e key should be stored<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0in the \field{hash_key_length} field.<br>
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
+Whenever the driver wants to discard the current RSS settings, it can send=
 an<br>
+VIRTIO_NET_SM_CTRL_RSS_SET command along with rss structure that has<br>
+RSS_HASH_FUNCTION_NONE the \field{hash_function} field.<br>
+<br>
+The driver MUST check the \field{ack} field value provided by the device, =
in<br>
+case the value is not VIRTIO_NET_OK then the driver MUST handle failure an=
d<br>
+retry another hash function or else give up.<br>
+<br>
=C2=A0 \subparagraph{Legacy Interface: Automatic receive steering in multiq=
ueue mode}\label{sec:Device Types / Network Device / Device Operation / Con=
trol Virtqueue / Automatic receive steering in multiqueue mode / Legacy Int=
erface: Automatic receive steering in multiqueue mode}<br>
=C2=A0 When using the legacy interface, transitional devices and drivers<br=
>
=C2=A0 MUST format \field{virtqueue_pairs}<br>
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

--089e08210a3cc6c0a0056a097d9c--
