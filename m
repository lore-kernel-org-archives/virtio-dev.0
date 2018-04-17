Return-Path: virtio-dev-return-3849-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 0FBED5818F87
	for <virtio-dev@lists.oasis-open.org>; Tue, 17 Apr 2018 04:10:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <ea3d688f-34fc-845b-60d1-ac46e2b347da@oracle.com>
References: <20180416130526.6233-1-sameeh@daynix.com> <20180416130526.6233-2-sameeh@daynix.com>
 <ea3d688f-34fc-845b-60d1-ac46e2b347da@oracle.com>
From: Sameeh Jubran <sameeh@daynix.com>
Date: Tue, 17 Apr 2018 14:10:52 +0300
Message-ID: <CAKPgXcE920tYZhzQzYAsDGZnX2jcFjgq+qg0S=nfF=ti7N2MAg@mail.gmail.com>
Content-Type: multipart/alternative; boundary="089e08210a3c44308d056a09647e"
Subject: [virtio-dev] Re: [PATCH v2 1/2] content: net: Add VIRTIO_NET_F_CTRL_STEERING_MODE feature
To: Vijayabhaskar Balakrishna <vijay.balakrishna@oracle.com>
Cc: virtio-dev <virtio-dev@lists.oasis-open.org>, Jason Wang <jasowang@redhat.com>, Yan Vugenfirer <yan@daynix.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--089e08210a3c44308d056a09647e
Content-Type: text/plain; charset="UTF-8"

On Tue, Apr 17, 2018 at 4:30 AM, Vijayabhaskar Balakrishna <
vijay.balakrishna@oracle.com> wrote:

> On 4/16/2018 6:05 AM, Sameeh Jubran wrote:
>
> From: Sameeh Jubran <sameeh.j@gmail.com>
>>
>> This commit introduces steering mode into network device. Steering
>> mode is a general infrastructure for various steering modes that can
>> be implemented on top of it such as Automatic and RSS.
>>
>> Signed-off-by: Sameeh Jubran <sjubran@redhat.com>
>> ---
>>   content.tex | 59 ++++++++++++++++++++++++++++++
>> +++++++++++++++++++++++++++++
>>   1 file changed, 59 insertions(+)
>>
>> diff --git a/content.tex b/content.tex
>> index c840588..3d538e8 100644
>> --- a/content.tex
>> +++ b/content.tex
>> @@ -3115,6 +3115,9 @@ features.
>>     \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through control
>>       channel.
>> +
>> +\item[VIRTIO_NET_F_CTRL_STEERING_MODE(27)] Device supports configurable
>> steering
>> +    mode.
>>   \end{description}
>>     \subsubsection{Feature bit requirements}\label{sec:Device Types /
>> Network Device / Feature bits / Feature bit requirements}
>> @@ -3317,6 +3320,8 @@ struct virtio_net_hdr {
>>           le16 csum_start;
>>           le16 csum_offset;
>>           le16 num_buffers;
>> +// Only if VIRTIO_NET_F_CTRL_STEERING_MODE has been negotiated
>> +        le64 hash;
>>   };
>>   \end{lstlisting}
>>   @@ -4007,6 +4012,60 @@ VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET command.
>>   The device MUST NOT queue packets on receive queues greater than
>>   \field{virtqueue_pairs} once it has placed the
>> VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET command in the used ring.
>>   +\paragraph{Steering mode}\label{sec:Device Types / Network Device /
>> Device Operation / Control Virtqueue / Steering mode}
>> +
>> +\begin{lstlisting}
>> +// steering mode flags
>> +#define STEERING_MODE_AUTO          1
>>
> As steering mode flags is a bit field, should it be 0x1?

They are indeed bit fields, will dd 0x in order to clarify that.

>
> +
>> +struct virtio_net_steering_modes {
>> +le32 steering_modes;
>> +};
>> +
>> +struct virtio_net_steering_mode {
>> +le32 steering_mode;
>> +le32 command;
>> +
>> +    union {
>> +    }
>> +};
>> +
>> +#define VIRTIO_NET_F_CTRL_STEERING_MODE     27
>> +
>> +#define VIRTIO_NET_CTRL_STEERING_MODE                7
>> +#define VIRTIO_NET_CTRL_SM_GET_SUPPORTED_MODES        0
>> +#define VIRTIO_NET_CTRL_SM_CONTROL                    1
>> +\end{lstlisting}
>> +
>> +If the VIRTIO_NET_F_CTRL_STEERING_MODE is negotiated the driver can
>> send control commands for the
>> +configuring the steering mode. There are multiple steering modes and
>> they can be configured using
>> +the VIRTIO_NET_CTRL_SM_CONTROL command. Each mode has it's own set of
>> commands.
>> +
>> +The auto steering mode is the default mode if nothing else has been
>> configured by the driver
>> +and the VIRTIO_NET_F_CTRL_STEERING_MODE feature is acked by the driver.
>> +
>> +The class VIRTIO_NET_CTRL_STEERING_MODE has two commands:
>> +
>> +\begin{enumerate}
>> +
>> +\item VIRTIO_NET_CTRL_SM_GET_SUPPORTED_MODES is used for getting the
>> supported steering modes by the device.
>> +       The command should be executed by the driver before attempting to
>> configure the steering mode. Once the device
>> +       receives this command it should fill the
>> virtio_net_steering_modes structure with the supported steering mode
>> +       flags.
>> +
>> +\item The command VIRTIO_NET_CTRL_SM_CONTROL is used for controlling the
>> different steering modes. Each steering mode
>> +       has its own set of commands. When executing this command the
>> structure virtio_net_steering_mode should be used as follows:
>> +       the \field{steering_mode} should be filled with one of the
>> steering mode flags along with an appropriate command from the chosen
>> +       steering mode. The union of virtio_net_steering_mode should be
>> used and filled as the mode's command suggests.
>> +\end{enumerate}
>> +
>> +If this feature has been negotiated, the virtio header has an additional
>> +\field{hash} field attached to it.
>>
> may be say: ..virtio net header has additional field{hash}


> +
>> +\subparagraph{Automatic Receive Steering}{Device Types / Network Device
>> / Device Operation / Control Virtqueue / Steering mode / Automatic Receive
>> Steering}
>> +
>> +This is the default steering mode, please refer to the "Automatic
>> receive steering in multiqueue" section.
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

--089e08210a3c44308d056a09647e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Tue, Apr 17, 2018 at 4:30 AM, Vijayabhaskar Balakrishna <span dir=3D=
"ltr">&lt;<a href=3D"mailto:vijay.balakrishna@oracle.com" target=3D"_blank"=
>vijay.balakrishna@oracle.com</a>&gt;</span> wrote:<br><blockquote class=3D=
"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding=
-left:1ex"><div class=3D"HOEnZb"><div class=3D"h5">On 4/16/2018 6:05 AM, Sa=
meeh Jubran wrote:<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
From: Sameeh Jubran &lt;<a href=3D"mailto:sameeh.j@gmail.com" target=3D"_bl=
ank">sameeh.j@gmail.com</a>&gt;<br>
<br>
This commit introduces steering mode into network device. Steering<br>
mode is a general infrastructure for various steering modes that can<br>
be implemented on top of it such as Automatic and RSS.<br>
<br>
Signed-off-by: Sameeh Jubran &lt;<a href=3D"mailto:sjubran@redhat.com" targ=
et=3D"_blank">sjubran@redhat.com</a>&gt;<br>
---<br>
=C2=A0 content.tex | 59 ++++++++++++++++++++++++++++++<wbr>++++++++++++++++=
+++++++++++++<br>
=C2=A0 1 file changed, 59 insertions(+)<br>
<br>
diff --git a/content.tex b/content.tex<br>
index c840588..3d538e8 100644<br>
--- a/content.tex<br>
+++ b/content.tex<br>
@@ -3115,6 +3115,9 @@ features.<br>
=C2=A0 =C2=A0 \item[VIRTIO_NET_F_CTRL_MAC_AD<wbr>DR(23)] Set MAC address th=
rough control<br>
=C2=A0 =C2=A0 =C2=A0 channel.<br>
+<br>
+\item[VIRTIO_NET_F_CTRL_STEER<wbr>ING_MODE(27)] Device supports configurab=
le steering<br>
+=C2=A0 =C2=A0 mode.<br>
=C2=A0 \end{description}<br>
=C2=A0 =C2=A0 \subsubsection{Feature bit requirements}\label{sec:Device Typ=
es / Network Device / Feature bits / Feature bit requirements}<br>
@@ -3317,6 +3320,8 @@ struct virtio_net_hdr {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 le16 csum_start;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 le16 csum_offset;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 le16 num_buffers;<br>
+// Only if VIRTIO_NET_F_CTRL_STEERING_MOD<wbr>E has been negotiated<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 le64 hash;<br>
=C2=A0 };<br>
=C2=A0 \end{lstlisting}<br>
=C2=A0 @@ -4007,6 +4012,60 @@ VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SE<wbr>T command.=
<br>
=C2=A0 The device MUST NOT queue packets on receive queues greater than<br>
=C2=A0 \field{virtqueue_pairs} once it has placed the VIRTIO_NET_CTRL_MQ_VQ=
_PAIRS_SE<wbr>T command in the used ring.<br>
=C2=A0 +\paragraph{Steering mode}\label{sec:Device Types / Network Device /=
 Device Operation / Control Virtqueue / Steering mode}<br>
+<br>
+\begin{lstlisting}<br>
+// steering mode flags<br>
+#define STEERING_MODE_AUTO=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1<br>
</blockquote></div></div>
As steering mode flags is a bit field, should it be 0x1?</blockquote><div>T=
hey are indeed bit fields, will dd 0x in order to clarify that.=C2=A0</div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div><div class=3D"h5"><br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
+<br>
+struct virtio_net_steering_modes {<br>
+le32 steering_modes;<br>
+};<br>
+<br>
+struct virtio_net_steering_mode {<br>
+le32 steering_mode;<br>
+le32 command;<br>
+<br>
+=C2=A0 =C2=A0 union {<br>
+=C2=A0 =C2=A0 }<br>
+};<br>
+<br>
+#define VIRTIO_NET_F_CTRL_STEERING_MOD<wbr>E=C2=A0 =C2=A0 =C2=A027<br>
+<br>
+#define VIRTIO_NET_CTRL_STEERING_MODE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 7<br>
+#define VIRTIO_NET_CTRL_SM_GET_SUPPORT<wbr>ED_MODES=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 0<br>
+#define VIRTIO_NET_CTRL_SM_CONTROL=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1<br>
+\end{lstlisting}<br>
+<br>
+If the VIRTIO_NET_F_CTRL_STEERING_MOD<wbr>E is negotiated the driver can s=
end control commands for the<br>
+configuring the steering mode. There are multiple steering modes and they =
can be configured using<br>
+the VIRTIO_NET_CTRL_SM_CONTROL command. Each mode has it&#39;s own set of =
commands.<br>
+<br>
+The auto steering mode is the default mode if nothing else has been config=
ured by the driver<br>
+and the VIRTIO_NET_F_CTRL_STEERING_MOD<wbr>E feature is acked by the drive=
r.<br>
+<br>
+The class VIRTIO_NET_CTRL_STEERING_MODE has two commands:<br>
+<br>
+\begin{enumerate}<br>
+<br>
+\item VIRTIO_NET_CTRL_SM_GET_SUPPORT<wbr>ED_MODES is used for getting the =
supported steering modes by the device.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0The command should be executed by the driver be=
fore attempting to configure the steering mode. Once the device<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0receives this command it should fill the virtio=
_net_steering_modes structure with the supported steering mode<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0flags.<br>
+<br>
+\item The command VIRTIO_NET_CTRL_SM_CONTROL is used for controlling the d=
ifferent steering modes. Each steering mode<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0has its own set of commands. When executing thi=
s command the structure virtio_net_steering_mode should be used as follows:=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0the \field{steering_mode} should be filled with=
 one of the steering mode flags along with an appropriate command from the =
chosen<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0steering mode. The union of virtio_net_steering=
_mode should be used and filled as the mode&#39;s command suggests.<br>
+\end{enumerate}<br>
+<br>
+If this feature has been negotiated, the virtio header has an additional<b=
r>
+\field{hash} field attached to it.<br>
</blockquote></div></div>
may be say: ..virtio net header has additional field{hash}=C2=A0</blockquot=
e><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><div class=3D"h5"><b=
r>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
+<br>
+\subparagraph{Automatic Receive Steering}{Device Types / Network Device / =
Device Operation / Control Virtqueue / Steering mode / Automatic Receive St=
eering}<br>
+<br>
+This is the default steering mode, please refer to the &quot;Automatic rec=
eive steering in multiqueue&quot; section.<br>
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

--089e08210a3c44308d056a09647e--
