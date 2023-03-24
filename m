Return-Path: <virtio-dev-return-11767-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8971DC6FD20
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Mar 2023 04:03:37 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id BA4892B019
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Mar 2023 04:03:36 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9AB15986485
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Mar 2023 04:03:36 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 7DA2A98642D; Fri, 24 Mar 2023 04:03:36 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 67A8C98638E;
	Fri, 24 Mar 2023 04:03:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0VeWG3Qn_1679630607;
Message-ID: <ff9b28a1-e0ee-f082-1f40-f3e149c9403e@linux.alibaba.com>
Date: Fri, 24 Mar 2023 12:03:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
To: Halil Pasic <pasic@linux.ibm.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtio-comment@lists.oasis-open.org, hans@linux.alibaba.com,
 herongguang@linux.alibaba.com, zmlcc@linux.alibaba.com,
 dust.li@linux.alibaba.com, tonylu@linux.alibaba.com,
 zhenzao@linux.alibaba.com, helinguo@linux.alibaba.com,
 gerry@linux.alibaba.com, mst@redhat.com, cohuck@redhat.com,
 jasowang@redhat.com, Jan Kiszka <jan.kiszka@siemens.com>,
 wintera@linux.ibm.com, kgraul@linux.ibm.com, wenjia@linux.ibm.com,
 jaka@linux.ibm.com, hca@linux.ibm.com, twinkler@linux.ibm.com,
 raspl@linux.ibm.com, virtio-dev@lists.oasis-open.org, guwen@linux.alibaba.com
References: <20230209033056.96657-1-xuanzhuo@linux.alibaba.com>
 <20230209033056.96657-2-xuanzhuo@linux.alibaba.com>
 <20230323154656.7f036d52.pasic@linux.ibm.com>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <20230323154656.7f036d52.pasic@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-dev] Re: [virtio-comment] [PATCH v3 1/1] virtio-ism:
 introduce new device virtio-ism



On 2023/3/23 22:46, Halil Pasic wrote:

> On Thu,  9 Feb 2023 11:30:56 +0800
> Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> 
>> +\subsection{Device configuration layout}\label{sec:Device Types / ISM Device / Device configuration layout}
>> +
>> +\begin{lstlisting}
>> +struct virtio_ism_config {
>> +	le128 cdid;
>> +	le64 devid;
>> +	le64 chunk_size;
>> +	le64 notify_size;
>> +};
>> +\end{lstlisting}
>> +
>> +\begin{description}
>> +    \item[\field{cdid}] This is used to identify the communication domain. Only
>> +        ism devices with the same \field{cdid} can communicate. A \field{cdid}
>> +        is world-wide unique in a sense that there not be another communication
>> +        domain with the same \field{cdid}.
>> +
>> +    \item[\field{devid}] This is used to identify the ism device in the single
>> +        communication domain.
>> +
>> +    \item[\field{chunk_size}] This is the size of the ism chunk. The device
>> +        memory is divided into multiple chunks. Every ism chunk has the same
>> +        size.
>> +
>> +    \item[\field{notify_size}] This is the size of the ism notify-address. The
>> +        notify-address is used to notify the device that the content of the
>> +        ism region has been updated.
>> +
>> +\end{description}
>> +
>> +\devicenormative{\subsubsection}{Device configuration layout}{Device Types / ISM Device / Device configuration layout}
>> +
>> +The device MUST ensure that the \field{cdid} of the device on the same
>> +communication domain is same. The \field{cdid} MUST be a version 4 UUID as
>> +specified by \hyperref[intro:rfc4122]{[RFC4122]}.
>> +
>> +In the single communication domain, the device MUST ensure that the \field{devid}
>> +is unique.
>> +
> 
> 
> Hi Xuan Zhou!
> 
> My understanding is the following: you goal for virtio-ism is that
> it should be suitable for usage with SMC-D (much like the original ISM
> device). Is that right?
> 
> If yes, then let us have a look at the following example. We have
> two guests sitting on the same hypervisor: A and B. Both of the
> guests have an rdma capable interface, a virtio-ism device and
> traditional ISM device. So they could talk over SMC-R, SMC-D via
> virtio and SMC-D via (PCI-)ISM. How would the CLC Proposal message
> look like?
> 

Hi Halil!

Now SMCv2 protocol allows CLC Proposal message to carry 1 SMC-R
GID, 1 SMC-Rv2 GID, and up to 8 SMC-D [CHID,GID] at the same time
for server to choose from.

And after receiving CLC Proposal message, server will match the local
devices with devices provided in CLC Proposal messages in this order:

SMC-Dv2 (ISMv2) device -> SMC-Dv1 (ISMv1) device -> SMC-Rv2 (RoCEv2) device -> SMC-Rv1 (RoCE) device

If there are multiple SMC-Dv2 devices provided in CLC Proposal messages,
such as virtio-ism and ISM in this example, the priority depends on their
order in the slot. (we treat virtio-ism as a kind of SMC-Dv2 device)

> Where I am going with this? Either you need a novel way to
> discover peers (probably before the usual way is employed)
> or (probably preferably) you need to make this part of the
> CLC stuff. What are your ideas with regards to this? How is
> it supposed to work?
> 

The discussion about
1) how to distinguish SMC-D device type (loopback/virtio-ism/ISM)
2) how to make sure peer virtio-ism can talk to
3) how to define priority or preference of SMC-D devices
are on-going in the mail thread of meeting note: "SMC interlock | Alibaba - IBM | 2023-03-20"

A quich summary here:

1) we propose to use reserved CHID to indicate what kind of device it is.
    such as 0xFFFF for loopback, 0xFFFE for virtio-ism.

2) whether two peer's SMC-D device can talk depends on:
    a. whether VCHID is the same;
    b. whether smc_ism_cantalk() return true;
    c. whether SEID is the same;

    In step b, smc_ism_cantalk() will simply call driver interface of
    ops->query_remote_gid() to tell. So as you can see, GID is the key
    point to check whether peers' SMC-D device can talk.

    And cdid here in virtio-ism determines whether talk is possible.
    Same cdid means two virtio-ism can talk to each other.

    So the problem may be how to covert 128-bits cdid to 64-bits GID
    used by SMC-D and avoid GID collision ? I have no elegant idea
    only a workaround right now ... The discussion on GID collision
    is now on-going in mail thread of meeting note: "SMC interlock | Alibaba - IBM | 2023-03-20".
    If you have any comments about this, very welcome to discuss there.

3) Priority or preference of SMC-D devices are decided by slot
    order now, or explicitly by CHID if we all agree to use reserved
    CHID for extension SMC-D device. (haven't been comfirmed now)

> To get back to the things proposed here: the cdid is IMHO
> a nice thing, and is functionally corresponding to the
> (S)EID. But it is 16 byte wide, and I have no idea how
> is it supposed to be used in the CLC handshake.
> 

CLC handshake carry one SEID for all the SMC-D device. Considering
coexistence with ISM, I am not sure whether we can change or increase
the SEID.. cc Alexandra

Thanks!
Wen Gu

> If this is really supposed to work with SMC and not just take
> inspiration from it, I would like some insight from our
> SMC experts (they are already on copy).
> 
> Regards,
> Halil
> 
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

