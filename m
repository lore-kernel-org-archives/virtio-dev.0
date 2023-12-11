Return-Path: <virtio-dev-return-14137-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C6EC4167B
	for <virtio-dev@archiver.kernel.org>; Mon, 11 Dec 2023 16:51:19 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 8AEDC74851
	for <virtio-dev@archiver.kernel.org>; Mon, 11 Dec 2023 16:51:18 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7A9D89865AA
	for <virtio-dev@archiver.kernel.org>; Mon, 11 Dec 2023 16:51:18 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 6F9BB98648B; Mon, 11 Dec 2023 16:51:18 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5F2EB986492
	for <virtio-dev@lists.oasis-open.org>; Mon, 11 Dec 2023 16:51:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: Fvo6M9sIMteWO3XhHyj6Cw-1
From: Cornelia Huck <cohuck@redhat.com>
To: virtio@lists.oasis-open.org, virtio-comment@lists.oasis-open.org,
 virtio-dev@lists.oasis-open.org
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy
 Ross"
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Mon, 11 Dec 2023 17:51:11 +0100
Message-ID: <87o7ewhedc.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Subject: [virtio-dev] virtio 1.3: update

You may have been wondering what the current state of virtio 1.3 is; the
tl;dr is: we have to deal with some unfortunate delays, but it is really
nearing release now.

The current state
-----------------

virtio-1.3-csd01 (committee specification draft) has been out for public
review, and that 30 day period has just finished, with no additional
comments being received. This means we're ready to start the process to
get the committee specification draft released as an actual committee
specification.

The current issue
-----------------

Moving from CSD to CS requires that the TC votes on it. Unfortunately,
this will not be possible to fit into the remaining time before the
OASIS infrastructure downtime due to the upcoming migration. While we
hope that the new infrastructure will be in place quickly, it is
unlikely that we will be able to do a vote before many/most of the
voting members will be away for end-of-year holidays. [We actually need
*two* votes in the end, with each ballot open for seven days.]

The current plan
----------------

We'll do any preparation work (which should be really minor) now, and
start the voting process early in January. I'm reasonably confident
that, once triggered, we should have finished the process in early
February the latest.

Apologies again for the numerous delays the spec encountered along the
way, it's been pretty frustrating.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

