Return-Path: <virtio-dev-return-11580-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2DC5C64EC4
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Mar 2023 16:47:06 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 1A2A52CAEC
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Mar 2023 16:47:06 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 10298986706
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Mar 2023 16:47:06 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 04D0D9866FE; Thu,  9 Mar 2023 16:47:06 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E33339866FB;
	Thu,  9 Mar 2023 16:47:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
Date: Thu, 9 Mar 2023 17:46:50 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Parav Pandit <parav@nvidia.com>,
        virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org,
        shahafs@nvidia.com, Halil Pasic <pasic@linux.ibm.com>
Message-ID: <20230309174650.7093f020.pasic@linux.ibm.com>
In-Reply-To: <20230305043948-mutt-send-email-mst@kernel.org>
References: <20230223054624.168042-1-parav@nvidia.com>
	<87a60z5wes.fsf@redhat.com>
	<20230301182207.23f995cd.pasic@linux.ibm.com>
	<20230301123044-mutt-send-email-mst@kernel.org>
	<87a60vmbub.fsf@redhat.com>
	<20230303023949-mutt-send-email-mst@kernel.org>
	<20230303224937.62fe64b9.pasic@linux.ibm.com>
	<20230305043948-mutt-send-email-mst@kernel.org>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: cEITGKoYdPIDHcZd1NO9d8mcqGWxh_BV
X-Proofpoint-GUID: 0qTHUfDFZpril3cpeIlaxLJdLKbHoPlg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-09_08,2023-03-09_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303090132
Subject: Re: [virtio-dev] Re: [virtio-comment] Re: [PATCH 0/3] Rename queue
 index to queue number

On Sun, 5 Mar 2023 04:51:54 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> > I don't think it would require an ABI change. We could just change the
> > queue names. AFAIK those are not part of the ABI. I don't think it would
> > be hard.  
> 
> Well at the moment this is the mapping:
> 
> RSS index -  queue name - virtio pci vqn
> 
> 0		receiveq1	0
> 1		receiveq2	2
> 2		receiveq3	4
> 3		receiveq4	6
> 

Agreed. My point was that the names receiveq1, ... , receiveqN are not
part of any ABI. There is no virtio-pci/mmio/ccw transport nor
virtio-net interface where one would get or put something like
"receiveq1". I.e by changing those names we would not break ABI.
I don't say we should. I agree it could confuse people. I just
say it is possible.


> 
> 
> 
> > BTW what speaks for "VQ number" over "VQ index"?
> > 
> > Regards,
> > Halil  
> 
> We use "vq index" when referring to queue_select.

Right!

> 
> But, we use "vq number" when talking about notifications.
> 

Yes and no!

"""
4.1.5.2 Available Buffer Notifications

When VIRTIO_F_NOTIFICATION_DATA has not been negotiated, the driver sends an available buffer notification to the device by writing the 16-bit virtqueue index of this virtqueue to the Queue Notify address.
"""

Here we say *index of this virtqueue*.

"""
QueueNotify
0x050
W
	

Queue notifier
Writing a value to this register notifies the device that there are new buffers to process in a queue.
"""
When VIRTIO_F_NOTIFICATION_DATA has not been negotiated, the value written is the queue index. 

as well uses "index", but

"""
2.7.23 Driver notifications

The driver is sometimes required to send an available buffer notification to the device.

When VIRTIO_F_NOTIFICATION_DATA has not been negotiated, this notification involves sending the virtqueue number to the device (method depending on the transport).
"""

here we have that "virqueue number".

> For fun MMIO calls the queue size field QueueNum
> 
> 
> So both number and index are taken by things other than the number,
> changing the meaning can confuse existing users.  Ideally we'd use some
> other new term to avoid confusion but I could not come up with one so
> far.  

Connie is usually pretty good at coming up with good names. Out of the
top of my head, I guess I could live with "identifier/id" or "key". I
would still prefer sticking to "index" but always spelling out the index
of what. I.e. "the index of the virtqueue", "index of the receive
queue" (RSS), "index specified by avail_event into the available ring",
etc. 

Please notice that for RSS I changed "index of the receive
virtqueue" to "index of the receive queue", because "index of the receive
virtqueue" is ambiguous. On one hand one read this as. I want the
unclassified packets placed into receiveq3. So receiveq3 is actually the
5-th virtqueue of the virtio-net device, i.e. the virtqueue with the
index (and vqn) 4. By following that reasoning (first identify the
virtqueue than take it's index) one would write 4 into the
unclassified_queue field, which would be wrong according to your
table. On the other hand, one could also reason like this. Since I
want the  unclassified packets in receiveq3, I have to write 2 into
unclassified_queue, because the "receive-virtqueue index" of
 * receiveq1 is 0, 
 * receiveq2 is 1, and of
 * receiveq3 is 3.
I.e. we are not talking about the index of virtqueue-index the virtqueue
but about the receivequeue-index of the receive queue. In other words
the conceptual array/table we are indexing into is not the array of
virtqueues, but the array of the receive queues.

To uniquely identify an element we need both the index (a value) and
the array/table that is being indexed. And I believe this is what we
need to improve on. I don't think calling indexes into the conceptual
array of receive queues (or receive virtqueues) "index of the receive
virtqueue", indexes into the conceptual array of virtqueues that belong
to a certain device a "vq number", indexes into the descriptor table
"descriptor keys", and indexes into the used rings "used ring element
ids" would really help -- to make an attempt at using reduction ad
absurdum ;)



> I feel there's less of a chance of a confusion between VQ size and
> its number. But it's not a strong prefrence, RSS is relatively young
> and it's the only incompatible user of index so far.

I don't understand why is RSS incompatible with "index".

Regards,
Halil

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

