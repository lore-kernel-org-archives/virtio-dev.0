Return-Path: <virtio-dev-return-11680-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D83FCC6FD1D
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 15:11:54 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 246D61922EC
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 15:11:54 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0E71298644E
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 15:11:54 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 031EC983DFC; Tue, 21 Mar 2023 15:11:54 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E761B9863AC
	for <virtio-dev@lists.oasis-open.org>; Tue, 21 Mar 2023 15:11:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: q5MJKBftMuiRSA4Jqkmmzg-1
From: Cornelia Huck <cohuck@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>, virtio-dev@lists.oasis-open.org,
 virtio-comment@lists.oasis-open.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Parav Pandit <parav@nvidia.com>,
 Alvaro Karsz <alvaro.karsz@solid-run.com>, David Edmondson
 <david.edmondson@oracle.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>
In-Reply-To: <5d2fc59a-0cb9-6f4f-b853-e221e81c2272@linux.alibaba.com>
Organization: Red Hat GmbH
References: <20230312124628.8527-1-hengqi@linux.alibaba.com>
 <87cz53js85.fsf@redhat.com>
 <99f20219-931a-7b67-9768-0c2f8f32d16e@linux.alibaba.com>
 <87pm92moz9.fsf@redhat.com>
 <5d2fc59a-0cb9-6f4f-b853-e221e81c2272@linux.alibaba.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Tue, 21 Mar 2023 16:11:44 +0100
Message-ID: <87edpim95b.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Subject: [virtio-dev] Re: [virtio-comment] [PATCH v12] virtio-net: support the virtqueue
 coalescing moderation

On Tue, Mar 21 2023, Heng Qi <hengqi@linux.alibaba.com> wrote:

> May I bother you please to withdraw the vote, I will modify it according 
> to your opinion and release a new version!:)

Sure, done.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

