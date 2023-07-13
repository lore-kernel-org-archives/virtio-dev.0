Return-Path: <virtio-dev-return-13379-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABB8FC001DC
	for <virtio-dev@archiver.kernel.org>; Thu, 13 Jul 2023 11:59:07 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id F31792A891
	for <virtio-dev@archiver.kernel.org>; Thu, 13 Jul 2023 11:59:06 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DDE019867C6
	for <virtio-dev@archiver.kernel.org>; Thu, 13 Jul 2023 11:59:06 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id CC1CE9867C3; Thu, 13 Jul 2023 11:59:06 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B5E489867C2;
	Thu, 13 Jul 2023 11:59:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R831e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VnHh5rG_1689249537;
Message-ID: <e8222b54-9229-a9e7-6d34-8a47791228d8@linux.alibaba.com>
Date: Thu, 13 Jul 2023 19:58:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
To: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>, virtio-comment@lists.oasis-open.org,
 virtio-dev@lists.oasis-open.org, shahafs@nvidia.com
References: <20230712222405.455201-1-parav@nvidia.com>
 <87zg40qioi.fsf@redhat.com> <20230713073051-mutt-send-email-mst@kernel.org>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20230713073051-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [PATCH 0/4] Short document fixes to inner hash feature



在 2023/7/13 下午7:33, Michael S. Tsirkin 写道:
> On Thu, Jul 13, 2023 at 11:12:13AM +0200, Cornelia Huck wrote:
>> On Thu, Jul 13 2023, Parav Pandit <parav@nvidia.com> wrote:
>>
>>> This short patches fixes the editing errors that stops the pdf and html
>>> generation.
>>>
>>> These 3 fixes are for the patch [1] for the github issue [2].
>>>
>>> [1] https://lists.oasis-open.org/archives/virtio-comment/202307/msg00024.html
>>> [2] https://github.com/oasis-tcs/virtio-spec/issues/173
>>>
>>> Patch summary:
>>> patch-1 place C code under listing
>>> patch-2 avoid hyphen and extra braces
>>> patch-3 use table as hyperlink do not work well in C code listing
>>> patch-4 refer 'advice' as 'note'
>>>
>>> Patch 1 to 3 appears to be must in the testing.
>>> Patch 4 is not a fix and can be done later if it requires discussion.
>>>
>>> Parav Pandit (4):
>>>    virtio-net: Place C code under listing
>>>    virtio-net: Avoid hyphen and extra braces
>>>    virtio-net: Use table to describe inner hash to rfc mapping
>>>    virtio-net: Use note instead of advice
>>>
>>>   device-types/net/description.tex | 45 ++++++++++++++++++++++----------
>>>   introduction.tex                 | 15 +++++------
>>>   2 files changed, 38 insertions(+), 22 deletions(-)
>>>
>> FTR, this is the diff I have locally (I had missed one underscore in the
>> references yesterday...); maybe we can make the intra-reference links in
>> introdcution.tex a bit nicer, but otherwise, this should be the minimal
>> change to make this build:
> Perfect. Seems like clearly an editorial fix.
>
> Heng Qi, in the future I'd like to ask you to please build the
> spec and review the resulting PDF and HTML, before posting.

Yes, I will!

>
>
>
>> diff --git a/device-types/net/description.tex b/device-types/net/description.tex
>> index 206020de567d..76585b0dd6d3 100644
>> --- a/device-types/net/description.tex
>> +++ b/device-types/net/description.tex
>> @@ -1024,12 +1024,14 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
>>   If VIRTIO_NET_F_HASH_TUNNEL has been negotiated, the driver can send the command
>>   VIRTIO_NET_CTRL_HASH_TUNNEL_SET to configure the calculation of the inner header hash.
>>   
>> +\begin{lstlisting}
>>   struct virtnet_hash_tunnel {
>>       le32 enabled_tunnel_types;
>>   };
>>   
>>   #define VIRTIO_NET_CTRL_HASH_TUNNEL 7
>>    #define VIRTIO_NET_CTRL_HASH_TUNNEL_SET 0
>> +\end{lstlisting}
>>   
>>   Field \field{enabled_tunnel_types} contains the bitmask of encapsulation types enabled for inner header hash.
>>   See \ref{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets /
>> @@ -1063,16 +1065,16 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
>>   Hash calculation for incoming packets / Encapsulation types supported/enabled for inner header hash}
>>   
>>   Encapsulation types applicable for inner header hash:
>> -\begin{lstlisting}
>> -#define VIRTIO_NET_HASH_TUNNEL_TYPE_GRE_2784    (1 << 0) /* \hyperref[intro:gre_rfc2784]{[GRE_rfc2784]} */
>> -#define VIRTIO_NET_HASH_TUNNEL_TYPE_GRE_2890    (1 << 1) /* \hyperref[intro:gre_rfc2890]{[GRE_rfc2890]} */
>> -#define VIRTIO_NET_HASH_TUNNEL_TYPE_GRE_7676    (1 << 2) /* \hyperref[intro:gre_rfc7676]{[GRE_rfc7676]} */
>> -#define VIRTIO_NET_HASH_TUNNEL_TYPE_GRE_UDP     (1 << 3) /* \hyperref[intro:gre_in_udp_rfc8086]{[GRE-in-UDP]} */
>> -#define VIRTIO_NET_HASH_TUNNEL_TYPE_VXLAN       (1 << 4) /* \hyperref[intro:vxlan]{[VXLAN]} */
>> -#define VIRTIO_NET_HASH_TUNNEL_TYPE_VXLAN_GPE   (1 << 5) /* \hyperref[intro:vxlan_gpe]{[VXLAN-GPE]} */
>> -#define VIRTIO_NET_HASH_TUNNEL_TYPE_GENEVE      (1 << 6) /* \hyperref[intro:geneve]{[GENEVE]} */
>> -#define VIRTIO_NET_HASH_TUNNEL_TYPE_IPIP        (1 << 7) /* \hyperref[intro:ipip]{[IPIP]} */
>> -#define VIRTIO_NET_HASH_TUNNEL_TYPE_NVGRE       (1 << 8) /* \hyperref[intro:nvgre]{[NVGRE]} */
>> +\begin{lstlisting}[escapechar=|]
>> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_GRE_2784    (1 << 0) /* |\hyperref[intro:rfc2784]{[RFC2784]}| */
>> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_GRE_2890    (1 << 1) /* |\hyperref[intro:rfc2890]{[RFC2890]}| */
>> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_GRE_7676    (1 << 2) /* |\hyperref[intro:rfc7676]{[RFC7676]}| */
>> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_GRE_UDP     (1 << 3) /* |\hyperref[intro:rfc8086]{[GRE-in-UDP]}| */
>> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_VXLAN       (1 << 4) /* |\hyperref[intro:vxlan]{[VXLAN]}| */
>> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_VXLAN_GPE   (1 << 5) /* |\hyperref[intro:vxlan-gpe]{[VXLAN-GPE]}| */
>> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_GENEVE      (1 << 6) /* |\hyperref[intro:geneve]{[GENEVE]}| */
>> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_IPIP        (1 << 7) /* |\hyperref[intro:ipip]{[IPIP]}| */
>> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_NVGRE       (1 << 8) /* |\hyperref[intro:nvgre]{[NVGRE]}| */
>>   \end{lstlisting}
>>   
>>   \subparagraph{Advice}
>> diff --git a/introduction.tex b/introduction.tex
>> index 81f07a4fee19..6f10a94b6fde 100644
>> --- a/introduction.tex
>> +++ b/introduction.tex
>> @@ -102,18 +102,18 @@ \section{Normative References}\label{sec:Normative References}
>>       Standards for Efficient Cryptography Group(SECG), ``SEC1: Elliptic Cureve Cryptography'', Version 1.0, September 2000.
>>   	\newline\url{https://www.secg.org/sec1-v2.pdf}\\
>>   
>> -	\phantomsection\label{intro:gre_rfc2784}\textbf{[GRE_rfc2784]} &
>> +	\phantomsection\label{intro:rfc2784}\textbf{[RFC2784]} &
>>       Generic Routing Encapsulation. This protocol is only specified for IPv4 and used as either the payload or delivery protocol.
>>   	\newline\url{https://datatracker.ietf.org/doc/rfc2784/}\\
>> -	\phantomsection\label{intro:gre_rfc2890}\textbf{[GRE_rfc2890]} &
>> -    Key and Sequence Number Extensions to GRE \ref{intro:gre_rfc2784}. This protocol describes extensions by which two fields, Key and
>> -    Sequence Number, can be optionally carried in the GRE Header \ref{intro:gre_rfc2784}.
>> +	\phantomsection\label{intro:rfc2890}\textbf{[RFC2890]} &
>> +    Key and Sequence Number Extensions to GRE \ref{intro:rfc2784}. This protocol describes extensions by which two fields, Key and
>> +    Sequence Number, can be optionally carried in the GRE Header \ref{intro:rfc2784}.
>>   	\newline\url{https://www.rfc-editor.org/rfc/rfc2890}\\
>> -	\phantomsection\label{intro:gre_rfc7676}\textbf{[GRE_rfc7676]} &
>> +	\phantomsection\label{intro:rfc7676}\textbf{[RFC7676]} &
>>       IPv6 Support for Generic Routing Encapsulation (GRE). This protocol is specified for IPv6 and used as either the payload or
>>       delivery protocol. Note that this does not change the GRE header format or any behaviors specified by RFC 2784 or RFC 2890.
>>   	\newline\url{https://datatracker.ietf.org/doc/rfc7676/}\\
>> -	\phantomsection\label{intro:gre_in_udp_rfc8086}\textbf{[GRE-in-UDP]} &
>> +	\phantomsection\label{intro:rfc8086}\textbf{[GRE-in-UDP]} &
>>       GRE-in-UDP Encapsulation. This specifies a method of encapsulating network protocol packets within GRE and UDP headers.
>>       This protocol is specified for IPv4 and IPv6, and used as either the payload or delivery protocol.
>>   	\newline\url{https://www.rfc-editor.org/rfc/rfc8086}\\


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

