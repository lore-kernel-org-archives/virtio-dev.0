Return-Path: virtio-dev-return-3620-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id EA71F581809C
	for <virtio-dev@lists.oasis-open.org>; Tue, 20 Mar 2018 01:26:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <98157695-e3f5-5f5f-2b6e-b60f25bfe439@oracle.com>
References: <20180125162709.370-1-sameeh@daynix.com> <20180125162709.370-2-sameeh@daynix.com>
 <767992ef-c23a-2098-6055-3b8d0cfec093@redhat.com> <CAKPgXcG4C0k+Kzjo0HzfDLskMcxRfLNvXe5wxVJY4cFMZnhn4Q@mail.gmail.com>
 <98157695-e3f5-5f5f-2b6e-b60f25bfe439@oracle.com>
From: Sameeh Jubran <sameeh@daynix.com>
Date: Tue, 20 Mar 2018 10:26:01 +0200
Message-ID: <CAKPgXcGYsz+itwSSfA4A9CrukcnO=Bndz=wUD4s+eQq03BQydw@mail.gmail.com>
Content-Type: multipart/alternative; boundary="001a11448e5424cb070567d3d366"
Subject: Re: [virtio-dev] [RFC virtio-net 1/1] content: net: Add
 VIRTIO_NET_F_CTRL_RSS feature
To: Vijayabhaskar Balakrishna <vijay.balakrishna@oracle.com>
Cc: Jason Wang <jasowang@redhat.com>, virtio-dev <virtio-dev@lists.oasis-open.org>, Amnon Ilan <ailan@redhat.com>, Yan Vugenfirer <yan@daynix.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--001a11448e5424cb070567d3d366
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 20, 2018 at 12:29 AM, Vijayabhaskar Balakrishna <
vijay.balakrishna@oracle.com> wrote:

> On 3/19/2018 6:33 AM, Sameeh Jubran wrote:
>
>
>
> On Thu, Mar 15, 2018 at 4:19 AM, Jason Wang <jasowang@redhat.com> wrote:
>
>>
>>
>> On 2018=E5=B9=B401=E6=9C=8826=E6=97=A5 00:27, Sameeh Jubran wrote:
>>
>>> From: Sameeh Jubran <sameeh.j@gmail.com>
>>>
>>> Most modern high end network devices today support configurable hash
>>> functions,
>>> this commit introduces RSS - Receive Side Scaling - [1] to virtio net
>>> device.
>>>
>>> The RSS is a technology from Microsoft that boosts network device
>>> performance
>>> by efficiently distributing the traffic among the CPUs in a
>>> multiprocessor
>>> system.
>>>
>>> This feature is supported in most of the modern network cards as well a=
s
>>> most
>>> modern OSes including Linux and Windows. It is worth mentioning that
>>> both DPDK
>>> and Hyper-v support RSS too.
>>>
>>> [1] https://docs.microsoft.com/en-us/windows-hardware/drivers/ne
>>> twork/ndis-receive-side-scaling2
>>>
>>> Signed-off-by: Sameeh Jubran <sjubran@redhat.com>
>>> ---
>>>   content.tex | 133 ++++++++++++++++++++++++++++++
>>> ++++++++++++++++++++++++++++++
>>>   1 file changed, 133 insertions(+)
>>>
>>> diff --git a/content.tex b/content.tex
>>> index c840588..5969b28 100644
>>> --- a/content.tex
>>> +++ b/content.tex
>>> @@ -3115,6 +3115,9 @@ features.
>>>     \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through
>>> control
>>>       channel.
>>> +
>>> +\item[VIRTIO_NET_F_CTRL_RSS(24)] Device supports configurable RSS hash
>>> +    functions.
>>>   \end{description}
>>>     \subsubsection{Feature bit requirements}\label{sec:Device Types /
>>> Network Device / Feature bits / Feature bit requirements}
>>> @@ -3138,6 +3141,8 @@ Some networking feature bits require other
>>> networking feature bits
>>>   \item[VIRTIO_NET_F_GUEST_ANNOUNCE] Requires VIRTIO_NET_F_CTRL_VQ.
>>>   \item[VIRTIO_NET_F_MQ] Requires VIRTIO_NET_F_CTRL_VQ.
>>>   \item[VIRTIO_NET_F_CTRL_MAC_ADDR] Requires VIRTIO_NET_F_CTRL_VQ.
>>> +
>>> +\item[VIRTIO_NET_F_CTRL_RSS] Requires VIRTIO_NET_F_MQ.
>>>   \end{description}
>>>
>>
>> Is this a requirement of RSSv2? Looks like at least RSS can work without
>> multiqueue in V1.
>
> You are right this is not a requirement and should be dropped. More on RS=
S
> with single hardware queue:
>  https://docs.microsoft.com/en-us/windows-hardware/drivers/
> network/rss-with-a-single-hardware-receive-queue
> <https://docs.microsoft.com/en-us/windows-hardware/drivers/network/rss-wi=
th-a-single-hardware-receive-queue>
>
> Do we still expect efficiency (distribution of traffic among CPUs) in cas=
e
> of single queue by having RSS (in host software)?
>
 This depends on the configuration settings for the hash function and
indirection table.

>
>
>>
>>     \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Type=
s
>>> / Network Device / Feature bits / Legacy Interface: Feature bits}
>>> @@ -3308,6 +3313,7 @@ struct virtio_net_hdr {
>>>           u8 flags;
>>>   #define VIRTIO_NET_HDR_GSO_NONE        0
>>>   #define VIRTIO_NET_HDR_GSO_TCPV4       1
>>> +#define VIRTIO_NET_HDR_GSO_RSS         2
>>>
>>
>> What's the reason of introducing a new GSO type here? RSS should be
>> independent for a specific offloading type I think.
>
> This was the straight forward option as there is no need to extend the
> virtio header but it can be moved to a specific offload.
>
>>
>>
>>   #define VIRTIO_NET_HDR_GSO_UDP         3
>>>   #define VIRTIO_NET_HDR_GSO_TCPV6       4
>>>   #define VIRTIO_NET_HDR_GSO_ECN      0x80
>>> @@ -3317,6 +3323,8 @@ struct virtio_net_hdr {
>>>           le16 csum_start;
>>>           le16 csum_offset;
>>>           le16 num_buffers;
>>> +// Only if RSS hash offload has been negotiated
>>> +        le64 rss_hash_value;
>>>
>> I asked Sameeh privately and asking here again.   Is compatibility
> maintained if we introduce a new field to virtio_net_hdr?
>
I believe so, only if the RSS feature has been acked then this header is
used which should preserve compatibility

>
>> Not a native English speaker, but "rss_hash" should be sufficient.
>
> will do
>
>>
>>
>>   };
>>>   \end{lstlisting}
>>>   @@ -4007,6 +4015,131 @@ VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET command.
>>>   The device MUST NOT queue packets on receive queues greater than
>>>   \field{virtqueue_pairs} once it has placed the
>>> VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET command in the used ring.
>>>   +\paragraph{RSS hash offload}\label{sec:Device Types / Network Device
>>> / Device Operation / Control Virtqueue / RSS hash offload}
>>> +
>>> +\begin{lstlisting}
>>> +#define RSS_HASH_FUNCTION_NONE      1
>>> +#define RSS_HASH_FUNCTION_TOEPLITZ  2
>>> +#define RSS_HASH_FUNCTION_SYMMETRIC 3
>>>
>> Should above be bit field?  I mean first two are fine, should ..SYMMETRI=
C
> should be 4 (0x4)    Otherwise description "Zero or more flags of the
> RSS_HASH_FUNCTION flags MUST be used to fill the field hash_function" bel=
ow
> wouldn't be correct.
>
Each function is a distinct function, there is no sense for setting two or
more functions in the field. Indeed the description is not accurate and
I'll be addressing this in v2, thanks for catching this :)

>
>
> +
>>> +// Hash function fields
>>> +#define RSS_HASH_FIELDS_IPV4          0x00000100
>>> +#define RSS_HASH_FIELDS_TCP_IPV4      0x00000200
>>> +#define RSS_HASH_FIELDS_IPV6          0x00000400
>>> +#define RSS_HASH_FIELDS_IPV6_EX       0x00000800
>>> +#define RSS_HASH_FIELDS_TCP_IPV6      0x00001000
>>> +#define RSS_HASH_FIELDS_TCP_IPV6_EX   0x00002000
>>> +
>>> +struct virtio_net_ctrl_rss_hash{
>>> +le32 hash_function;
>>> +}
>>> +
>>> +struct virtio_net_rss {
>>> +le32 hash_function;
>>> +le32 hash_function_flags;
>>> +le32 hash_key_length;
>>> +le32 indirection_table_length;
>>> +       struct {
>>> +               le32 hash_key[hash_key_length];
>>> +               le32 indirection_table[indirection_table_length];
>>> +       }
>>> +};
>>>
>> I'm new here, hence my question: Is array size typically described like
> above in virtio spec?  And with #define constant in implementation?
>
Yes, take a look here for example:
https://github.com/oasis-tcs/virtio-spec/blob/master/content.tex#L4778
<https://github.com/oasis-tcs/virtio-spec/blob/master/content.tex#L4778>
https://github.com/oasis-tcs/virtio-spec/blob/master/content.tex#L2716

>
> Thanks,
> Vijay
>
> +
>>> +#define VIRTIO_NET_F_CTRL_RSS     24
>>> +
>>> +#define VIRTIO_NET_CTRL_RSS                           6
>>> +#define VIRTIO_NET_CTRL_RSS_GET_SUPPORTED_FUNCTIONS   0
>>> +#define VIRTIO_NET_CTRL_RSS_DISABLE                   1
>>> +#define VIRTIO_NET_CTRL_RSS_SET                       2
>>> +\end{lstlisting}
>>> +
>>> +If the VIRTIO_NET_F_CTRL_RSS is negotiated the driver can send control
>>> +commands for the RSS configuration.
>>> +
>>> +The class VIRTIO_NET_CTRL_RSS has three commands:
>>> +
>>> +\begin{enumerate}
>>> +\item VIRTIO_NET_CTRL_RSS_GET_SUPPLIED_FUNCTIONS returns the hash
>>> functions
>>> +       supported by the device to the driver.
>>>
>>
>> Can we just reuse virtio_net_rss in this case, it contains all the
>> informations (e.g hash key or whatever others)?
>
> Sure this can work
>
>>
>>
>> +\item VIRTIO_NET_CTRL_RSS_DISABLE Instructs the device that RSS hashing
>>> is no
>>> +       longer required.
>>>
>>
>> So this implies that if MQ is supported, we will go to use automatic
>> steering mode? I was thinking maybe it's better to introduce a generic
>> command to switch between steering mode.
>
>  So you are suggesting that we should have an additional generic command
> that changes between steering modes and RSS is one of those modes?
>
>>
>>
>> +\item VIRTIO_NET_CTRL_RSS_SET applies the new RSS configuration. The
>>> command is
>>> +       used by the driver for setting RSS hash function, hash key and
>>> +       indirection table in the device.
>>> +\end{enumerate}
>>> +
>>> +If this feaure has been negotiated, the virtio header has an additiona=
l
>>> +field{rss_hash_value} field attached to it.
>>> +
>>> +\devicenormative{\subparagraph}{RSS hash offload}{Device Types /
>>> Network Device / Device Operation / Control Virtqueue / RSS hash offloa=
d}
>>> +
>>> +The device MUST fill the virtio_net_ctrl_rss_hash structure with the
>>> hash
>>> +functions it supports and return the structure to the driver. Zero or
>>> more
>>> +flags of the RSS_HASH_FUNCTION flags MUST be used to fill the
>>> \field{hash_function}
>>> +field.
>>> +
>>> +Upon recieving VIRTIO_NET_CTRL_DISABLE the device SHOULD stop
>>> calculating and
>>> +attaching hashes
>>>
>>
>> For simplicity, what if just compute the hash in this case? Consider a
>> driver may want to use this hash (e.g Linux driver).
>
> I get the use case but maybe introduce a new command for computing hashes
> only? I think the disable should be preserved for disabling only.
>
>>
>>
>> for the packets as well as stop setting the VIRTIO_NET_HDR_GSO_RSS
>>> +in the \field{gso_type} field, however the \field{hash_function} field
>>> is kept
>>> +as a part of the header.
>>> +
>>> +The device MUST drop all previous RSS configuration upon receiving
>>> +VIRTIO_NET_CTRL_RSS_SET command.
>>> +
>>> +The device MUST set the RSS configuration according to the settings
>>> provided as
>>> +follows, once the configuration process is completed the device SHOULD
>>> apply
>>> +the hash function to each of the incoming packets and distribute the
>>> packets
>>> +through the virqueues using the calculated hash and the indirection
>>> table
>>> +that were earlier provided by the driver.
>>>
>>
>> We support changing #queues dynamically, so need to clarify the behavior
>> when e.g the destination queues were disabled.
>
> I will go into these details in the next version.
>
>>
>>
>> +
>>> +Setting RSS configuration
>>> +\begin{enumerate}
>>> +\item The driver fills all of the fields and passes them through the
>>> control
>>> +       queue to the device.
>>> +
>>> +\item The device sets the RSS configuration as provided by the driver.
>>> +
>>> +\item If the device successfully applied the configuration, on each
>>> packet
>>> +       recieved the device MUST calculate the hashing for the packet a=
nd
>>> +       store it in the virtio-net header in rss_hash_value and the has=
h
>>> +       fields used in the calculation in rss_hash_type.
>>> +\end{enumerate}
>>> +
>>> +In case of any unexpected values/ unsupported hash function the driver
>>> +MUST return VIRTIO_NET_ERR in the \field{ack} field.
>>> +
>>> +\drivernormative{\subparagraph}{RSS hash offload}{Device Types /
>>> Network Device / Device Operation / Control Virtqueue / RSS hash offloa=
d}
>>> +
>>> +If the driver negotiates the feature VIRTIO_NET_F_CTRL_RSS the driver
>>> SHOULD
>>> +send VIRTIO_NET_CTRL_RSS_SET command to the device along with the RSS
>>> structure
>>> +filled. The RSS structure fields should be filled as follows:
>>> +
>>> +\begin{itemize}
>>> +\item The driver SHOULD choose the hash function that SHOULD be used
>>> and fill
>>> +       it in the \field{hash_function} field along with the
>>> approperiate flags
>>> +       in the \field{hash_function_flags} field. These flags inidicate
>>> to the
>>> +       device which packet fields MUST be used in the calculation
>>> process of
>>> +       the hash.
>>> +\item Once the hash function has been chosen a suitable hash key shoul=
d
>>> be set
>>> +       in the \field{hash_key} field, the length of the key should be
>>> stored
>>> +       in the \field{hash_key_length} field.
>>> +\item Lastly the driver should fill the indirection table array in the
>>> +       \field{indirection_table} field while setting the array length =
in
>>> +       \field{indirection_table_length}. This structure is used by the
>>> device
>>> +       for determining in which RX virt queue the packet should be
>>> placed.
>>>
>>
>> Is the indirection table expected to be changed frequently? If yes, a
>> single entry modification will cause a update of the whole table.
>
> No, it should not be changing frequently
>
>
>>
>> +\end{itemize}
>>> +Once the configuration phase is over successfully, the packets SHOULD
>>> have the
>>> +\field{rss_hash_value} field with the hash value that was calculated b=
y
>>> the
>>> +device.
>>> +
>>> +Whenever the driver wants to discard the current RSS settings, it can
>>> send an
>>> +VIRTIO_NET_CTRL_RSS_SET command along with rss structure that has
>>> +RSS_HASH_FUNCTION_NONE the \field{hash_function} field.
>>>
>>
>> So this function looks equivalent to VIRTIO_NET_CTRL_RSS_DISABLE?
>>
> Yes, do you think we should discard one of the two?
>
>>
>> Thanks
>>
>>
>> +
>>> +The driver MUST check the \field{ack} field value provided by the
>>> device, in
>>> +case the value is not VIRTIO_NET_OK then the driver MUST hanlde faliur=
e
>>> and
>>> +retry another hash function or else give up.
>>> +
>>>   \subparagraph{Legacy Interface: Automatic receive steering in
>>> multiqueue mode}\label{sec:Device Types / Network Device / Device Opera=
tion
>>> / Control Virtqueue / Automatic receive steering in multiqueue mode /
>>> Legacy Interface: Automatic receive steering in multiqueue mode}
>>>   When using the legacy interface, transitional devices and drivers
>>>   MUST format \field{virtqueue_pairs}
>>>
>>
>>
>
>
> --
> Respectfully,
> *Sameeh Jubran*
> *Linkedin <https://il.linkedin.com/pub/sameeh-jubran/87/747/a8a>*
> *Software Engineer @ Daynix <http://www.daynix.com>.*
>
>
>


--=20
Respectfully,
*Sameeh Jubran*
*Linkedin <https://il.linkedin.com/pub/sameeh-jubran/87/747/a8a>*
*Software Engineer @ Daynix <http://www.daynix.com>.*

--001a11448e5424cb070567d3d366
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Tue, Mar 20, 2018 at 12:29 AM, Vijayabhaskar Balakrishna <span dir=
=3D"ltr">&lt;<a href=3D"mailto:vijay.balakrishna@oracle.com" target=3D"_bla=
nk">vijay.balakrishna@oracle.com</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
 =20
   =20
 =20
  <div bgcolor=3D"#FFFFFF"><div><div class=3D"gmail-m_-5873866276124220634h=
5">
    <div class=3D"gmail-m_-5873866276124220634m_4174557398479348472moz-cite=
-prefix">On 3/19/2018 6:33 AM, Sameeh Jubran
      wrote:<br>
    </div>
    <blockquote type=3D"cite">
      <div dir=3D"ltr"><br>
        <div class=3D"gmail_extra"><br>
          <div class=3D"gmail_quote">On Thu, Mar 15, 2018 at 4:19 AM,
            Jason Wang <span dir=3D"ltr">&lt;<a href=3D"mailto:jasowang@red=
hat.com" target=3D"_blank">jasowang@redhat.com</a>&gt;</span>
            wrote:<br>
            <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
              <div class=3D"gmail-m_-5873866276124220634m_41745573984793484=
72gmail-HOEnZb">
                <div class=3D"gmail-m_-5873866276124220634m_417455739847934=
8472gmail-h5"><br>
                  <br>
                  On 2018=E5=B9=B401=E6=9C=8826=E6=97=A5 00:27, Sameeh Jubr=
an wrote:<br>
                  <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
                    From: Sameeh Jubran &lt;<a href=3D"mailto:sameeh.j@gmai=
l.com" target=3D"_blank">sameeh.j@gmail.com</a>&gt;<br>
                    <br>
                    Most modern high end network devices today support
                    configurable hash functions,<br>
                    this commit introduces RSS - Receive Side Scaling -
                    [1] to virtio net device.<br>
                    <br>
                    The RSS is a technology from Microsoft that boosts
                    network device performance<br>
                    by efficiently distributing the traffic among the
                    CPUs in a multiprocessor<br>
                    system.<br>
                    <br>
                    This feature is supported in most of the modern
                    network cards as well as most<br>
                    modern OSes including Linux and Windows. It is worth
                    mentioning that both DPDK<br>
                    and Hyper-v support RSS too.<br>
                    <br>
                    [1] <a href=3D"https://docs.microsoft.com/en-us/windows=
-hardware/drivers/network/ndis-receive-side-scaling2" rel=3D"noreferrer" ta=
rget=3D"_blank">https://docs.microsoft.com/en-<wbr>us/windows-hardware/driv=
ers/ne<wbr>twork/ndis-receive-side-scalin<wbr>g2</a><br>
                    <br>
                    Signed-off-by: Sameeh Jubran &lt;<a href=3D"mailto:sjub=
ran@redhat.com" target=3D"_blank">sjubran@redhat.com</a>&gt;<br>
                    ---<br>
                    =C2=A0 content.tex | 133 ++++++++++++++++++++++++++++++=
<wbr>++++++++++++++++++++++++++++++<br>
                    =C2=A0 1 file changed, 133 insertions(+)<br>
                    <br>
                    diff --git a/content.tex b/content.tex<br>
                    index c840588..5969b28 100644<br>
                    --- a/content.tex<br>
                    +++ b/content.tex<br>
                    @@ -3115,6 +3115,9 @@ features.<br>
                    =C2=A0 =C2=A0 \item[VIRTIO_NET_F_CTRL_MAC_AD<wbr>DR(23)=
] Set
                    MAC address through control<br>
                    =C2=A0 =C2=A0 =C2=A0 channel.<br>
                    +<br>
                    +\item[VIRTIO_NET_F_CTRL_RSS(2<wbr>4)] Device
                    supports configurable RSS hash<br>
                    +=C2=A0 =C2=A0 functions.<br>
                    =C2=A0 \end{description}<br>
                    =C2=A0 =C2=A0 \subsubsection{Feature bit
                    requirements}\label{sec:Device Types / Network
                    Device / Feature bits / Feature bit requirements}<br>
                    @@ -3138,6 +3141,8 @@ Some networking feature bits
                    require other networking feature bits<br>
                    =C2=A0 \item[VIRTIO_NET_F_GUEST_ANNOU<wbr>NCE] Requires
                    VIRTIO_NET_F_CTRL_VQ.<br>
                    =C2=A0 \item[VIRTIO_NET_F_MQ] Requires
                    VIRTIO_NET_F_CTRL_VQ.<br>
                    =C2=A0 \item[VIRTIO_NET_F_CTRL_MAC_AD<wbr>DR] Requires
                    VIRTIO_NET_F_CTRL_VQ.<br>
                    +<br>
                    +\item[VIRTIO_NET_F_CTRL_RSS] Requires
                    VIRTIO_NET_F_MQ.<br>
                    =C2=A0 \end{description}<br>
                  </blockquote>
                  <br>
                </div>
              </div>
              Is this a requirement of RSSv2? Looks like at least RSS
              can work without multiqueue in V1.</blockquote>
            <div>You are right this is not a requirement and should be
              dropped. More on RSS with single hardware queue:</div>
            <div><a href=3D"https://docs.microsoft.com/en-us/windows-hardwa=
re/drivers/network/rss-with-a-single-hardware-receive-queue" target=3D"_bla=
nk">=C2=A0https://docs.microsoft.com/en<wbr>-us/windows-hardware/drivers/<w=
br>network/rss-with-a-single-<wbr>hardware-receive-queue</a></div>
          </div>
        </div>
      </div>
    </blockquote></div></div>
    Do we still expect efficiency (distribution of traffic among CPUs)
    in case of single queue by having RSS (in host software)?</div></blockq=
uote><div>=C2=A0This depends on the configuration settings for the hash fun=
ction and indirection table.</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex"><div bgcolor=3D"#FFFFFF"><span><br>
    <blockquote type=3D"cite">
      <div dir=3D"ltr">
        <div class=3D"gmail_extra">
          <div class=3D"gmail_quote">
            <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><span class=
=3D"gmail-m_-5873866276124220634m_4174557398479348472gmail-"><br>
                <br>
                <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
                  =C2=A0 =C2=A0 \subsubsection{Legacy Interface: Feature
                  bits}\label{sec:Device Types / Network Device /
                  Feature bits / Legacy Interface: Feature bits}<br>
                  @@ -3308,6 +3313,7 @@ struct virtio_net_hdr {<br>
                  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u8 flags;<br>
                  =C2=A0 #define VIRTIO_NET_HDR_GSO_NONE=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 0<br>
                  =C2=A0 #define VIRTIO_NET_HDR_GSO_TCPV4=C2=A0 =C2=A0 =C2=
=A0 =C2=A01<br>
                  +#define VIRTIO_NET_HDR_GSO_RSS=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A02<br>
                </blockquote>
                <br>
              </span>
              What&#39;s the reason of introducing a new GSO type here? RSS
              should be independent for a specific offloading type I
              think.</blockquote>
            <div>This was the straight forward option as there is no
              need to extend the virtio header but it can be moved to a
              specific offload.</div>
            <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><span class=
=3D"gmail-m_-5873866276124220634m_4174557398479348472gmail-"><br>
                <br>
                <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
                  =C2=A0 #define VIRTIO_NET_HDR_GSO_UDP=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A03<br>
                  =C2=A0 #define VIRTIO_NET_HDR_GSO_TCPV6=C2=A0 =C2=A0 =C2=
=A0 =C2=A04<br>
                  =C2=A0 #define VIRTIO_NET_HDR_GSO_ECN=C2=A0 =C2=A0 =C2=A0=
 0x80<br>
                  @@ -3317,6 +3323,8 @@ struct virtio_net_hdr {<br>
                  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 le16 csum_start;<br>
                  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 le16 csum_offset;<br>
                  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 le16 num_buffers;<br>
                  +// Only if RSS hash offload has been negotiated<br>
                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0 le64 rss_hash_value;<br>
                </blockquote>
              </span></blockquote>
          </div>
        </div>
      </div>
    </blockquote></span>
    I asked Sameeh privately and asking here again.=C2=A0=C2=A0 Is compatib=
ility
    maintained if we introduce a new field to virtio_net_hdr?<br></div></bl=
ockquote><div>I believe so, only if the RSS feature has been acked then thi=
s header is used which should preserve compatibility=C2=A0</div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex"><div bgcolor=3D"#FFFFFF"><span>
    <blockquote type=3D"cite">
      <div dir=3D"ltr">
        <div class=3D"gmail_extra">
          <div class=3D"gmail_quote">
            <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><span class=
=3D"gmail-m_-5873866276124220634m_4174557398479348472gmail-">
                <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
                </blockquote>
                <br>
              </span>
              Not a native English speaker, but &quot;rss_hash&quot; should=
 be
              sufficient.</blockquote>
            <div>will do=C2=A0</div>
            <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
              <div>
                <div class=3D"gmail-m_-5873866276124220634m_417455739847934=
8472gmail-h5"><br>
                  <br>
                  <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
                    =C2=A0 };<br>
                    =C2=A0 \end{lstlisting}<br>
                    =C2=A0 @@ -4007,6 +4015,131 @@
                    VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SE<wbr>T command.<br>
                    =C2=A0 The device MUST NOT queue packets on receive
                    queues greater than<br>
                    =C2=A0 \field{virtqueue_pairs} once it has placed the
                    VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SE<wbr>T command in the
                    used ring.<br>
                    =C2=A0 +\paragraph{RSS hash offload}\label{sec:Device
                    Types / Network Device / Device Operation / Control
                    Virtqueue / RSS hash offload}<br>
                    +<br>
                    +\begin{lstlisting}<br>
                    +#define RSS_HASH_FUNCTION_NONE=C2=A0 =C2=A0 =C2=A0 1<b=
r>
                    +#define RSS_HASH_FUNCTION_TOEPLITZ=C2=A0 2<br>
                    +#define RSS_HASH_FUNCTION_SYMMETRIC 3<br>
                  </blockquote>
                </div>
              </div>
            </blockquote>
          </div>
        </div>
      </div>
    </blockquote></span>
    Should above be bit field?=C2=A0 I mean first two are fine, should
    ..SYMMETRIC should be 4 (0x4) =C2=A0=C2=A0 Otherwise description &quot;=
Zero or more
    flags of the RSS_HASH_FUNCTION flags MUST be used to fill the field
    hash_function&quot; below wouldn&#39;t be correct.</div></blockquote><d=
iv>Each function is a distinct function, there is no sense for setting two =
or more functions in the field. Indeed the description is not accurate and =
I&#39;ll be addressing this in v2, thanks for catching this :)</div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex"><div bgcolor=3D"#FFFFFF"><span><=
br>
    <br>
    <blockquote type=3D"cite">
      <div dir=3D"ltr">
        <div class=3D"gmail_extra">
          <div class=3D"gmail_quote">
            <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
              <div>
                <div class=3D"gmail-m_-5873866276124220634m_417455739847934=
8472gmail-h5">
                  <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
                    +<br>
                    +// Hash function fields<br>
                    +#define RSS_HASH_FIELDS_IPV4=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 0x00000100<br>
                    +#define RSS_HASH_FIELDS_TCP_IPV4=C2=A0 =C2=A0 =C2=A0 0=
x00000200<br>
                    +#define RSS_HASH_FIELDS_IPV6=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 0x00000400<br>
                    +#define RSS_HASH_FIELDS_IPV6_EX=C2=A0 =C2=A0 =C2=A0 =
=C2=A00x00000800<br>
                    +#define RSS_HASH_FIELDS_TCP_IPV6=C2=A0 =C2=A0 =C2=A0 0=
x00001000<br>
                    +#define RSS_HASH_FIELDS_TCP_IPV6_EX=C2=A0 =C2=A00x0000=
2000<br>
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
                    +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0le32 hash_key[hash_key_length];<br>
                    +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0le32 indirection_table[indirection_<wbr>table_length];<br>
                    +=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
                    +};<br>
                  </blockquote>
                </div>
              </div>
            </blockquote>
          </div>
        </div>
      </div>
    </blockquote></span>
    I&#39;m new here, hence my question: Is array size typically described
    like above in virtio spec?=C2=A0 And with #define constant in
    implementation?=C2=A0</div></blockquote><div>Yes, take a look here for =
example:</div><div><a href=3D"https://github.com/oasis-tcs/virtio-spec/blob=
/master/content.tex#L4778">https://github.com/oasis-tcs/virtio-spec/blob/ma=
ster/content.tex#L4778=C2=A0</a></div><div><a href=3D"https://github.com/oa=
sis-tcs/virtio-spec/blob/master/content.tex#L2716">https://github.com/oasis=
-tcs/virtio-spec/blob/master/content.tex#L2716<br></a></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex"><div bgcolor=3D"#FFFFFF">
    <br>
    Thanks,<br>
    Vijay<div><div class=3D"gmail-m_-5873866276124220634h5"><br>
    <blockquote type=3D"cite">
      <div dir=3D"ltr">
        <div class=3D"gmail_extra">
          <div class=3D"gmail_quote">
            <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
              <div>
                <div class=3D"gmail-m_-5873866276124220634m_417455739847934=
8472gmail-h5">
                  <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
                    +<br>
                    +#define VIRTIO_NET_F_CTRL_RSS=C2=A0 =C2=A0 =C2=A024<br=
>
                    +<br>
                    +#define VIRTIO_NET_CTRL_RSS=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                    =C2=A0 =C2=A06<br>
                    +#define VIRTIO_NET_CTRL_RSS_GET_SUPPOR<wbr>TED_FUNCTIO=
NS=C2=A0
                    =C2=A00<br>
                    +#define VIRTIO_NET_CTRL_RSS_DISABLE=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                    =C2=A0 =C2=A01<br>
                    +#define VIRTIO_NET_CTRL_RSS_SET=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                    =C2=A0 =C2=A02<br>
                    +\end{lstlisting}<br>
                    +<br>
                    +If the VIRTIO_NET_F_CTRL_RSS is negotiated the
                    driver can send control<br>
                    +commands for the RSS configuration.<br>
                    +<br>
                    +The class VIRTIO_NET_CTRL_RSS has three commands:<br>
                    +<br>
                    +\begin{enumerate}<br>
                    +\item VIRTIO_NET_CTRL_RSS_GET_SUPPLI<wbr>ED_FUNCTIONS
                    returns the hash functions<br>
                    +=C2=A0 =C2=A0 =C2=A0 =C2=A0supported by the device to =
the driver.<br>
                  </blockquote>
                  <br>
                </div>
              </div>
              Can we just reuse virtio_net_rss in this case, it contains
              all the informations (e.g hash key or whatever others)?</bloc=
kquote>
            <div>Sure this can work=C2=A0</div>
            <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><span class=
=3D"gmail-m_-5873866276124220634m_4174557398479348472gmail-"><br>
                <br>
                <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
                  +\item VIRTIO_NET_CTRL_RSS_DISABLE Instructs the
                  device that RSS hashing is no<br>
                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0longer required.<br>
                </blockquote>
                <br>
              </span>
              So this implies that if MQ is supported, we will go to use
              automatic steering mode? I was thinking maybe it&#39;s better
              to introduce a generic command to switch between steering
              mode.</blockquote>
            <div>=C2=A0So you are suggesting that we should have an
              additional generic command that changes between steering
              modes and RSS is one of those modes?</div>
            <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><span class=
=3D"gmail-m_-5873866276124220634m_4174557398479348472gmail-"><br>
                <br>
                <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
                  +\item VIRTIO_NET_CTRL_RSS_SET applies the new RSS
                  configuration. The command is<br>
                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0used by the driver for settin=
g RSS hash
                  function, hash key and<br>
                  +=C2=A0 =C2=A0 =C2=A0 =C2=A0indirection table in the devi=
ce.<br>
                  +\end{enumerate}<br>
                  +<br>
                  +If this feaure has been negotiated, the virtio header
                  has an additional<br>
                  +field{rss_hash_value} field attached to it.<br>
                  +<br>
                  +\devicenormative{\subparagrap<wbr>h}{RSS hash
                  offload}{Device Types / Network Device / Device
                  Operation / Control Virtqueue / RSS hash offload}<br>
                  +<br>
                  +The device MUST fill the virtio_net_ctrl_rss_hash
                  structure with the hash<br>
                  +functions it supports and return the structure to the
                  driver. Zero or more<br>
                  +flags of the RSS_HASH_FUNCTION flags MUST be used to
                  fill the \field{hash_function}<br>
                  +field.<br>
                  +<br>
                  +Upon recieving VIRTIO_NET_CTRL_DISABLE the device
                  SHOULD stop calculating and<br>
                  +attaching hashes<br>
                </blockquote>
                <br>
              </span>
              For simplicity, what if just compute the hash in this
              case? Consider a driver may want to use this hash (e.g
              Linux driver).</blockquote>
            <div>I get the use case but maybe introduce a new command
              for computing hashes only? I think the disable should be
              preserved for disabling only.</div>
            <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><span class=
=3D"gmail-m_-5873866276124220634m_4174557398479348472gmail-"><br>
                <br>
                <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
                  for the packets as well as stop setting the
                  VIRTIO_NET_HDR_GSO_RSS<br>
                  +in the \field{gso_type} field, however the
                  \field{hash_function} field is kept<br>
                  +as a part of the header.<br>
                  +<br>
                  +The device MUST drop all previous RSS configuration
                  upon receiving<br>
                  +VIRTIO_NET_CTRL_RSS_SET command.<br>
                  +<br>
                  +The device MUST set the RSS configuration according
                  to the settings provided as<br>
                  +follows, once the configuration process is completed
                  the device SHOULD apply<br>
                  +the hash function to each of the incoming packets and
                  distribute the packets<br>
                  +through the virqueues using the calculated hash and
                  the indirection table<br>
                  +that were earlier provided by the driver.<br>
                </blockquote>
                <br>
              </span>
              We support changing #queues dynamically, so need to
              clarify the behavior when e.g the destination queues were
              disabled.</blockquote>
            <div>I will go into these details in the next version.=C2=A0</d=
iv>
            <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
              <div>
                <div class=3D"gmail-m_-5873866276124220634m_417455739847934=
8472gmail-h5"><br>
                  <br>
                  <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
                    +<br>
                    +Setting RSS configuration<br>
                    +\begin{enumerate}<br>
                    +\item The driver fills all of the fields and passes
                    them through the control<br>
                    +=C2=A0 =C2=A0 =C2=A0 =C2=A0queue to the device.<br>
                    +<br>
                    +\item The device sets the RSS configuration as
                    provided by the driver.<br>
                    +<br>
                    +\item If the device successfully applied the
                    configuration, on each packet<br>
                    +=C2=A0 =C2=A0 =C2=A0 =C2=A0recieved the device MUST ca=
lculate the
                    hashing for the packet and<br>
                    +=C2=A0 =C2=A0 =C2=A0 =C2=A0store it in the virtio-net =
header in
                    rss_hash_value and the hash<br>
                    +=C2=A0 =C2=A0 =C2=A0 =C2=A0fields used in the calculat=
ion in
                    rss_hash_type.<br>
                    +\end{enumerate}<br>
                    +<br>
                    +In case of any unexpected values/ unsupported hash
                    function the driver<br>
                    +MUST return VIRTIO_NET_ERR in the \field{ack}
                    field.<br>
                    +<br>
                    +\drivernormative{\subparagrap<wbr>h}{RSS hash
                    offload}{Device Types / Network Device / Device
                    Operation / Control Virtqueue / RSS hash offload}<br>
                    +<br>
                    +If the driver negotiates the feature
                    VIRTIO_NET_F_CTRL_RSS the driver SHOULD<br>
                    +send VIRTIO_NET_CTRL_RSS_SET command to the device
                    along with the RSS structure<br>
                    +filled. The RSS structure fields should be filled
                    as follows:<br>
                    +<br>
                    +\begin{itemize}<br>
                    +\item The driver SHOULD choose the hash function
                    that SHOULD be used and fill<br>
                    +=C2=A0 =C2=A0 =C2=A0 =C2=A0it in the \field{hash_funct=
ion} field along
                    with the approperiate flags<br>
                    +=C2=A0 =C2=A0 =C2=A0 =C2=A0in the \field{hash_function=
_flags} field.
                    These flags inidicate to the<br>
                    +=C2=A0 =C2=A0 =C2=A0 =C2=A0device which packet fields =
MUST be used in
                    the calculation process of<br>
                    +=C2=A0 =C2=A0 =C2=A0 =C2=A0the hash.<br>
                    +\item Once the hash function has been chosen a
                    suitable hash key should be set<br>
                    +=C2=A0 =C2=A0 =C2=A0 =C2=A0in the \field{hash_key} fie=
ld, the length of
                    the key should be stored<br>
                    +=C2=A0 =C2=A0 =C2=A0 =C2=A0in the \field{hash_key_leng=
th} field.<br>
                    +\item Lastly the driver should fill the indirection
                    table array in the<br>
                    +=C2=A0 =C2=A0 =C2=A0 =C2=A0\field{indirection_table} f=
ield while
                    setting the array length in<br>
                    +=C2=A0 =C2=A0 =C2=A0 =C2=A0\field{indirection_table_le=
ng<wbr>th}. This
                    structure is used by the device<br>
                    +=C2=A0 =C2=A0 =C2=A0 =C2=A0for determining in which RX=
 virt queue the
                    packet should be placed.<br>
                  </blockquote>
                  <br>
                </div>
              </div>
              Is the indirection table expected to be changed
              frequently? If yes, a single entry modification will cause
              a update of the whole table.</blockquote>
            <div>No, it should not be changing frequently</div>
          </div>
        </div>
      </div>
    </blockquote>
    <blockquote type=3D"cite">
      <div dir=3D"ltr">
        <div class=3D"gmail_extra">
          <div class=3D"gmail_quote">
            <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><span class=
=3D"gmail-m_-5873866276124220634m_4174557398479348472gmail-"><br>
                <br>
                <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
                  +\end{itemize}<br>
                  +Once the configuration phase is over successfully,
                  the packets SHOULD have the<br>
                  +\field{rss_hash_value} field with the hash value that
                  was calculated by the<br>
                  +device.<br>
                  +<br>
                  +Whenever the driver wants to discard the current RSS
                  settings, it can send an<br>
                  +VIRTIO_NET_CTRL_RSS_SET command along with rss
                  structure that has<br>
                  +RSS_HASH_FUNCTION_NONE the \field{hash_function}
                  field.<br>
                </blockquote>
                <br>
              </span>
              So this function looks equivalent to
              VIRTIO_NET_CTRL_RSS_DISABLE?<br>
            </blockquote>
            <div>Yes, do you think we should discard one of the two?</div>
            <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
              <br>
              Thanks
              <div class=3D"gmail-m_-5873866276124220634m_41745573984793484=
72gmail-HOEnZb">
                <div class=3D"gmail-m_-5873866276124220634m_417455739847934=
8472gmail-h5"><br>
                  <br>
                  <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
                    +<br>
                    +The driver MUST check the \field{ack} field value
                    provided by the device, in<br>
                    +case the value is not VIRTIO_NET_OK then the driver
                    MUST hanlde faliure and<br>
                    +retry another hash function or else give up.<br>
                    +<br>
                    =C2=A0 \subparagraph{Legacy Interface: Automatic receiv=
e
                    steering in multiqueue mode}\label{sec:Device Types
                    / Network Device / Device Operation / Control
                    Virtqueue / Automatic receive steering in multiqueue
                    mode / Legacy Interface: Automatic receive steering
                    in multiqueue mode}<br>
                    =C2=A0 When using the legacy interface, transitional
                    devices and drivers<br>
                    =C2=A0 MUST format \field{virtqueue_pairs}<br>
                  </blockquote>
                  <br>
                </div>
              </div>
            </blockquote>
          </div>
          <br>
          <br clear=3D"all">
          <div><br>
          </div>
          -- <br>
          <div class=3D"gmail-m_-5873866276124220634m_4174557398479348472gm=
ail_signature">
            <div dir=3D"ltr">
              <div>
                <div dir=3D"ltr">
                  <div>
                    <div dir=3D"ltr">
                      <div>
                        <div dir=3D"ltr"><font size=3D"4" face=3D"times new
                            roman, serif" color=3D"#0b5394">Respectfully,<b=
r>
                          </font>
                          <div style=3D"font-size:12.8px;color:rgb(136,136,=
136)"><font size=3D"4" face=3D"times new roman, serif" color=3D"#0b5394"><b=
><i>Sameeh Jubran</i></b></font></div>
                          <div style=3D"font-size:12.8px;color:rgb(136,136,=
136)"><i><span style=3D"line-height:15px"><a href=3D"https://il.linkedin.co=
m/pub/sameeh-jubran/87/747/a8a" title=3D"View public profile" name=3D"m_-58=
73866276124220634_m_4174557398479348472_UNIQUE_ID_SafeHtmlFilter_UNIQUE_ID_=
SafeHtmlFilter_UNIQUE_ID_SafeHtmlFilter_UNIQUE_ID_SafeHtmlFilter_UNIQUE_ID_=
SafeHtmlFilter_14e2c1de96f8c195_UNIQUE_ID_SafeHtmlFilter_SafeHtmlFilter_Saf=
eHtmlFilter_webProfileURL" style=3D"color:rgb(17,85,204);margin:0px;padding=
:0px;border-width:0px;outline:none;vertical-align:baseline;text-decoration:=
none" target=3D"_blank">Linkedin</a></span></i><br>
                          </div>
                          <div style=3D"font-size:12.8px;color:rgb(136,136,=
136)"><font size=3D"4" face=3D"times new roman, serif" color=3D"#073763"><i=
>Software Engineer @ <a href=3D"http://www.daynix.com" target=3D"_blank">Da=
ynix</a>.</i></font></div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
  </div></div></div>

</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div class=
=3D"gmail-m_-5873866276124220634gmail_signature"><div dir=3D"ltr"><div><div=
 dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr"><font size=3D"4" c=
olor=3D"#0b5394" face=3D"times new roman, serif">Respectfully,<br></font><d=
iv style=3D"font-size:12.8px;color:rgb(136,136,136)"><font size=3D"4" color=
=3D"#0b5394" face=3D"times new roman, serif"><b><i>Sameeh Jubran</i></b></f=
ont></div><div style=3D"font-size:12.8px;color:rgb(136,136,136)"><i style=
=3D"color:rgb(7,55,99);font-family:&quot;times new roman&quot;,serif;font-s=
ize:large"><span style=3D"line-height:15px"><a href=3D"https://il.linkedin.=
com/pub/sameeh-jubran/87/747/a8a" title=3D"View public profile" name=3D"m_-=
5873866276124220634_UNIQUE_ID_SafeHtmlFilter_UNIQUE_ID_SafeHtmlFilter_UNIQU=
E_ID_SafeHtmlFilter_UNIQUE_ID_SafeHtmlFilter_UNIQUE_ID_SafeHtmlFilter_14e2c=
1de96f8c195_UNIQUE_ID_SafeHtmlFilter_SafeHtmlFilter_SafeHtmlFilter_webProfi=
leURL" style=3D"color:rgb(17,85,204);margin:0px;padding:0px;border-width:0p=
x;outline:none;vertical-align:baseline;text-decoration:none" target=3D"_bla=
nk">Linkedin</a></span></i><br></div><div style=3D"font-size:12.8px;color:r=
gb(136,136,136)"><font size=3D"4" face=3D"times new roman, serif" color=3D"=
#073763"><i>Software Engineer @ <a href=3D"http://www.daynix.com" target=3D=
"_blank">Daynix</a>.</i></font></div></div></div></div></div></div></div></=
div></div>
</div></div>

--001a11448e5424cb070567d3d366--

