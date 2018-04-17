Return-Path: virtio-dev-return-3848-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id C6DB95818F86
	for <virtio-dev@lists.oasis-open.org>; Tue, 17 Apr 2018 03:59:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAKPgXcGKPdQ=CEb7mSU+pk4Sx8q49nD+bePr2RKB6AHQXPBbgA@mail.gmail.com>
References: <20180416130526.6233-1-sameeh@daynix.com> <20180416130526.6233-2-sameeh@daynix.com>
 <20180416234515-mutt-send-email-mst@kernel.org> <CAKPgXcGKPdQ=CEb7mSU+pk4Sx8q49nD+bePr2RKB6AHQXPBbgA@mail.gmail.com>
From: Sameeh Jubran <sameeh@daynix.com>
Date: Tue, 17 Apr 2018 13:59:18 +0300
Message-ID: <CAKPgXcGfFGFPTE1Z69ScfQTToPz0pNH8ekfyTT+Vy710ueZ2Dg@mail.gmail.com>
Content-Type: multipart/alternative; boundary="94eb2c0e4b5eeb0812056a093a48"
Subject: Re: [virtio-dev] [PATCH v2 1/2] content: net: Add VIRTIO_NET_F_CTRL_STEERING_MODE
 feature
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev <virtio-dev@lists.oasis-open.org>, Jason Wang <jasowang@redhat.com>, Vijayabhaskar Balakrishna <vijay.balakrishna@oracle.com>, Yan Vugenfirer <yan@daynix.com>, Vlad Yasevich <vyasevic@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--94eb2c0e4b5eeb0812056a093a48
Content-Type: text/plain; charset="UTF-8"

On Tue, Apr 17, 2018 at 1:43 PM, Sameeh Jubran <sameeh@daynix.com> wrote:

>
>
> On Tue, Apr 17, 2018 at 2:05 AM, Michael S. Tsirkin <mst@redhat.com>
> wrote:
>
>> On Mon, Apr 16, 2018 at 04:05:25PM +0300, Sameeh Jubran wrote:
>> > From: Sameeh Jubran <sameeh.j@gmail.com>
>> >
>> > This commit introduces steering mode into network device. Steering
>> > mode is a general infrastructure for various steering modes that can
>> > be implemented on top of it such as Automatic and RSS.
>> >
>> > Signed-off-by: Sameeh Jubran <sjubran@redhat.com>
>> > ---
>> >  content.tex | 59 ++++++++++++++++++++++++++++++
>> +++++++++++++++++++++++++++++
>> >  1 file changed, 59 insertions(+)
>> >
>> > diff --git a/content.tex b/content.tex
>> > index c840588..3d538e8 100644
>> > --- a/content.tex
>> > +++ b/content.tex
>> > @@ -3115,6 +3115,9 @@ features.
>> >
>> >  \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through control
>> >      channel.
>> > +
>> > +\item[VIRTIO_NET_F_CTRL_STEERING_MODE(27)] Device supports
>> configurable steering
>> > +    mode.
>> >  \end{description}
>> >
>> >  \subsubsection{Feature bit requirements}\label{sec:Device Types /
>> Network Device / Feature bits / Feature bit requirements}
>> > @@ -3317,6 +3320,8 @@ struct virtio_net_hdr {
>> >          le16 csum_start;
>> >          le16 csum_offset;
>> >          le16 num_buffers;
>> > +// Only if VIRTIO_NET_F_CTRL_STEERING_MODE has been negotiated
>> > +        le64 hash;
>> >  };
>> >  \end{lstlisting}
>> >
>> > @@ -4007,6 +4012,60 @@ VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET command.
>> >  The device MUST NOT queue packets on receive queues greater than
>> >  \field{virtqueue_pairs} once it has placed the
>> VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET command in the used ring.
>> >
>> > +\paragraph{Steering mode}\label{sec:Device Types / Network Device /
>> Device Operation / Control Virtqueue / Steering mode}
>> > +
>> > +\begin{lstlisting}
>> > +// steering mode flags
>> > +#define STEERING_MODE_AUTO          1
>> > +
>> > +struct virtio_net_steering_modes {
>> > +le32 steering_modes;
>> > +};
>> > +
>> > +struct virtio_net_steering_mode {
>> > +le32 steering_mode;
>> > +le32 command;
>> > +
>> > +    union {
>> > +    }
>> > +};
>> > +
>> > +#define VIRTIO_NET_F_CTRL_STEERING_MODE     27
>>
>> Please use a high number (63 and down). We are running out of
>> low numbers it is best to keep them for things we must backport
>> to old virtio - such as mtu - which are required for the device
>> working properly.
>>
> Will do.
>
>>
>> Pls coordinate with Vlad (cc'd) who is adding a new feature too.
>>
>> > +
>> > +#define VIRTIO_NET_CTRL_STEERING_MODE                7
>> > +#define VIRTIO_NET_CTRL_SM_GET_SUPPORTED_MODES        0
>> > +#define VIRTIO_NET_CTRL_SM_CONTROL                    1
>> > +\end{lstlisting}
>> > +
>> > +If the VIRTIO_NET_F_CTRL_STEERING_MODE is negotiated the driver can
>> send control commands for the
>> > +configuring the steering mode. There are multiple steering modes and
>> they can be configured using
>> > +the VIRTIO_NET_CTRL_SM_CONTROL command. Each mode has it's own set of
>> commands.
>> > +
>> > +The auto steering mode is the default mode if nothing else has been
>> configured by the driver
>> > +and the VIRTIO_NET_F_CTRL_STEERING_MODE feature is acked by the
>> driver.
>> > +
>> > +The class VIRTIO_NET_CTRL_STEERING_MODE has two commands:
>> > +
>> > +\begin{enumerate}
>> > +
>> > +\item VIRTIO_NET_CTRL_SM_GET_SUPPORTED_MODES is used for getting the
>> supported steering modes by the device.
>> > +     The command should be executed by the driver before attempting to
>> configure the steering mode. Once the device
>> > +     receives this command it should fill the
>> virtio_net_steering_modes structure with the supported steering mode
>> > +     flags.
>> > +
>> > +\item The command VIRTIO_NET_CTRL_SM_CONTROL is used for controlling
>> the different steering modes. Each steering mode
>> > +     has its own set of commands. When executing this command the
>> structure virtio_net_steering_mode should be used as follows:
>> > +     the \field{steering_mode} should be filled with one of the
>> steering mode flags along with an appropriate command from the chosen
>> > +     steering mode. The union of virtio_net_steering_mode should be
>> used and filled as the mode's command suggests.
>> > +\end{enumerate}
>> > +
>> > +If this feature has been negotiated, the virtio header
>> > has an additional
>> > +\field{hash} field attached to it.
>> > +
>> > +\subparagraph{Automatic Receive Steering}{Device Types / Network
>> Device / Device Operation / Control Virtqueue / Steering mode / Automatic
>> Receive Steering}
>> > +
>> > +This is the default steering mode, please refer to the "Automatic
>> receive steering in multiqueue" section.
>> > +
>> >  \subparagraph{Legacy Interface: Automatic receive steering in
>> multiqueue mode}\label{sec:Device Types / Network Device / Device Operation
>> / Control Virtqueue / Automatic receive steering in multiqueue mode /
>> Legacy Interface: Automatic receive steering in multiqueue mode}
>> >  When using the legacy interface, transitional devices and drivers
>> >  MUST format \field{virtqueue_pairs}
>>
>> Please add each part where it belongs, e.g. a feature bit with other
>> feature bits, header field with other header fields, etc.
>>
> What are you referring to specifically? Can you please elaborate?
>
>>
>> I think Vlad tested extending the header and found it adds
>> non-negligeable performance overhead. Is it worth splitting
>> out hash calculation? Is hash used for RX path only?
>>
> Hash is used for RX only and I can't think this is not avoidable. We need
> to inform the driver what is the hash value for the packet,
>
Just to clarify, Windows does provide us with hash for the packets so we
can forward them to the device using the hash field in the virtio header.
This value can be used to perform optimizations by the backend.

> it's a Windows requirement. What do you mean by splitting out the hash
> calculation?
> We are already extending the virtio-header for RSC feature which didn't
> make it into spec somehow.
>
>>
>>
>> > --
>> > 2.13.6
>> >
>> >
>> > ---------------------------------------------------------------------
>> > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
>> > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>>
>
>
>
> --
> Respectfully,
> *Sameeh Jubran*
> *Linkedin <https://il.linkedin.com/pub/sameeh-jubran/87/747/a8a>*
> *Software Engineer @ Daynix <http://www.daynix.com>.*
>



-- 
Respectfully,
*Sameeh Jubran*
*Linkedin <https://il.linkedin.com/pub/sameeh-jubran/87/747/a8a>*
*Software Engineer @ Daynix <http://www.daynix.com>.*

--94eb2c0e4b5eeb0812056a093a48
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Tue, Apr 17, 2018 at 1:43 PM, Sameeh Jubran <span dir=3D"ltr">&lt;<a=
 href=3D"mailto:sameeh@daynix.com" target=3D"_blank">sameeh@daynix.com</a>&=
gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><br><d=
iv class=3D"gmail_extra"><br><div class=3D"gmail_quote"><div><div class=3D"=
h5">On Tue, Apr 17, 2018 at 2:05 AM, Michael S. Tsirkin <span dir=3D"ltr">&=
lt;<a href=3D"mailto:mst@redhat.com" target=3D"_blank">mst@redhat.com</a>&g=
t;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div class=3D"m_-7055460=
464416475884m_-7882308810791399853HOEnZb"><div class=3D"m_-7055460464416475=
884m_-7882308810791399853h5">On Mon, Apr 16, 2018 at 04:05:25PM +0300, Same=
eh Jubran wrote:<br>
&gt; From: Sameeh Jubran &lt;<a href=3D"mailto:sameeh.j@gmail.com" target=
=3D"_blank">sameeh.j@gmail.com</a>&gt;<br>
&gt; <br>
&gt; This commit introduces steering mode into network device. Steering<br>
&gt; mode is a general infrastructure for various steering modes that can<b=
r>
&gt; be implemented on top of it such as Automatic and RSS.<br>
&gt; <br>
&gt; Signed-off-by: Sameeh Jubran &lt;<a href=3D"mailto:sjubran@redhat.com"=
 target=3D"_blank">sjubran@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 content.tex | 59 ++++++++++++++++++++++++++++++<wbr>++++++++++++=
+++++++++++++++++<br>
&gt;=C2=A0 1 file changed, 59 insertions(+)<br>
&gt; <br>
&gt; diff --git a/content.tex b/content.tex<br>
&gt; index c840588..3d538e8 100644<br>
&gt; --- a/content.tex<br>
&gt; +++ b/content.tex<br>
&gt; @@ -3115,6 +3115,9 @@ features.<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 \item[VIRTIO_NET_F_CTRL_MAC_AD<wbr>DR(23)] Set MAC address throu=
gh control<br>
&gt;=C2=A0 =C2=A0 =C2=A0 channel.<br>
&gt; +<br>
&gt; +\item[VIRTIO_NET_F_CTRL_STEER<wbr>ING_MODE(27)] Device supports confi=
gurable steering<br>
&gt; +=C2=A0 =C2=A0 mode.<br>
&gt;=C2=A0 \end{description}<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 \subsubsection{Feature bit requirements}\label{sec:Device Types =
/ Network Device / Feature bits / Feature bit requirements}<br>
&gt; @@ -3317,6 +3320,8 @@ struct virtio_net_hdr {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 le16 csum_start;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 le16 csum_offset;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 le16 num_buffers;<br>
&gt; +// Only if VIRTIO_NET_F_CTRL_STEERING_MOD<wbr>E has been negotiated<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 le64 hash;<br>
&gt;=C2=A0 };<br>
&gt;=C2=A0 \end{lstlisting}<br>
&gt;=C2=A0 <br>
&gt; @@ -4007,6 +4012,60 @@ VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SE<wbr>T command.<b=
r>
&gt;=C2=A0 The device MUST NOT queue packets on receive queues greater than=
<br>
&gt;=C2=A0 \field{virtqueue_pairs} once it has placed the VIRTIO_NET_CTRL_M=
Q_VQ_PAIRS_SE<wbr>T command in the used ring.<br>
&gt;=C2=A0 <br>
&gt; +\paragraph{Steering mode}\label{sec:Device Types / Network Device / D=
evice Operation / Control Virtqueue / Steering mode}<br>
&gt; +<br>
&gt; +\begin{lstlisting}<br>
&gt; +// steering mode flags<br>
&gt; +#define STEERING_MODE_AUTO=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1<br>
&gt; +<br>
&gt; +struct virtio_net_steering_modes {<br>
&gt; +le32 steering_modes;<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct virtio_net_steering_mode {<br>
&gt; +le32 steering_mode;<br>
&gt; +le32 command;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 union {<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +};<br>
&gt; +<br>
&gt; +#define VIRTIO_NET_F_CTRL_STEERING_MOD<wbr>E=C2=A0 =C2=A0 =C2=A027<br=
>
<br>
</div></div>Please use a high number (63 and down). We are running out of<b=
r>
low numbers it is best to keep them for things we must backport<br>
to old virtio - such as mtu - which are required for the device<br>
working properly.<br></blockquote></div></div><div>Will do.=C2=A0</div><div=
><div class=3D"h5"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
Pls coordinate with Vlad (cc&#39;d) who is adding a new feature too.<br>
<div><div class=3D"m_-7055460464416475884m_-7882308810791399853h5"><br>
&gt; +<br>
&gt; +#define VIRTIO_NET_CTRL_STEERING_MODE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 7<br>
&gt; +#define VIRTIO_NET_CTRL_SM_GET_SUPPORT<wbr>ED_MODES=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 0<br>
&gt; +#define VIRTIO_NET_CTRL_SM_CONTROL=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1<br>
&gt; +\end{lstlisting}<br>
&gt; +<br>
&gt; +If the VIRTIO_NET_F_CTRL_STEERING_MOD<wbr>E is negotiated the driver =
can send control commands for the<br>
&gt; +configuring the steering mode. There are multiple steering modes and =
they can be configured using<br>
&gt; +the VIRTIO_NET_CTRL_SM_CONTROL command. Each mode has it&#39;s own se=
t of commands.<br>
&gt; +<br>
&gt; +The auto steering mode is the default mode if nothing else has been c=
onfigured by the driver<br>
&gt; +and the VIRTIO_NET_F_CTRL_STEERING_MOD<wbr>E feature is acked by the =
driver.<br>
&gt; +<br>
&gt; +The class VIRTIO_NET_CTRL_STEERING_MODE has two commands:<br>
&gt; +<br>
&gt; +\begin{enumerate}<br>
&gt; +<br>
&gt; +\item VIRTIO_NET_CTRL_SM_GET_SUPPORT<wbr>ED_MODES is used for getting=
 the supported steering modes by the device.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0The command should be executed by the driver befo=
re attempting to configure the steering mode. Once the device<br>
&gt; +=C2=A0 =C2=A0 =C2=A0receives this command it should fill the virtio_n=
et_steering_modes structure with the supported steering mode<br>
&gt; +=C2=A0 =C2=A0 =C2=A0flags.<br>
&gt; +<br>
&gt; +\item The command VIRTIO_NET_CTRL_SM_CONTROL is used for controlling =
the different steering modes. Each steering mode<br>
&gt; +=C2=A0 =C2=A0 =C2=A0has its own set of commands. When executing this =
command the structure virtio_net_steering_mode should be used as follows:<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0the \field{steering_mode} should be filled with o=
ne of the steering mode flags along with an appropriate command from the ch=
osen<br>
&gt; +=C2=A0 =C2=A0 =C2=A0steering mode. The union of virtio_net_steering_m=
ode should be used and filled as the mode&#39;s command suggests.<br>
&gt; +\end{enumerate}<br>
&gt; +<br>
&gt; +If this feature has been negotiated, the virtio header<br>
&gt; has an additional<br>
&gt; +\field{hash} field attached to it.<br>
&gt; +<br>
&gt; +\subparagraph{Automatic Receive Steering}{Device Types / Network Devi=
ce / Device Operation / Control Virtqueue / Steering mode / Automatic Recei=
ve Steering}<br>
&gt; +<br>
&gt; +This is the default steering mode, please refer to the &quot;Automati=
c receive steering in multiqueue&quot; section.<br>
&gt; +<br>
&gt;=C2=A0 \subparagraph{Legacy Interface: Automatic receive steering in mu=
ltiqueue mode}\label{sec:Device Types / Network Device / Device Operation /=
 Control Virtqueue / Automatic receive steering in multiqueue mode / Legacy=
 Interface: Automatic receive steering in multiqueue mode}<br>
&gt;=C2=A0 When using the legacy interface, transitional devices and driver=
s<br>
&gt;=C2=A0 MUST format \field{virtqueue_pairs}<br>
<br>
</div></div>Please add each part where it belongs, e.g. a feature bit with =
other<br>
feature bits, header field with other header fields, etc.<br></blockquote><=
/div></div><div>What are you referring to specifically? Can you please elab=
orate?=C2=A0</div><span class=3D""><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
I think Vlad tested extending the header and found it adds<br>
non-negligeable performance overhead. Is it worth splitting<br>
out hash calculation? Is hash used for RX path only?<br></blockquote></span=
><div>Hash is used for RX only and I can&#39;t think this is not avoidable.=
 We need to inform the driver what is the hash value for the packet,</div><=
/div></div></div></blockquote><div>Just to clarify, Windows does provide us=
 with hash for the packets so we can forward them to the device using the h=
ash field in the virtio header.</div><div>This value can be used to perform=
 optimizations by the backend.</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=
=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote"><div>it&#39;=
s a Windows requirement. What do you mean by splitting out the hash calcula=
tion?</div><div>We are already extending the virtio-header for RSC feature =
which didn&#39;t make it into spec somehow.=C2=A0</div><span class=3D""><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #=
ccc solid;padding-left:1ex">
<span class=3D"m_-7055460464416475884m_-7882308810791399853HOEnZb"><font co=
lor=3D"#888888"><br>
<br>
&gt; -- <br>
&gt; 2.13.6<br>
&gt; <br>
&gt; <br>
&gt; ------------------------------<wbr>------------------------------<wbr>=
---------<br>
&gt; To unsubscribe, e-mail: <a href=3D"mailto:virtio-dev-unsubscribe@lists=
.oasis-open.org" target=3D"_blank">virtio-dev-unsubscribe@lists.o<wbr>asis-=
open.org</a><br>
&gt; For additional commands, e-mail: <a href=3D"mailto:virtio-dev-help@lis=
ts.oasis-open.org" target=3D"_blank">virtio-dev-help@lists.oasis-op<wbr>en.=
org</a><br>
</font></span></blockquote></span></div><span class=3D"HOEnZb"><font color=
=3D"#888888"><br><br clear=3D"all"><div><br></div>-- <br><div class=3D"m_-7=
055460464416475884m_-7882308810791399853gmail_signature" data-smartmail=3D"=
gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"lt=
r"><div><div dir=3D"ltr"><font size=3D"4" color=3D"#0b5394" face=3D"times n=
ew roman, serif">Respectfully,<br></font><div style=3D"font-size:12.8px;col=
or:rgb(136,136,136)"><font size=3D"4" color=3D"#0b5394" face=3D"times new r=
oman, serif"><b><i>Sameeh Jubran</i></b></font></div><div style=3D"font-siz=
e:12.8px;color:rgb(136,136,136)"><i style=3D"color:rgb(7,55,99);font-family=
:&quot;times new roman&quot;,serif;font-size:large"><span style=3D"line-hei=
ght:15px"><a href=3D"https://il.linkedin.com/pub/sameeh-jubran/87/747/a8a" =
title=3D"View public profile" name=3D"m_-7055460464416475884_m_-78823088107=
91399853_UNIQUE_ID_SafeHtmlFilter_UNIQUE_ID_SafeHtmlFilter_UNIQUE_ID_SafeHt=
mlFilter_UNIQUE_ID_SafeHtmlFilter_UNIQUE_ID_SafeHtmlFilter_14e2c1de96f8c195=
_UNIQUE_ID_SafeHtmlFilter_SafeHtmlFilter_SafeHtmlFilter_webProfileURL" styl=
e=3D"color:rgb(17,85,204);margin:0px;padding:0px;border-width:0px;outline:n=
one;vertical-align:baseline;text-decoration:none" target=3D"_blank">Linkedi=
n</a></span></i><br></div><div style=3D"font-size:12.8px;color:rgb(136,136,=
136)"><font size=3D"4" face=3D"times new roman, serif" color=3D"#073763"><i=
>Software Engineer @ <a href=3D"http://www.daynix.com" target=3D"_blank">Da=
ynix</a>.</i></font></div></div></div></div></div></div></div></div></div>
</font></span></div></div>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div class=
=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><d=
iv><div dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr"><font size=
=3D"4" color=3D"#0b5394" face=3D"times new roman, serif">Respectfully,<br><=
/font><div style=3D"font-size:12.8px;color:rgb(136,136,136)"><font size=3D"=
4" color=3D"#0b5394" face=3D"times new roman, serif"><b><i>Sameeh Jubran</i=
></b></font></div><div style=3D"font-size:12.8px;color:rgb(136,136,136)"><i=
 style=3D"color:rgb(7,55,99);font-family:&quot;times new roman&quot;,serif;=
font-size:large"><span style=3D"line-height:15px"><a href=3D"https://il.lin=
kedin.com/pub/sameeh-jubran/87/747/a8a" title=3D"View public profile" name=
=3D"UNIQUE_ID_SafeHtmlFilter_UNIQUE_ID_SafeHtmlFilter_UNIQUE_ID_SafeHtmlFil=
ter_UNIQUE_ID_SafeHtmlFilter_UNIQUE_ID_SafeHtmlFilter_14e2c1de96f8c195_UNIQ=
UE_ID_SafeHtmlFilter_SafeHtmlFilter_SafeHtmlFilter_webProfileURL" style=3D"=
color:rgb(17,85,204);margin:0px;padding:0px;border-width:0px;outline:none;v=
ertical-align:baseline;text-decoration:none" target=3D"_blank">Linkedin</a>=
</span></i><br></div><div style=3D"font-size:12.8px;color:rgb(136,136,136)"=
><font size=3D"4" face=3D"times new roman, serif" color=3D"#073763"><i>Soft=
ware Engineer @ <a href=3D"http://www.daynix.com" target=3D"_blank">Daynix<=
/a>.</i></font></div></div></div></div></div></div></div></div></div>
</div></div>

--94eb2c0e4b5eeb0812056a093a48--
