Return-Path: <virtio-dev-return-11750-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4774AC6FD1C
	for <virtio-dev@archiver.kernel.org>; Thu, 23 Mar 2023 14:50:26 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C1C9A97B05
	for <virtio-dev@archiver.kernel.org>; Thu, 23 Mar 2023 14:50:23 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 358CC98645C
	for <virtio-dev@archiver.kernel.org>; Thu, 23 Mar 2023 14:50:23 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 902B7986456; Thu, 23 Mar 2023 14:50:22 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 127B2986455;
	Thu, 23 Mar 2023 14:49:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
Date: Thu, 23 Mar 2023 15:46:56 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtio-comment@lists.oasis-open.org, hans@linux.alibaba.com,
        herongguang@linux.alibaba.com, zmlcc@linux.alibaba.com,
        dust.li@linux.alibaba.com, tonylu@linux.alibaba.com,
        zhenzao@linux.alibaba.com, helinguo@linux.alibaba.com,
        gerry@linux.alibaba.com, mst@redhat.com, cohuck@redhat.com,
        jasowang@redhat.com, Jan Kiszka <jan.kiszka@siemens.com>,
        wintera@linux.ibm.com, kgraul@linux.ibm.com, wenjia@linux.ibm.com,
        jaka@linux.ibm.com, hca@linux.ibm.com, twinkler@linux.ibm.com,
        raspl@linux.ibm.com, virtio-dev@lists.oasis-open.org,
        Halil Pasic
 <pasic@linux.ibm.com>
Message-ID: <20230323154656.7f036d52.pasic@linux.ibm.com>
In-Reply-To: <20230209033056.96657-2-xuanzhuo@linux.alibaba.com>
References: <20230209033056.96657-1-xuanzhuo@linux.alibaba.com>
	<20230209033056.96657-2-xuanzhuo@linux.alibaba.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5pNF-H-UZh-t8cGbO2uA7pOVsWKVGsL8
X-Proofpoint-ORIG-GUID: kHA2SVJvqmbF9vfEoxBN2slV1DrT-dbq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_21,2023-03-23_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 impostorscore=0 clxscore=1011 mlxscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303230109
Subject: [virtio-dev] Re: [virtio-comment] [PATCH v3 1/1] virtio-ism: introduce new
 device virtio-ism

On Thu,  9 Feb 2023 11:30:56 +0800
Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:

> +\subsection{Device configuration layout}\label{sec:Device Types / ISM Device / Device configuration layout}
> +
> +\begin{lstlisting}
> +struct virtio_ism_config {
> +	le128 cdid;
> +	le64 devid;
> +	le64 chunk_size;
> +	le64 notify_size;
> +};
> +\end{lstlisting}
> +
> +\begin{description}
> +    \item[\field{cdid}] This is used to identify the communication domain. Only
> +        ism devices with the same \field{cdid} can communicate. A \field{cdid}
> +        is world-wide unique in a sense that there not be another communication
> +        domain with the same \field{cdid}.
> +
> +    \item[\field{devid}] This is used to identify the ism device in the single
> +        communication domain.
> +
> +    \item[\field{chunk_size}] This is the size of the ism chunk. The device
> +        memory is divided into multiple chunks. Every ism chunk has the same
> +        size.
> +
> +    \item[\field{notify_size}] This is the size of the ism notify-address. The
> +        notify-address is used to notify the device that the content of the
> +        ism region has been updated.
> +
> +\end{description}
> +
> +\devicenormative{\subsubsection}{Device configuration layout}{Device Types / ISM Device / Device configuration layout}
> +
> +The device MUST ensure that the \field{cdid} of the device on the same
> +communication domain is same. The \field{cdid} MUST be a version 4 UUID as
> +specified by \hyperref[intro:rfc4122]{[RFC4122]}.
> +
> +In the single communication domain, the device MUST ensure that the \field{devid}
> +is unique.
> +


Hi Xuan Zhou!

My understanding is the following: you goal for virtio-ism is that
it should be suitable for usage with SMC-D (much like the original ISM
device). Is that right?

If yes, then let us have a look at the following example. We have
two guests sitting on the same hypervisor: A and B. Both of the
guests have an rdma capable interface, a virtio-ism device and
traditional ISM device. So they could talk over SMC-R, SMC-D via
virtio and SMC-D via (PCI-)ISM. How would the CLC Proposal message
look like?

Where I am going with this? Either you need a novel way to
discover peers (probably before the usual way is employed)
or (probably preferably) you need to make this part of the
CLC stuff. What are your ideas with regards to this? How is
it supposed to work?

To get back to the things proposed here: the cdid is IMHO
a nice thing, and is functionally corresponding to the
(S)EID. But it is 16 byte wide, and I have no idea how
is it supposed to be used in the CLC handshake.

If this is really supposed to work with SMC and not just take
inspiration from it, I would like some insight from our
SMC experts (they are already on copy).

Regards,
Halil

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

