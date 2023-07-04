Return-Path: <virtio-dev-return-13212-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B7ADEB64D9
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Jul 2023 06:56:49 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 0F2F84256B
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Jul 2023 06:56:49 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 064C3986566
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Jul 2023 06:56:49 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id EC03E986559; Tue,  4 Jul 2023 06:56:48 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CDA1E98655E
	for <virtio-dev@lists.oasis-open.org>; Tue,  4 Jul 2023 06:56:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: v9itGXhRNwOx23K7q02JFw-1
From: Cornelia Huck <cohuck@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Heng Qi <hengqi@linux.alibaba.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
 Parav Pandit <parav@nvidia.com>, Jason Wang <jasowang@redhat.com>, Yuri
 Benditovich <yuri.benditovich@daynix.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>
In-Reply-To: <20230703114640-mutt-send-email-mst@kernel.org>
Organization: Red Hat GmbH
References: <20230703152711.106008-1-hengqi@linux.alibaba.com>
 <20230703114640-mutt-send-email-mst@kernel.org>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Tue, 04 Jul 2023 08:56:34 +0200
Message-ID: <87cz18i2ql.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Subject: [virtio-dev] Re: [PATCH v21] virtio-net: support inner header hash

On Mon, Jul 03 2023, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Mon, Jul 03, 2023 at 11:27:11PM +0800, Heng Qi wrote:
>> 1. Currently, a received encapsulated packet has an outer and an inner header, but
>> the virtio device is unable to calculate the hash for the inner header. The same
>> flow can traverse through different tunnels, resulting in the encapsulated
>> packets being spread across multiple receive queues (refer to the figure below).
>> However, in certain scenarios, we may need to direct these encapsulated packets of
>> the same flow to a single receive queue. This facilitates the processing
>> of the flow by the same CPU to improve performance (warm caches, less locking, etc.).
>> 
>>                client1                    client2
>>                   |        +-------+         |
>>                   +------->|tunnels|<--------+
>>                            +-------+
>>                               |  |
>>                               v  v
>>                       +-----------------+
>>                       | monitoring host |
>>                       +-----------------+
>> 
>> To achieve this, the device can calculate a symmetric hash based on the inner headers
>> of the same flow.
>> 
>> 2. For legacy systems, they may lack entropy fields which modern protocols have in
>> the outer header, resulting in multiple flows with the same outer header but
>> different inner headers being directed to the same receive queue. This results in
>> poor receive performance.
>> 
>> To address this limitation, inner header hash can be used to enable the device to advertise
>> the capability to calculate the hash for the inner packet, regaining better receive performance.
>> 
>> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/173
>> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
>> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>> Reviewed-by: Parav Pandit <parav@nvidia.com>
>
> Cornelia last minute comments before I start a vote?

Please just go ahead.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

