Return-Path: <hengqi@linux.alibaba.com>
Message-ID: <cab3efd6-40b1-afef-38a7-cd24feb5a940@linux.alibaba.com>
Date: Fri, 23 Dec 2022 13:25:37 +0800
MIME-Version: 1.0
Subject: Re: [virtio-dev] Re: [PATCH v4] virtio_net: support inner header hash
References: <20221221103909.127529-1-hengqi@linux.alibaba.com>
 <874jtnbfuj.fsf@redhat.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <874jtnbfuj.fsf@redhat.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Cornelia Huck <cohuck@redhat.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>



在 2022/12/22 下午11:47, Cornelia Huck 写道:
> On Wed, Dec 21 2022, Heng Qi <hengqi@linux.alibaba.com> wrote:
>
>> If the tunnel is used to encapsulate the packets, the hash calculated
>> using the outer header of the receive packets is always fixed for the
>> same flow packets, i.e. they will be steered to the same receive queue.
>>
>> We add a tunnel feature bit VIRTIO_NET_F_HASH_TUNNEL and related bitmasks
>> in \field{hash_types}, which instructs the device to calculate the
>> hash using the inner headers of tunnel-encapsulated packets. Besides,
>> values in \field{hash_report_tunnel} are added to report tunnel types.
>>
>> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
>> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>> ---
>> v3:
>> 	1. Rename VIRTIO_NET_F_HASH_GRE_VXLAN_GENEVE_INNER to VIRTIO_NET_F_HASH_TUNNEL. @Jason Wang
>> 	2. Make things clearer. @Jason Wang @Michael S. Tsirkin
>> 	3. Keep the possibility to use inner hash for automatic receive steering. @Jason Wang
>> 	4. Add the "Tunnel packet" paragraph to avoid repeating the GRE etc. many times. @Michael S. Tsirkin
>>
>> v2:
>> 	1. Add a feature bit for GRE/VXLAN/GENEVE inner hash. @Jason Wang
>> 	2. Chang \field{hash_tunnel} to \field{hash_report_tunnel}. @Jason Wang, @Michael S. Tsirkin
>>
>> v1:
>> 	1. Remove the patch for the bitmask fix. @Michael S. Tsirkin
>> 	2. Clarify some paragraphs. @Jason Wang
>> 	3. Add \field{hash_tunnel} and VIRTIO_NET_HASH_REPORT_GRE. @Yuri Benditovich
>>
>>   content.tex | 198 ++++++++++++++++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 191 insertions(+), 7 deletions(-)
>>
>> diff --git a/content.tex b/content.tex
>> index e863709..dac21f1 100644
>> --- a/content.tex
>> +++ b/content.tex
>> @@ -3084,6 +3084,9 @@ \subsection{Feature bits}\label{sec:Device Types / Network Device / Feature bits
>>   \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through control
>>       channel.
>>   
>> +\item[VIRTIO_NET_F_HASH_TUNNEL(52)] Device supports inner
>> +    header hash for GRE, VXLAN and GENEVE-encapsulated packets.
>> +
>>   \item[VIRTIO_NET_F_NOTF_COAL(53)] Device supports notifications coalescing.
>>   
>>   \item[VIRTIO_NET_F_GUEST_USO4 (54)] Driver can receive USOv4 packets.
>> @@ -3095,7 +3098,8 @@ \subsection{Feature bits}\label{sec:Device Types / Network Device / Feature bits
>>    to several segments when each of these smaller packets has UDP header.
>>   
>>   \item[VIRTIO_NET_F_HASH_REPORT(57)] Device can report per-packet hash
>> -    value and a type of calculated hash.
>> +    value, a type of calculated hash and a tunnel packet type if
>> +    VIRTIO_NET_F_HASH_TUNNEL is negotiated.
> This might be mildly confusing -- maybe make this
>
> "Device can report per-packet hash value, a type of calculated hash,
> and, if VIRTIO_NET_F_HASH_TUNNEL is negotiated, a tunnel packet type."
>
> ?

Ok, I'll edit.

>
>>   
>>   \item[VIRTIO_NET_F_GUEST_HDRLEN(59)] Driver can provide the exact \field{hdr_len}
>>       value. Device benefits from knowing the exact header length.
>> @@ -3140,6 +3144,7 @@ \subsubsection{Feature bit requirements}\label{sec:Device Types / Network Device
>>   \item[VIRTIO_NET_F_NOTF_COAL] Requires VIRTIO_NET_F_CTRL_VQ.
>>   \item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_F_HOST_TSO4 or VIRTIO_NET_F_HOST_TSO6.
>>   \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
>> +\item[VIRTIO_NET_F_HASH_TUNNEL] Requires VIRTIO_NET_F_CTRL_VQ.
>>   \end{description}
>>   
>>   \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types / Network Device / Feature bits / Legacy Interface: Feature bits}
>> @@ -3386,7 +3391,8 @@ \subsection{Device Operation}\label{sec:Device Types / Network Device / Device O
>>           le16 num_buffers;
>>           le32 hash_value;        (Only if VIRTIO_NET_F_HASH_REPORT negotiated)
>>           le16 hash_report;       (Only if VIRTIO_NET_F_HASH_REPORT negotiated)
>> -        le16 padding_reserved;  (Only if VIRTIO_NET_F_HASH_REPORT negotiated)
>> +        le8 hash_report_tunnel; (Only if both VIRTIO_NET_F_HASH_REPORT and VIRTIO_NET_F_HASH_TUNNEL are negotiated)
>> +        le8 padding_reserved;   (Only if VIRTIO_NET_F_HASH_REPORT negotiated)
> We still have the same length of the header without F_HASH_TUNNEL, I
> think? So hash_report_tunnel would be "Only if VIRTIO_NET_F_HASH_REPORT
> negotiated, only valid of VIRTIO_NET_F_HASH_TUNNEL negotiated" (or a
> better wording...)

Yes, you are right, I will edit.

>
> Also, there's no le8, just plain u8 :)

Thanks for reminding.

>
>>   };
>>   \end{lstlisting}
>>   
>> @@ -3837,7 +3843,8 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
>>   A device attempts to calculate a per-packet hash in the following cases:
>>   \begin{itemize}
>>   \item The feature VIRTIO_NET_F_RSS was negotiated. The device uses the hash to determine the receive virtqueue to place incoming packets.
>> -\item The feature VIRTIO_NET_F_HASH_REPORT was negotiated. The device reports the hash value and the hash type with the packet.
>> +\item The feature VIRTIO_NET_F_HASH_REPORT was negotiated. The device reports the hash value and the hash type. The tunnel type can only
>> +be reported when both VIRTIO_NET_F_HASH_REPORT and VIRTIO_NET_F_HASH_TUNNEL are negotiated.
> Maybe "If additionally VIRTIO_NET_F_HASH_TUNNEL was negotiated, the
> device reports the tunnel type as well." ?

Ok, I will describe it clearly in the next version.

Thanks.

>
>>   \end{itemize}
>>   
>>   If the feature VIRTIO_NET_F_RSS was negotiated:
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

