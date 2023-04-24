Return-Path: <virtio-dev-return-12356-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15184C7618E
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Apr 2023 13:29:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 43DD256D8
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Apr 2023 13:29:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 36A719863AC
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Apr 2023 13:29:32 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 28307986350; Mon, 24 Apr 2023 13:29:32 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 169A398634E;
	Mon, 24 Apr 2023 13:29:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
Date: Mon, 24 Apr 2023 15:29:19 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: Parav Pandit <parav@nvidia.com>
Cc: <mst@redhat.com>, <virtio-dev@lists.oasis-open.org>, <cohuck@redhat.com>,
        <sgarzare@redhat.com>, <virtio-comment@lists.oasis-open.org>,
        <shahafs@nvidia.com>, Halil Pasic
 <pasic@linux.ibm.com>
Message-ID: <20230424152919.70254ffa.pasic@linux.ibm.com>
In-Reply-To: <20230419014639.919458-5-parav@nvidia.com>
References: <20230419014639.919458-1-parav@nvidia.com>
 <20230419014639.919458-5-parav@nvidia.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: eq1q4WmGoUOQN6L8k9QDb-CS2D81Qejb
X-Proofpoint-ORIG-GUID: SYOmq6cW39__JvESD6LTo1_uEcRJdDzN
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-24_07,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 phishscore=0 clxscore=1015 impostorscore=0 adultscore=0 priorityscore=1501
 mlxscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=907 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304240118
Subject: [virtio-dev] Re: [virtio-comment] [PATCH v14 04/11] transport-pci: Avoid first
 vq index reference

On Wed, 19 Apr 2023 04:46:32 +0300
Parav Pandit <parav@nvidia.com> wrote:

> Drop reference to first virtqueue as it is already
> covered now by the generic section in first patch.
> 

TL;DR:

Acked-by: Halil Pasic <pasic@linux.ibm.com>

Rationale: 
---------
I agree, what a virtqueue index is should be described in a
single place instead all over the place. And further improvements can be done
on top of this series. 

Discussion:
-----------
Is it indeed covered now by the generic section in first patch?

In [1] you state the following: "There is nothing like a zero based
index. A VQ can be any u16 _number_ in range of 0 to 65534.
Number can also start from zero. So zero based index = zero based
number."

I don't really understand what do you mean by this, but I'm afraid
it is not consistent with my understanding. Can not be any number in
range of 0 to 65534.

Rather in general it depends on the device type, and on the device
how many queues it support. Let us call this number dev_vq_max. And
if dev_vq_max > N > 0 index is associated with a queue the N-1 index is
also associated with a queue.

Let me also note that the number of queues supported/provided by the
device is a matter of the device. For many devices the number of queues
is a constant given in the specification. A Network Device tells
its driver how may queues it supports via max_virtqueue_pairs,
Crypto Device via max_dataqueues, and Console Device via max_dataqueues.
The transports PCI also has num_queues which is documented as "The
device specifies the maximum number of virtqueues supported here." while
CCW and MMIO have no transport specific means to tell the driver about
the number of queues supported by the device. In any case, if the number
of queues provided by the device is N, each of those queues is uniquely
identified by exactly one index from the range [0..N-1]. Furthermore
the role a certain queue plays is determined by its index. E.g. for
the Console Device virtqueue identified by the index 3 is the "control
receiveq".

[1]
https://lore.kernel.org/virtio-comment/d62d2090-de0d-0ea6-5c85-ecf19ae828c7@nvidia.com/

[..]
>  
>  \begin{enumerate}
> -\item Write the virtqueue index (first queue is 0) to \field{queue_select}.
> +\item Write the virtqueue index to \field{queue_select}.
>  
>  \item Read the virtqueue size from \field{queue_size}. This controls how big the virtqueue is
>    (see \ref{sec:Basic Facilities of a Virtio Device / Virtqueues}~\nameref{sec:Basic Facilities of a Virtio Device / Virtqueues}). If this field is 0, the virtqueue does not exist.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

