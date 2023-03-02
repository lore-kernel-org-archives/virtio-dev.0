Return-Path: <virtio-dev-return-11362-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C62BC678D4
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 12:29:09 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 6E48B26A40
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 12:29:08 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6792898669A
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 12:29:08 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 57D61986678; Thu,  2 Mar 2023 12:29:08 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 45C76986674
	for <virtio-dev@lists.oasis-open.org>; Thu,  2 Mar 2023 12:29:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: hfQROYtwNJeadvzvmsOpDA-1
From: Cornelia Huck <cohuck@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: virtio@lists.oasis-open.org
In-Reply-To: <20230302111232.837604-1-mst@redhat.com>
Organization: Red Hat GmbH
References: <20230302111232.837604-1-mst@redhat.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Thu, 02 Mar 2023 13:28:55 +0100
Message-ID: <87ilfjmj5k.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Subject: [virtio-dev] Re: [virtio-comment] [PATCH] makediff: make it work for fresh checkout

On Thu, Mar 02 2023, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> 1st time one checks out our repo, latexdiff submodule
> is not initialized. Pass --init to update command
> to initialize it. It seems to be harmless if already
> initialized.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  makediff.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Cornelia Huck <cohuck@redhat.com>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

