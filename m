Return-Path: <virtio-dev-return-11766-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37B31C6FD1C
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Mar 2023 03:21:43 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 65CBA2AD45
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Mar 2023 03:21:42 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 610D898648B
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Mar 2023 03:21:42 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 53FFB98644A; Fri, 24 Mar 2023 03:21:42 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3A73598638E;
	Fri, 24 Mar 2023 03:21:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R831e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0VeW0yP1_1679628091;
Message-ID: <1679627322.2273903-1-xuanzhuo@linux.alibaba.com>
Date: Fri, 24 Mar 2023 11:08:42 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: virtio-comment@lists.oasis-open.org,
 hans@linux.alibaba.com,
 herongguang@linux.alibaba.com,
 zmlcc@linux.alibaba.com,
 dust.li@linux.alibaba.com,
 tonylu@linux.alibaba.com,
 zhenzao@linux.alibaba.com,
 helinguo@linux.alibaba.com,
 gerry@linux.alibaba.com,
 mst@redhat.com,
 cohuck@redhat.com,
 jasowang@redhat.com,
 Jan Kiszka <jan.kiszka@siemens.com>,
 wintera@linux.ibm.com,
 kgraul@linux.ibm.com,
 wenjia@linux.ibm.com,
 jaka@linux.ibm.com,
 hca@linux.ibm.com,
 twinkler@linux.ibm.com,
 raspl@linux.ibm.com,
 virtio-dev@lists.oasis-open.org,
 Halil Pasic <pasic@linux.ibm.com>, Wen Gu <guwen@linux.alibaba.com>
References: <20230209033056.96657-1-xuanzhuo@linux.alibaba.com>
 <20230209033056.96657-2-xuanzhuo@linux.alibaba.com>
 <20230323154656.7f036d52.pasic@linux.ibm.com>
In-Reply-To: <20230323154656.7f036d52.pasic@linux.ibm.com>
Subject: [virtio-dev] Re: [virtio-comment] [PATCH v3 1/1] virtio-ism: introduce new device virtio-ism

On Thu, 23 Mar 2023 15:46:56 +0100, Halil Pasic <pasic@linux.ibm.com> wrote:
> On Thu,  9 Feb 2023 11:30:56 +0800
> Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>
> > +\subsection{Device configuration layout}\label{sec:Device Types / ISM Device / Device configuration layout}
> > +
> > +\begin{lstlisting}
> > +struct virtio_ism_config {
> > +	le128 cdid;
> > +	le64 devid;
> > +	le64 chunk_size;
> > +	le64 notify_size;
> > +};
> > +\end{lstlisting}
> > +
> > +\begin{description}
> > +    \item[\field{cdid}] This is used to identify the communication domain. Only
> > +        ism devices with the same \field{cdid} can communicate. A \field{cdid}
> > +        is world-wide unique in a sense that there not be another communication
> > +        domain with the same \field{cdid}.
> > +
> > +    \item[\field{devid}] This is used to identify the ism device in the single
> > +        communication domain.
> > +
> > +    \item[\field{chunk_size}] This is the size of the ism chunk. The device
> > +        memory is divided into multiple chunks. Every ism chunk has the same
> > +        size.
> > +
> > +    \item[\field{notify_size}] This is the size of the ism notify-address. The
> > +        notify-address is used to notify the device that the content of the
> > +        ism region has been updated.
> > +
> > +\end{description}
> > +
> > +\devicenormative{\subsubsection}{Device configuration layout}{Device Types / ISM Device / Device configuration layout}
> > +
> > +The device MUST ensure that the \field{cdid} of the device on the same
> > +communication domain is same. The \field{cdid} MUST be a version 4 UUID as
> > +specified by \hyperref[intro:rfc4122]{[RFC4122]}.
> > +
> > +In the single communication domain, the device MUST ensure that the \field{devid}
> > +is unique.
> > +
>
>
> Hi Xuan Zhou!
>
> My understanding is the following: you goal for virtio-ism is that
> it should be suitable for usage with SMC-D (much like the original ISM
> device). Is that right?

Yes, in our interior, it is indeed working with SMC. But on the other
hand, I also hope to provide a way to share memory between VMs. You can see that
our POC provides the examples that users can use the sharing memory directly.

>
> If yes, then let us have a look at the following example. We have
> two guests sitting on the same hypervisor: A and B. Both of the
> guests have an rdma capable interface, a virtio-ism device and
> traditional ISM device. So they could talk over SMC-R, SMC-D via
> virtio and SMC-D via (PCI-)ISM. How would the CLC Proposal message
> look like?

Not only these, but also SMC-Loopback. I know Wen is promoting this aspect. I
think this is not a problem of virtio-ism. SMC may have to be renovated
together.


>
> Where I am going with this? Either you need a novel way to
> discover peers (probably before the usual way is employed)
> or (probably preferably) you need to make this part of the
> CLC stuff. What are your ideas with regards to this? How is
> it supposed to work?
>
> To get back to the things proposed here: the cdid is IMHO
> a nice thing, and is functionally corresponding to the
> (S)EID. But it is 16 byte wide, and I have no idea how
> is it supposed to be used in the CLC handshake.

This is indeed the biggest problem for Virtio-ISM + SMC, but I think Wen can
solve it. Of course, other SMC experts are discussed together, how to compatible
or support virtio-exm and smc-loopback.

>
> If this is really supposed to work with SMC and not just take
> inspiration from it,

As I said above, we are not just working with SMC. I also hope that
users can use these shared memory directly. So this is also an independent
memory sharing mechanism without smc.

> I would like some insight from our
> SMC experts (they are already on copy).

Yes. I also want to hear more reply.

Thanks.



>
> Regards,
> Halil

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

