Return-Path: <virtio-dev-return-13431-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98F90C04A6A
	for <virtio-dev@archiver.kernel.org>; Wed,  2 Aug 2023 13:58:06 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id CF443157EF0
	for <virtio-dev@archiver.kernel.org>; Wed,  2 Aug 2023 13:58:05 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A4C409866D9
	for <virtio-dev@archiver.kernel.org>; Wed,  2 Aug 2023 13:58:05 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 846DD98664C; Wed,  2 Aug 2023 13:58:05 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 70C5A986654
	for <virtio-dev@lists.oasis-open.org>; Wed,  2 Aug 2023 13:58:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: runEWftxN96GsTT3z2U6sA-1
From: Cornelia Huck <cohuck@redhat.com>
To: virtio@lists.oasis-open.org
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Organization: Red Hat GmbH
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Wed, 02 Aug 2023 15:58:01 +0200
Message-ID: <87a5v98s2e.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Subject: [virtio-dev] [virtio 1.3] Change freeze has started

As outlined in
https://lists.oasis-open.org/archives/virtio/202304/msg00036.html ff.,
as part of the release process for the 1.3 version of the virtio spec,
we have now entered change freeze. This means that the only changes to
the main virtio branch will now be those needed for the 1.3 release
(administrative and editorial.) We hope to have something ready for vote
in August.

For any changes for the next virtio release, please target the
virtio-1.4 branch, which will eventually merge back into the main
development branch once 1.3 has been released. (This next release might
not be called 1.4, but that should be inconsequential here.)

virtio 1.3 timeline:

Development

July 3rd: feature freeze (github issue
and change on list)

August 2nd: change freeze (all voted
upon)

virtio-next development branch opens              <---- we are here

August: prepare draft

August 31st (latest): draft voted upon by TC

September: public review period

October: addtl public review period, if needed

October (November): 1.3 released

merge virtio-next development branch


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

