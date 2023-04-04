Return-Path: <virtio-dev-return-11971-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12E0AC6FD1D
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 13:20:22 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 452302AED0
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 13:20:21 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2A25C98641D
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 13:20:21 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 105AB9863EF; Tue,  4 Apr 2023 13:20:21 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5757D9863FA
	for <virtio-dev@lists.oasis-open.org>; Tue,  4 Apr 2023 13:20:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: YPWsBsRTPFuhpRVAPyO5pg-1
From: Cornelia Huck <cohuck@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>, virtio-dev@lists.oasis-open.org,
 virtio-comment@lists.oasis-open.org, shahafs@nvidia.com, Satananda Burla
 <sburla@marvell.com>
In-Reply-To: <20230404084126-mutt-send-email-mst@kernel.org>
Organization: Red Hat GmbH
References: <20230330225834.506969-1-parav@nvidia.com>
 <20230330225834.506969-9-parav@nvidia.com>
 <20230404032922-mutt-send-email-mst@kernel.org>
 <87jzysjd4g.fsf@redhat.com>
 <20230404084126-mutt-send-email-mst@kernel.org>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Tue, 04 Apr 2023 15:19:53 +0200
Message-ID: <878rf7kcna.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Subject: [virtio-dev] Re: [PATCH 08/11] transport-pci: Introduce virtio extended capability

On Tue, Apr 04 2023, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Tue, Apr 04, 2023 at 09:54:55AM +0200, Cornelia Huck wrote:
>> On Tue, Apr 04 2023, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>> 
>> > On Fri, Mar 31, 2023 at 01:58:31AM +0300, Parav Pandit wrote:
>> >> PCI device configuration space for capabilities is limited to only 192
>> >> bytes shared by many PCI capabilities of generic PCI device and virtio
>> >> specific.
>> >> 
>> >> Hence, introduce virtio extended capability that uses PCI Express
>> >> extended capability.
>> >> Subsequent patch uses this virtio extended capability.
>> >> 
>> >> Co-developed-by: Satananda Burla <sburla@marvell.com>
>> >
>> > What does it "Co-developed-by" mean exactly that Signed-off-by
>> > does not?
>> 
>> AIUI, "Co-developed-by:" is more akin to a second "Author:", i.e. to
>> give attribution. (Linux kernel rules actually state that any
>> "Co-developed-by:" must be followed by a "Signed-off-by:" for that
>> author, but we don't really do DCO here, the S-o-b is more of a
>> convention.)
>
>
> Actually, we might want to generally, to signify agreement to the IPR.
> How about adding this to our rules?  But in this case Satananda Burla is
> a TC member so yes, no problem.

Adding a s-o-b requirement is not a bad idea... do you want to propose
an update?


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

