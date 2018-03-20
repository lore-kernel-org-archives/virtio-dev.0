Return-Path: virtio-dev-return-3621-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id ABB1358180EF
	for <virtio-dev@lists.oasis-open.org>; Tue, 20 Mar 2018 02:40:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <2f56babd-e9db-f5ba-0678-25864a41fb9e@redhat.com>
References: <20180125162709.370-1-sameeh@daynix.com> <20180125162709.370-2-sameeh@daynix.com>
 <767992ef-c23a-2098-6055-3b8d0cfec093@redhat.com> <CAKPgXcG4C0k+Kzjo0HzfDLskMcxRfLNvXe5wxVJY4cFMZnhn4Q@mail.gmail.com>
 <2f56babd-e9db-f5ba-0678-25864a41fb9e@redhat.com>
From: Sameeh Jubran <sameeh@daynix.com>
Date: Tue, 20 Mar 2018 11:39:51 +0200
Message-ID: <CAKPgXcHkLc40-0oYWF6iiWOjw2S8M+ZTsXZQ8mqos_r3o6sL8g@mail.gmail.com>
Content-Type: multipart/alternative; boundary="00000000000037ce190567d4dbeb"
Subject: Re: [virtio-dev] [RFC virtio-net 1/1] content: net: Add
 VIRTIO_NET_F_CTRL_RSS feature
To: Jason Wang <jasowang@redhat.com>
Cc: virtio-dev <virtio-dev@lists.oasis-open.org>, Amnon Ilan <ailan@redhat.com>, Yan Vugenfirer <yan@daynix.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--00000000000037ce190567d4dbeb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 20, 2018 at 5:10 AM, Jason Wang <jasowang@redhat.com> wrote:

>
>
> On 2018=E5=B9=B403=E6=9C=8819=E6=97=A5 21:33, Sameeh Jubran wrote:
>
>>
>>
>> On Thu, Mar 15, 2018 at 4:19 AM, Jason Wang <jasowang@redhat.com <mailto=
:
>> jasowang@redhat.com>> wrote:
>>
>>
>>
>>     On 2018=E5=B9=B401=E6=9C=8826=E6=97=A5 00:27, Sameeh Jubran wrote:
>>
>>         From: Sameeh Jubran <sameeh.j@gmail.com
>>         <mailto:sameeh.j@gmail.com>>
>>
>>         Most modern high end network devices today support
>>         configurable hash functions,
>>         this commit introduces RSS - Receive Side Scaling - [1] to
>>         virtio net device.
>>
>>         The RSS is a technology from Microsoft that boosts network
>>         device performance
>>         by efficiently distributing the traffic among the CPUs in a
>>         multiprocessor
>>         system.
>>
>>         This feature is supported in most of the modern network cards
>>         as well as most
>>         modern OSes including Linux and Windows. It is worth
>>         mentioning that both DPDK
>>         and Hyper-v support RSS too.
>>
>>         [1]
>>         https://docs.microsoft.com/en-us/windows-hardware/drivers/ne
>> twork/ndis-receive-side-scaling2
>>         <https://docs.microsoft.com/en-us/windows-hardware/drivers/
>> network/ndis-receive-side-scaling2>
>>
>>         Signed-off-by: Sameeh Jubran <sjubran@redhat.com
>>         <mailto:sjubran@redhat.com>>
>>
>>         ---
>>           content.tex | 133
>>         ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>           1 file changed, 133 insertions(+)
>>
>>         diff --git a/content.tex b/content.tex
>>         index c840588..5969b28 100644
>>         --- a/content.tex
>>         +++ b/content.tex
>>         @@ -3115,6 +3115,9 @@ features.
>>             \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address
>>         through control
>>               channel.
>>         +
>>         +\item[VIRTIO_NET_F_CTRL_RSS(24)] Device supports configurable
>>         RSS hash
>>         +    functions.
>>           \end{description}
>>             \subsubsection{Feature bit requirements}\label{sec:Device
>>         Types / Network Device / Feature bits / Feature bit requirements=
}
>>         @@ -3138,6 +3141,8 @@ Some networking feature bits require
>>         other networking feature bits
>>           \item[VIRTIO_NET_F_GUEST_ANNOUNCE] Requires
>>         VIRTIO_NET_F_CTRL_VQ.
>>           \item[VIRTIO_NET_F_MQ] Requires VIRTIO_NET_F_CTRL_VQ.
>>           \item[VIRTIO_NET_F_CTRL_MAC_ADDR] Requires
>> VIRTIO_NET_F_CTRL_VQ.
>>         +
>>         +\item[VIRTIO_NET_F_CTRL_RSS] Requires VIRTIO_NET_F_MQ.
>>           \end{description}
>>
>>
>>     Is this a requirement of RSSv2? Looks like at least RSS can work
>>     without multiqueue in V1.
>>
>> You are right this is not a requirement and should be dropped. More on
>> RSS with single hardware queue:
>>  https://docs.microsoft.com/en-us/windows-hardware/drivers/
>> network/rss-with-a-single-hardware-receive-queue <
>> https://docs.microsoft.com/en-us/windows-hardware/drivers/
>> network/rss-with-a-single-hardware-receive-queue>
>>
>>
>>
>>             \subsubsection{Legacy Interface: Feature
>>         bits}\label{sec:Device Types / Network Device / Feature bits /
>>         Legacy Interface: Feature bits}
>>         @@ -3308,6 +3313,7 @@ struct virtio_net_hdr {
>>                   u8 flags;
>>           #define VIRTIO_NET_HDR_GSO_NONE        0
>>           #define VIRTIO_NET_HDR_GSO_TCPV4       1
>>         +#define VIRTIO_NET_HDR_GSO_RSS         2
>>
>>
>>     What's the reason of introducing a new GSO type here? RSS should
>>     be independent for a specific offloading type I think.
>>
>> This was the straight forward option as there is no need to extend the
>> virtio header but it can be moved to a specific offload.
>>
>
> If I understand correctly, RSS is not tied to GSO, so you mean
> VIRTIO_NET_HDR_RSS here?

Yup

>
>
>
>>
>>           #define VIRTIO_NET_HDR_GSO_UDP         3
>>           #define VIRTIO_NET_HDR_GSO_TCPV6       4
>>           #define VIRTIO_NET_HDR_GSO_ECN      0x80
>>         @@ -3317,6 +3323,8 @@ struct virtio_net_hdr {
>>                   le16 csum_start;
>>                   le16 csum_offset;
>>                   le16 num_buffers;
>>         +// Only if RSS hash offload has been negotiated
>>         +        le64 rss_hash_value;
>>
>>
>>     Not a native English speaker, but "rss_hash" should be sufficient.
>>
>> will do
>>
>>
>>
>>           };
>>           \end{lstlisting}
>>           @@ -4007,6 +4015,131 @@ VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET
>> command.
>>           The device MUST NOT queue packets on receive queues greater th=
an
>>           \field{virtqueue_pairs} once it has placed the
>>         VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET command in the used ring.
>>           +\paragraph{RSS hash offload}\label{sec:Device Types /
>>         Network Device / Device Operation / Control Virtqueue / RSS
>>         hash offload}
>>         +
>>         +\begin{lstlisting}
>>         +#define RSS_HASH_FUNCTION_NONE      1
>>         +#define RSS_HASH_FUNCTION_TOEPLITZ  2
>>         +#define RSS_HASH_FUNCTION_SYMMETRIC 3
>>         +
>>         +// Hash function fields
>>         +#define RSS_HASH_FIELDS_IPV4          0x00000100
>>         +#define RSS_HASH_FIELDS_TCP_IPV4      0x00000200
>>         +#define RSS_HASH_FIELDS_IPV6          0x00000400
>>         +#define RSS_HASH_FIELDS_IPV6_EX       0x00000800
>>         +#define RSS_HASH_FIELDS_TCP_IPV6      0x00001000
>>         +#define RSS_HASH_FIELDS_TCP_IPV6_EX   0x00002000
>>         +
>>         +struct virtio_net_ctrl_rss_hash{
>>         +le32 hash_function;
>>         +}
>>         +
>>         +struct virtio_net_rss {
>>         +le32 hash_function;
>>         +le32 hash_function_flags;
>>         +le32 hash_key_length;
>>         +le32 indirection_table_length;
>>         +       struct {
>>         +               le32 hash_key[hash_key_length];
>>         +               le32 indirection_table[indirection_table_length]=
;
>>         +       }
>>         +};
>>         +
>>         +#define VIRTIO_NET_F_CTRL_RSS     24
>>         +
>>         +#define VIRTIO_NET_CTRL_RSS    6
>>         +#define VIRTIO_NET_CTRL_RSS_GET_SUPPORTED_FUNCTIONS  0
>>         +#define VIRTIO_NET_CTRL_RSS_DISABLE    1
>>         +#define VIRTIO_NET_CTRL_RSS_SET    2
>>         +\end{lstlisting}
>>         +
>>         +If the VIRTIO_NET_F_CTRL_RSS is negotiated the driver can
>>         send control
>>         +commands for the RSS configuration.
>>         +
>>         +The class VIRTIO_NET_CTRL_RSS has three commands:
>>         +
>>         +\begin{enumerate}
>>         +\item VIRTIO_NET_CTRL_RSS_GET_SUPPLIED_FUNCTIONS returns the
>>         hash functions
>>         +       supported by the device to the driver.
>>
>>
>>     Can we just reuse virtio_net_rss in this case, it contains all the
>>     informations (e.g hash key or whatever others)?
>>
>> Sure this can work
>>
>>
>>
>>         +\item VIRTIO_NET_CTRL_RSS_DISABLE Instructs the device that
>>         RSS hashing is no
>>         +       longer required.
>>
>>
>>     So this implies that if MQ is supported, we will go to use
>>     automatic steering mode? I was thinking maybe it's better to
>>     introduce a generic command to switch between steering mode.
>>
>>  So you are suggesting that we should have an additional generic command
>> that changes between steering modes and RSS is one of those modes?
>>
>
> Yes.
>
>
>
>>
>>         +\item VIRTIO_NET_CTRL_RSS_SET applies the new RSS
>>         configuration. The command is
>>         +       used by the driver for setting RSS hash function, hash
>>         key and
>>         +       indirection table in the device.
>>         +\end{enumerate}
>>         +
>>         +If this feaure has been negotiated, the virtio header has an
>>         additional
>>         +field{rss_hash_value} field attached to it.
>>         +
>>         +\devicenormative{\subparagraph}{RSS hash offload}{Device
>>         Types / Network Device / Device Operation / Control Virtqueue
>>         / RSS hash offload}
>>         +
>>         +The device MUST fill the virtio_net_ctrl_rss_hash structure
>>         with the hash
>>         +functions it supports and return the structure to the driver.
>>         Zero or more
>>         +flags of the RSS_HASH_FUNCTION flags MUST be used to fill the
>>         \field{hash_function}
>>         +field.
>>         +
>>         +Upon recieving VIRTIO_NET_CTRL_DISABLE the device SHOULD stop
>>         calculating and
>>         +attaching hashes
>>
>>
>>     For simplicity, what if just compute the hash in this case?
>>     Consider a driver may want to use this hash (e.g Linux driver).
>>
>> I get the use case but maybe introduce a new command for computing hashe=
s
>> only?
>>
>
> Then it looks unnecessary. (Btw, the above should be
> "VIRTIO_NET_CTRL_RSS_DISABLE").

We can have it as a sub command of the RSS command where the command
calculates hashes only
or else make the device calculate hashes only when setting the hash
function and key but not setting the indirection table
(indirection_table_length =3D 0)
True, thanks.

>




>
> I think the disable should be preserved for disabling only.
>>
>>
>>
>>         for the packets as well as stop setting the VIRTIO_NET_HDR_GSO_R=
SS
>>         +in the \field{gso_type} field, however the
>>         \field{hash_function} field is kept
>>         +as a part of the header.
>>         +
>>         +The device MUST drop all previous RSS configuration upon
>>         receiving
>>         +VIRTIO_NET_CTRL_RSS_SET command.
>>         +
>>         +The device MUST set the RSS configuration according to the
>>         settings provided as
>>         +follows, once the configuration process is completed the
>>         device SHOULD apply
>>         +the hash function to each of the incoming packets and
>>         distribute the packets
>>         +through the virqueues using the calculated hash and the
>>         indirection table
>>         +that were earlier provided by the driver.
>>
>>
>>     We support changing #queues dynamically, so need to clarify the
>>     behavior when e.g the destination queues were disabled.
>>
>> I will go into these details in the next version.
>>
>>
>>
>>         +
>>         +Setting RSS configuration
>>         +\begin{enumerate}
>>         +\item The driver fills all of the fields and passes them
>>         through the control
>>         +       queue to the device.
>>         +
>>         +\item The device sets the RSS configuration as provided by
>>         the driver.
>>         +
>>         +\item If the device successfully applied the configuration,
>>         on each packet
>>         +       recieved the device MUST calculate the hashing for the
>>         packet and
>>         +       store it in the virtio-net header in rss_hash_value
>>         and the hash
>>         +       fields used in the calculation in rss_hash_type.
>>         +\end{enumerate}
>>         +
>>         +In case of any unexpected values/ unsupported hash function
>>         the driver
>>         +MUST return VIRTIO_NET_ERR in the \field{ack} field.
>>         +
>>         +\drivernormative{\subparagraph}{RSS hash offload}{Device
>>         Types / Network Device / Device Operation / Control Virtqueue
>>         / RSS hash offload}
>>         +
>>         +If the driver negotiates the feature VIRTIO_NET_F_CTRL_RSS
>>         the driver SHOULD
>>         +send VIRTIO_NET_CTRL_RSS_SET command to the device along with
>>         the RSS structure
>>         +filled. The RSS structure fields should be filled as follows:
>>         +
>>         +\begin{itemize}
>>         +\item The driver SHOULD choose the hash function that SHOULD
>>         be used and fill
>>         +       it in the \field{hash_function} field along with the
>>         approperiate flags
>>         +       in the \field{hash_function_flags} field. These flags
>>         inidicate to the
>>         +       device which packet fields MUST be used in the
>>         calculation process of
>>         +       the hash.
>>         +\item Once the hash function has been chosen a suitable hash
>>         key should be set
>>         +       in the \field{hash_key} field, the length of the key
>>         should be stored
>>         +       in the \field{hash_key_length} field.
>>         +\item Lastly the driver should fill the indirection table
>>         array in the
>>         +       \field{indirection_table} field while setting the
>>         array length in
>>         +       \field{indirection_table_length}. This structure is
>>         used by the device
>>         +       for determining in which RX virt queue the packet
>>         should be placed.
>>
>>
>>     Is the indirection table expected to be changed frequently? If
>>     yes, a single entry modification will cause a update of the whole
>>     table.
>>
>> No, it should not be changing frequently
>>
>>
>>
>>         +\end{itemize}
>>         +Once the configuration phase is over successfully, the
>>         packets SHOULD have the
>>         +\field{rss_hash_value} field with the hash value that was
>>         calculated by the
>>         +device.
>>         +
>>         +Whenever the driver wants to discard the current RSS
>>         settings, it can send an
>>         +VIRTIO_NET_CTRL_RSS_SET command along with rss structure that h=
as
>>         +RSS_HASH_FUNCTION_NONE the \field{hash_function} field.
>>
>>
>>     So this function looks equivalent to VIRTIO_NET_CTRL_RSS_DISABLE?
>>
>> Yes, do you think we should discard one of the two?
>>
>
> Yes.
>
> Thanks
>
>
>>     Thanks
>>
>>
>>         +
>>         +The driver MUST check the \field{ack} field value provided by
>>         the device, in
>>         +case the value is not VIRTIO_NET_OK then the driver MUST
>>         hanlde faliure and
>>         +retry another hash function or else give up.
>>         +
>>           \subparagraph{Legacy Interface: Automatic receive steering
>>         in multiqueue mode}\label{sec:Device Types / Network Device /
>>         Device Operation / Control Virtqueue / Automatic receive
>>         steering in multiqueue mode / Legacy Interface: Automatic
>>         receive steering in multiqueue mode}
>>           When using the legacy interface, transitional devices and
>>         drivers
>>           MUST format \field{virtqueue_pairs}
>>
>>
>>
>>
>>
>> --
>> Respectfully,
>> */Sameeh Jubran/*
>> /Linkedin <https://il.linkedin.com/pub/sameeh-jubran/87/747/a8a>/
>> /Software Engineer @ Daynix <http://www.daynix.com>./
>>
>
>


--=20
Respectfully,
*Sameeh Jubran*
*Linkedin <https://il.linkedin.com/pub/sameeh-jubran/87/747/a8a>*
*Software Engineer @ Daynix <http://www.daynix.com>.*

--00000000000037ce190567d4dbeb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Tue, Mar 20, 2018 at 5:10 AM, Jason Wang <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:jasowang@redhat.com" target=3D"_blank">jasowang@redhat.com</a>=
&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br=
>
<br>
On 2018=E5=B9=B403=E6=9C=8819=E6=97=A5 21:33, Sameeh Jubran wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex"><span class=3D"gmail-">
<br>
<br>
On Thu, Mar 15, 2018 at 4:19 AM, Jason Wang &lt;<a href=3D"mailto:jasowang@=
redhat.com" target=3D"_blank">jasowang@redhat.com</a> &lt;mailto:<a href=3D=
"mailto:jasowang@redhat.com" target=3D"_blank">jasowang@redhat.com</a>&gt;&=
gt; wrote:<br>
<br>
<br>
<br>
=C2=A0 =C2=A0 On 2018=E5=B9=B401=E6=9C=8826=E6=97=A5 00:27, Sameeh Jubran w=
rote:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 From: Sameeh Jubran &lt;<a href=3D"mailto:samee=
h.j@gmail.com" target=3D"_blank">sameeh.j@gmail.com</a><br></span>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;mailto:<a href=3D"mailto:sameeh.j@gmail.com=
" target=3D"_blank">sameeh.j@gmail.com</a>&gt;&gt;<span class=3D"gmail-"><b=
r>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Most modern high end network devices today supp=
ort<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 configurable hash functions,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 this commit introduces RSS - Receive Side Scali=
ng - [1] to<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio net device.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 The RSS is a technology from Microsoft that boo=
sts network<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 device performance<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 by efficiently distributing the traffic among t=
he CPUs in a<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 multiprocessor<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 system.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 This feature is supported in most of the modern=
 network cards<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 as well as most<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 modern OSes including Linux and Windows. It is =
worth<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 mentioning that both DPDK<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 and Hyper-v support RSS too.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 [1]<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://docs.microsoft.com/en-us/win=
dows-hardware/drivers/network/ndis-receive-side-scaling2" rel=3D"noreferrer=
" target=3D"_blank">https://docs.microsoft.com/en-<wbr>us/windows-hardware/=
drivers/ne<wbr>twork/ndis-receive-side-scalin<wbr>g2</a><br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"https://docs.microsoft.com/en-us=
/windows-hardware/drivers/network/ndis-receive-side-scaling2" rel=3D"norefe=
rrer" target=3D"_blank">https://docs.microsoft.com/en<wbr>-us/windows-hardw=
are/drivers/<wbr>network/ndis-receive-side-<wbr>scaling2</a>&gt;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Signed-off-by: Sameeh Jubran &lt;<a href=3D"mai=
lto:sjubran@redhat.com" target=3D"_blank">sjubran@redhat.com</a><br></span>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;mailto:<a href=3D"mailto:sjubran@redhat.com=
" target=3D"_blank">sjubran@redhat.com</a>&gt;&gt;<div><div class=3D"gmail-=
h5"><br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ---<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 content.tex | 133<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ++++++++++++++++++++++++++++++<wbr>++++++++++++=
++++++++++++++++++<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1 file changed, 133 insertions(+)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 diff --git a/content.tex b/content.tex<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 index c840588..5969b28 100644<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 --- a/content.tex<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +++ b/content.tex<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 @@ -3115,6 +3115,9 @@ features.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \item[VIRTIO_NET_F_CTRL_MAC_AD<wb=
r>DR(23)] Set MAC address<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 through control<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 channel.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +\item[VIRTIO_NET_F_CTRL_RSS(2<wbr>4)] Device s=
upports configurable<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 RSS hash<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +=C2=A0 =C2=A0 functions.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \end{description}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \subsubsection{Feature bit requir=
ements}\label{sec:Device<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Types / Network Device / Feature bits / Feature=
 bit requirements}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 @@ -3138,6 +3141,8 @@ Some networking feature b=
its require<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 other networking feature bits<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \item[VIRTIO_NET_F_GUEST_ANNOU<wbr>NCE] =
Requires<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 VIRTIO_NET_F_CTRL_VQ.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \item[VIRTIO_NET_F_MQ] Requires VIRTIO_N=
ET_F_CTRL_VQ.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \item[VIRTIO_NET_F_CTRL_MAC_AD<wbr>DR] R=
equires VIRTIO_NET_F_CTRL_VQ.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +\item[VIRTIO_NET_F_CTRL_RSS] Requires VIRTIO_N=
ET_F_MQ.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \end{description}<br>
<br>
<br>
=C2=A0 =C2=A0 Is this a requirement of RSSv2? Looks like at least RSS can w=
ork<br>
=C2=A0 =C2=A0 without multiqueue in V1.<br>
<br>
You are right this is not a requirement and should be dropped. More on RSS =
with single hardware queue:<br></div></div>
=C2=A0<a href=3D"https://docs.microsoft.com/en-us/windows-hardware/drivers/=
network/rss-with-a-single-hardware-receive-queue" rel=3D"noreferrer" target=
=3D"_blank">https://docs.microsoft.com/en<wbr>-us/windows-hardware/drivers/=
<wbr>network/rss-with-a-single-<wbr>hardware-receive-queue</a> &lt;<a href=
=3D"https://docs.microsoft.com/en-us/windows-hardware/drivers/network/rss-w=
ith-a-single-hardware-receive-queue" rel=3D"noreferrer" target=3D"_blank">h=
ttps://docs.microsoft.com/en<wbr>-us/windows-hardware/drivers/<wbr>network/=
rss-with-a-single-<wbr>hardware-receive-queue</a>&gt;<span class=3D"gmail-"=
><br>
<br>
<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \subsubsection{Legacy Interface: =
Feature<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bits}\label{sec:Device Types / Network Device /=
 Feature bits /<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Legacy Interface: Feature bits}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 @@ -3308,6 +3313,7 @@ struct virtio_net_hdr {<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u8 flags;<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 #define VIRTIO_NET_HDR_GSO_NONE=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 0<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 #define VIRTIO_NET_HDR_GSO_TCPV4=C2=A0 =
=C2=A0 =C2=A0 =C2=A01<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +#define VIRTIO_NET_HDR_GSO_RSS=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A02<br>
<br>
<br>
=C2=A0 =C2=A0 What&#39;s the reason of introducing a new GSO type here? RSS=
 should<br>
=C2=A0 =C2=A0 be independent for a specific offloading type I think.<br>
<br>
This was the straight forward option as there is no need to extend the virt=
io header but it can be moved to a specific offload.<br>
</span></blockquote>
<br>
If I understand correctly, RSS is not tied to GSO, so you mean VIRTIO_NET_H=
DR_RSS here?</blockquote><div>Yup=C2=A0</div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex"><div><div class=3D"gmail-h5"><br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 #define VIRTIO_NET_HDR_GSO_UDP=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A03<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 #define VIRTIO_NET_HDR_GSO_TCPV6=C2=A0 =
=C2=A0 =C2=A0 =C2=A04<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 #define VIRTIO_NET_HDR_GSO_ECN=C2=A0 =C2=
=A0 =C2=A0 0x80<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 @@ -3317,6 +3323,8 @@ struct virtio_net_hdr {<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 le16 csum_st=
art;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 le16 csum_of=
fset;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 le16 num_buf=
fers;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +// Only if RSS hash offload has been negotiate=
d<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +=C2=A0 =C2=A0 =C2=A0 =C2=A0 le64 rss_hash_valu=
e;<br>
<br>
<br>
=C2=A0 =C2=A0 Not a native English speaker, but &quot;rss_hash&quot; should=
 be sufficient.<br>
<br>
will do<br>
<br>
<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 };<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \end{lstlisting}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 @@ -4007,6 +4015,131 @@ VIRTIO_NET_CTRL_=
MQ_VQ_PAIRS_SE<wbr>T command.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 The device MUST NOT queue packets on rec=
eive queues greater than<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \field{virtqueue_pairs} once it has plac=
ed the<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SE<wbr>T command in=
 the used ring.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 +\paragraph{RSS hash offload}\label{sec:=
Device Types /<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Network Device / Device Operation / Control Vir=
tqueue / RSS<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 hash offload}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +\begin{lstlisting}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +#define RSS_HASH_FUNCTION_NONE=C2=A0 =C2=A0 =
=C2=A0 1<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +#define RSS_HASH_FUNCTION_TOEPLITZ=C2=A0 2<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +#define RSS_HASH_FUNCTION_SYMMETRIC 3<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +// Hash function fields<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +#define RSS_HASH_FIELDS_IPV4=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 0x00000100<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +#define RSS_HASH_FIELDS_TCP_IPV4=C2=A0 =C2=A0 =
=C2=A0 0x00000200<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +#define RSS_HASH_FIELDS_IPV6=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 0x00000400<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +#define RSS_HASH_FIELDS_IPV6_EX=C2=A0 =C2=A0 =
=C2=A0 =C2=A00x00000800<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +#define RSS_HASH_FIELDS_TCP_IPV6=C2=A0 =C2=A0 =
=C2=A0 0x00001000<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +#define RSS_HASH_FIELDS_TCP_IPV6_EX=C2=A0 =C2=
=A00x00002000<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +struct virtio_net_ctrl_rss_hash{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +le32 hash_function;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +struct virtio_net_rss {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +le32 hash_function;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +le32 hash_function_flags;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +le32 hash_key_length;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +le32 indirection_table_length;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0le32 hash_key[hash_key_length];<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0le32 indirection_table[indirection_<wbr>table_length];<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +};<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +#define VIRTIO_NET_F_CTRL_RSS=C2=A0 =C2=A0 =C2=
=A024<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +#define VIRTIO_NET_CTRL_RSS =C2=A0 =C2=A06<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +#define VIRTIO_NET_CTRL_RSS_GET_SUPPOR<wbr>TED=
_FUNCTIONS =C2=A00<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +#define VIRTIO_NET_CTRL_RSS_DISABLE =C2=A0 =C2=
=A01<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +#define VIRTIO_NET_CTRL_RSS_SET =C2=A0 =C2=A02=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +\end{lstlisting}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +If the VIRTIO_NET_F_CTRL_RSS is negotiated the=
 driver can<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 send control<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +commands for the RSS configuration.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +The class VIRTIO_NET_CTRL_RSS has three comman=
ds:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +\begin{enumerate}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +\item VIRTIO_NET_CTRL_RSS_GET_SUPPLI<wbr>ED_FU=
NCTIONS returns the<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 hash functions<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +=C2=A0 =C2=A0 =C2=A0 =C2=A0supported by the de=
vice to the driver.<br>
<br>
<br>
=C2=A0 =C2=A0 Can we just reuse virtio_net_rss in this case, it contains al=
l the<br>
=C2=A0 =C2=A0 informations (e.g hash key or whatever others)?<br>
<br>
Sure this can work<br>
<br>
<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +\item VIRTIO_NET_CTRL_RSS_DISABLE Instructs th=
e device that<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 RSS hashing is no<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +=C2=A0 =C2=A0 =C2=A0 =C2=A0longer required.<br=
>
<br>
<br>
=C2=A0 =C2=A0 So this implies that if MQ is supported, we will go to use<br=
>
=C2=A0 =C2=A0 automatic steering mode? I was thinking maybe it&#39;s better=
 to<br>
=C2=A0 =C2=A0 introduce a generic command to switch between steering mode.<=
br>
<br>
=C2=A0So you are suggesting that we should have an additional generic comma=
nd that changes between steering modes and RSS is one of those modes?<br>
</blockquote>
<br></div></div>
Yes.<div><div class=3D"gmail-h5"><br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +\item VIRTIO_NET_CTRL_RSS_SET applies the new =
RSS<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 configuration. The command is<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +=C2=A0 =C2=A0 =C2=A0 =C2=A0used by the driver =
for setting RSS hash function, hash<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 key and<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +=C2=A0 =C2=A0 =C2=A0 =C2=A0indirection table i=
n the device.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +\end{enumerate}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +If this feaure has been negotiated, the virtio=
 header has an<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 additional<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +field{rss_hash_value} field attached to it.<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +\devicenormative{\subparagrap<wbr>h}{RSS hash =
offload}{Device<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Types / Network Device / Device Operation / Con=
trol Virtqueue<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 / RSS hash offload}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +The device MUST fill the virtio_net_ctrl_rss_h=
ash structure<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 with the hash<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +functions it supports and return the structure=
 to the driver.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Zero or more<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +flags of the RSS_HASH_FUNCTION flags MUST be u=
sed to fill the<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 \field{hash_function}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +field.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +Upon recieving VIRTIO_NET_CTRL_DISABLE the dev=
ice SHOULD stop<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 calculating and<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +attaching hashes<br>
<br>
<br>
=C2=A0 =C2=A0 For simplicity, what if just compute the hash in this case?<b=
r>
=C2=A0 =C2=A0 Consider a driver may want to use this hash (e.g Linux driver=
).<br>
<br>
I get the use case but maybe introduce a new command for computing hashes o=
nly?<br>
</blockquote>
<br></div></div>
Then it looks unnecessary. (Btw, the above should be &quot;VIRTIO_NET_CTRL_=
RSS_DISABLE&quot;)<wbr>.</blockquote><div>We can have it as a sub command o=
f the RSS command where the command calculates hashes only</div><div>or els=
e make the device calculate hashes only when setting the hash function and =
key but not setting the indirection table (indirection_table_length =3D 0)<=
/div><div>True, thanks.=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">=C2=A0</blockquote><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">=C2=A0</blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><=
div><div class=3D"gmail-h5"><br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
I think the disable should be preserved for disabling only.<br>
<br>
<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 for the packets as well as stop setting the VIR=
TIO_NET_HDR_GSO_RSS<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +in the \field{gso_type} field, however the<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 \field{hash_function} field is kept<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +as a part of the header.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +The device MUST drop all previous RSS configur=
ation upon<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 receiving<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +VIRTIO_NET_CTRL_RSS_SET command.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +The device MUST set the RSS configuration acco=
rding to the<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 settings provided as<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +follows, once the configuration process is com=
pleted the<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 device SHOULD apply<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +the hash function to each of the incoming pack=
ets and<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 distribute the packets<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +through the virqueues using the calculated has=
h and the<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 indirection table<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +that were earlier provided by the driver.<br>
<br>
<br>
=C2=A0 =C2=A0 We support changing #queues dynamically, so need to clarify t=
he<br>
=C2=A0 =C2=A0 behavior when e.g the destination queues were disabled.<br>
<br>
I will go into these details in the next version.<br>
<br>
<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +Setting RSS configuration<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +\begin{enumerate}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +\item The driver fills all of the fields and p=
asses them<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 through the control<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +=C2=A0 =C2=A0 =C2=A0 =C2=A0queue to the device=
.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +\item The device sets the RSS configuration as=
 provided by<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 the driver.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +\item If the device successfully applied the c=
onfiguration,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 on each packet<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +=C2=A0 =C2=A0 =C2=A0 =C2=A0recieved the device=
 MUST calculate the hashing for the<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 packet and<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +=C2=A0 =C2=A0 =C2=A0 =C2=A0store it in the vir=
tio-net header in rss_hash_value<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 and the hash<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +=C2=A0 =C2=A0 =C2=A0 =C2=A0fields used in the =
calculation in rss_hash_type.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +\end{enumerate}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +In case of any unexpected values/ unsupported =
hash function<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 the driver<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +MUST return VIRTIO_NET_ERR in the \field{ack} =
field.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +\drivernormative{\subparagrap<wbr>h}{RSS hash =
offload}{Device<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Types / Network Device / Device Operation / Con=
trol Virtqueue<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 / RSS hash offload}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +If the driver negotiates the feature VIRTIO_NE=
T_F_CTRL_RSS<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 the driver SHOULD<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +send VIRTIO_NET_CTRL_RSS_SET command to the de=
vice along with<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 the RSS structure<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +filled. The RSS structure fields should be fil=
led as follows:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +\begin{itemize}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +\item The driver SHOULD choose the hash functi=
on that SHOULD<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 be used and fill<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +=C2=A0 =C2=A0 =C2=A0 =C2=A0it in the \field{ha=
sh_function} field along with the<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 approperiate flags<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +=C2=A0 =C2=A0 =C2=A0 =C2=A0in the \field{hash_=
function_flags} field. These flags<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 inidicate to the<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +=C2=A0 =C2=A0 =C2=A0 =C2=A0device which packet=
 fields MUST be used in the<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 calculation process of<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +=C2=A0 =C2=A0 =C2=A0 =C2=A0the hash.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +\item Once the hash function has been chosen a=
 suitable hash<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 key should be set<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +=C2=A0 =C2=A0 =C2=A0 =C2=A0in the \field{hash_=
key} field, the length of the key<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 should be stored<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +=C2=A0 =C2=A0 =C2=A0 =C2=A0in the \field{hash_=
key_length} field.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +\item Lastly the driver should fill the indire=
ction table<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 array in the<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +=C2=A0 =C2=A0 =C2=A0 =C2=A0\field{indirection_=
table} field while setting the<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 array length in<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +=C2=A0 =C2=A0 =C2=A0 =C2=A0\field{indirection_=
table_leng<wbr>th}. This structure is<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 used by the device<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +=C2=A0 =C2=A0 =C2=A0 =C2=A0for determining in =
which RX virt queue the packet<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 should be placed.<br>
<br>
<br>
=C2=A0 =C2=A0 Is the indirection table expected to be changed frequently? I=
f<br>
=C2=A0 =C2=A0 yes, a single entry modification will cause a update of the w=
hole<br>
=C2=A0 =C2=A0 table.<br>
<br>
No, it should not be changing frequently<br>
<br>
<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +\end{itemize}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +Once the configuration phase is over successfu=
lly, the<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 packets SHOULD have the<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +\field{rss_hash_value} field with the hash val=
ue that was<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 calculated by the<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +device.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +Whenever the driver wants to discard the curre=
nt RSS<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 settings, it can send an<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +VIRTIO_NET_CTRL_RSS_SET command along with rss=
 structure that has<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +RSS_HASH_FUNCTION_NONE the \field{hash_functio=
n} field.<br>
<br>
<br>
=C2=A0 =C2=A0 So this function looks equivalent to VIRTIO_NET_CTRL_RSS_DISA=
BLE?<br>
<br>
Yes, do you think we should discard one of the two?<br>
</blockquote>
<br></div></div>
Yes.<br>
<br>
Thanks<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex"><span class=3D"gmail-">
<br>
=C2=A0 =C2=A0 Thanks<br>
<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +The driver MUST check the \field{ack} field va=
lue provided by<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 the device, in<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +case the value is not VIRTIO_NET_OK then the d=
river MUST<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 hanlde faliure and<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +retry another hash function or else give up.<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \subparagraph{Legacy Interface: Automati=
c receive steering<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 in multiqueue mode}\label{sec:Device Types / Ne=
twork Device /<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Device Operation / Control Virtqueue / Automati=
c receive<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 steering in multiqueue mode / Legacy Interface:=
 Automatic<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 receive steering in multiqueue mode}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 When using the legacy interface, transit=
ional devices and<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 drivers<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MUST format \field{virtqueue_pairs}<br>
<br>
<br>
<br>
<br>
<br>
-- <br>
Respectfully,<br></span>
*/Sameeh Jubran/*<br>
/Linkedin &lt;<a href=3D"https://il.linkedin.com/pub/sameeh-jubran/87/747/a=
8a" rel=3D"noreferrer" target=3D"_blank">https://il.linkedin.com/pub/s<wbr>=
ameeh-jubran/87/747/a8a</a>&gt;/<br>
/Software Engineer @ Daynix &lt;<a href=3D"http://www.daynix.com" rel=3D"no=
referrer" target=3D"_blank">http://www.daynix.com</a>&gt;./<br>
</blockquote>
<br>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div class=
=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=
=3D"ltr"><div><div dir=3D"ltr"><font size=3D"4" color=3D"#0b5394" face=3D"t=
imes new roman, serif">Respectfully,<br></font><div style=3D"font-size:12.8=
px;color:rgb(136,136,136)"><font size=3D"4" color=3D"#0b5394" face=3D"times=
 new roman, serif"><b><i>Sameeh Jubran</i></b></font></div><div style=3D"fo=
nt-size:12.8px;color:rgb(136,136,136)"><i style=3D"color:rgb(7,55,99);font-=
family:&quot;times new roman&quot;,serif;font-size:large"><span style=3D"li=
ne-height:15px"><a href=3D"https://il.linkedin.com/pub/sameeh-jubran/87/747=
/a8a" title=3D"View public profile" name=3D"UNIQUE_ID_SafeHtmlFilter_UNIQUE=
_ID_SafeHtmlFilter_UNIQUE_ID_SafeHtmlFilter_UNIQUE_ID_SafeHtmlFilter_UNIQUE=
_ID_SafeHtmlFilter_14e2c1de96f8c195_UNIQUE_ID_SafeHtmlFilter_SafeHtmlFilter=
_SafeHtmlFilter_webProfileURL" style=3D"color:rgb(17,85,204);margin:0px;pad=
ding:0px;border-width:0px;outline:none;vertical-align:baseline;text-decorat=
ion:none" target=3D"_blank">Linkedin</a></span></i><br></div><div style=3D"=
font-size:12.8px;color:rgb(136,136,136)"><font size=3D"4" face=3D"times new=
 roman, serif" color=3D"#073763"><i>Software Engineer @ <a href=3D"http://w=
ww.daynix.com" target=3D"_blank">Daynix</a>.</i></font></div></div></div></=
div></div></div></div></div></div>
</div></div>

--00000000000037ce190567d4dbeb--

