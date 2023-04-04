Return-Path: <virtio-dev-return-11960-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEF80C6FD1D
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 07:55:00 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 4A6822B038
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 07:55:00 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 32C009863ED
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 07:55:00 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 15AAF9863E4; Tue,  4 Apr 2023 07:55:00 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0113A9863E5
	for <virtio-dev@lists.oasis-open.org>; Tue,  4 Apr 2023 07:55:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: wk-BJ8bUPxaMHPCdo5X7NQ-1
From: Cornelia Huck <cohuck@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Parav Pandit <parav@nvidia.com>
Cc: virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org,
 shahafs@nvidia.com, Satananda Burla <sburla@marvell.com>
In-Reply-To: <20230404032922-mutt-send-email-mst@kernel.org>
Organization: Red Hat GmbH
References: <20230330225834.506969-1-parav@nvidia.com>
 <20230330225834.506969-9-parav@nvidia.com>
 <20230404032922-mutt-send-email-mst@kernel.org>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Tue, 04 Apr 2023 09:54:55 +0200
Message-ID: <87jzysjd4g.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Subject: [virtio-dev] Re: [PATCH 08/11] transport-pci: Introduce virtio extended capability

On Tue, Apr 04 2023, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Fri, Mar 31, 2023 at 01:58:31AM +0300, Parav Pandit wrote:
>> PCI device configuration space for capabilities is limited to only 192
>> bytes shared by many PCI capabilities of generic PCI device and virtio
>> specific.
>> 
>> Hence, introduce virtio extended capability that uses PCI Express
>> extended capability.
>> Subsequent patch uses this virtio extended capability.
>> 
>> Co-developed-by: Satananda Burla <sburla@marvell.com>
>
> What does it "Co-developed-by" mean exactly that Signed-off-by
> does not?

AIUI, "Co-developed-by:" is more akin to a second "Author:", i.e. to
give attribution. (Linux kernel rules actually state that any
"Co-developed-by:" must be followed by a "Signed-off-by:" for that
author, but we don't really do DCO here, the S-o-b is more of a
convention.)

>
>
>> Signed-off-by: Parav Pandit <parav@nvidia.com>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

