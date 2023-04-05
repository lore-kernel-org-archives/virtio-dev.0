Return-Path: <virtio-dev-return-12025-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 854DAC77B6C
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 13:57:19 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id DFACF26A2D
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 13:57:18 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DA2459865CD
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 13:57:18 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id D015F9865A7; Wed,  5 Apr 2023 13:57:18 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BC2239865AA
	for <virtio-dev@lists.oasis-open.org>; Wed,  5 Apr 2023 13:57:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: drHUsvF7O1qmF2ABfm6qag-1
From: Cornelia Huck <cohuck@redhat.com>
To: virtio@lists.oasis-open.org
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Organization: Red Hat GmbH
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Wed, 05 Apr 2023 15:57:09 +0200
Message-ID: <87edoyqvnu.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Subject: [virtio-dev] [RFC] virtio 1.3 schedule

The virtio 1.2 spec has been released on July 1st, 2022, so I think we
should come up with a plan for the 1.3 release. Given that it took us
several months last time, we need to think about declaring freeze during
(northern hemisphere) summer if we want to have a release ready before
the end-of-year holiday season starts.

We have some things currently under discussion/review that we should
still consider for 1.3:

- vq index etc. naming cleanup
- admin vq
- virtio-video
- some things we deferred for 1.2 (see
  https://github.com/oasis-tcs/virtio-spec/issues?q=is%3Aissue+is%3Aopen+label%3Adeferred-in-v1.2-csprd01)
- other things that are not on my personal list (please mention whatever
  you think is important)

Please also keep in mind that 1.3 will not be the last virtio release,
and many projects like Linux or QEMU consider features stable and ready
for inclusion once the spec has hit the git tree, but not neccessarily a
virtio spec release.

That said, let me propose the following timeline:

- July 1st 2023: enter feature freeze; all proposed changes must at
  least have an open github issue that refers to a proposal on-list
- August 1st 2023: enter change freeze; everything needs to have been
  voted upon (i.e. we can start with preparations for a release like
  compiling the change log)
- at the same time, fork virtio-next, which can be used for development
  while we're working on the release
- August/September 2023: prepare draft, initiate initial voting etc.
- by September/October 2023: have the final 1.3 spec ready, voted upon,
  and released
- virtio-next can be merged into mainline, and we continue with business
  as usual

Thoughts? We might want to move things a tad earlier, but I don't think
we should push the schedule out much further.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

