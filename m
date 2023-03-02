Return-Path: <virtio-dev-return-11381-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B0EFC678D4
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 15:52:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 7DAFC2A81D
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 15:52:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 73366986682
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 15:52:28 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 66BDF986674; Thu,  2 Mar 2023 15:52:28 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5360B986676;
	Thu,  2 Mar 2023 15:52:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
Date: Thu, 2 Mar 2023 16:52:16 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>, virtio-dev@lists.oasis-open.org,
        cohuck@redhat.com, virtio-comment@lists.oasis-open.org,
        shahafs@nvidia.com, Yuri Benditovich <yuri.benditovich@daynix.com>,
        Halil Pasic
 <pasic@linux.ibm.com>
Message-ID: <20230302165216.1293d066.pasic@linux.ibm.com>
In-Reply-To: <20230227123751-mutt-send-email-mst@kernel.org>
References: <20230223054624.168042-1-parav@nvidia.com>
	<20230227123751-mutt-send-email-mst@kernel.org>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: sZheOvpZ2Rq6NoL5FGKsMco7yiO4rKFe
X-Proofpoint-ORIG-GUID: ggyfwPqC5zk_kU5d0T9o67AFf3l8K9uo
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-02_08,2023-03-02_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 priorityscore=1501 adultscore=0
 phishscore=0 bulkscore=0 clxscore=1011 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303020130
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH 0/3] Rename queue index to queue
 number

On Mon, 27 Feb 2023 12:39:39 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> > This series is on top of [2].
> > 
> > [1] https://github.com/oasis-tcs/virtio-spec/issues/163
> > [2] https://lists.oasis-open.org/archives/virtio-dev/202302/msg00527.html  
> 
> What about RSS description in net? That says:
> 
> description.tex:Field \field{unclassified_queue} contains the 0-based index of
> 
> is the index same as vq number? or something different?

It is something different. The full paragraph sound like this

"""
Field \field{unclassified_queue} contains the 0-based index of
the receive virtqueue to place unclassified packets in. Index 0 corresponds to receiveq1.
"""
Here follows the explanation.

Disclaimer: For a brief math background see [1] and [2].

Here the index set the set of natural numbers (which includes 0, the
neutral element for the addition operation).

The indexed set is the set of receive virtqueues, each member of that
set is associated with an unique member of the index set.

"""
\subsection{Virtqueues}\label{sec:Device Types / Network Device / Virtqueues}

\begin{description}
\item[0] receiveq1
\item[1] transmitq1
\item[\ldots]
\item[2(N-1)] receiveqN
\item[2(N-1)+1] transmitqN
\item[2N] controlq
\end{description}
"""

But, as seen above, we happen to also use an other index set for the
receive queues of an virtio-net device. I guess the intention is to use
these as names, in any case the set is { "receiveq1", "receiveq2", ... }
(yes, I'm a little sloppy here).

Thus we can say that:
* the virtqueue index 2*(N-1) 
* the recieve virtqueue index N-1, and the
* virtqueue name receiveqN
refer to the very same virtqueue (for each N > 0)

And it depends on the context which scheme do we use. As far as I
remember the names are not a part of any virtio interface. I.e. they
are only there for the convenience of the spec and the reader. We could
get rid of those. Although the possibility of corresponding to some
network device, Linux network device or tooling naming convention is also
to consider. But AFAIU Linux uses 0 based indexing for the rx and tx
queues. If the 1 based naming is really just constrained to the spec,
we can change it without problem.

Regards,
Halil



[1] https://en.wikipedia.org/wiki/Index_set
[2] https://en.wikipedia.org/wiki/Indexed_family


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

